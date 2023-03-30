//
//  ListViewController.swift
//  Chapter05-CustomPlist
//
//  Created by 이나경 on 2023/03/30.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var accountList = [String]()
    
    // 메인 번들에 정의한 PList 내용을 저장할 딕셔너리
    var defaultPList: NSDictionary!
    
    @IBOutlet var account: UITextField!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var gender: UISegmentedControl!
    
    @IBOutlet var married: UISwitch!
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex // 0이면 남자, 1이면 여자
                
        // 저장 로직 시작
        let customPlist = "\(self.account.text!).plist" // 읽어올 파일명
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        
        let value = sender.isOn // true면 기혼 false면 미혼
        
        // 저장 로직
        let customPlist = "\(self.account.text!).plist" // 읽어올 파일명
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
        
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
        print("custom plist=\(plist)") // 파일이 저장된 경로 확인
    }

    override func viewDidLoad() {
        // 메인 번들에 UserInfo.plist가 포함되어 있으면 이를 읽어와 메인 딕셔너리에 담는다.
        if let defaultPListPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") {
            self.defaultPList = NSDictionary(contentsOfFile: defaultPListPath)
        }
            
        let plist = UserDefaults.standard

        // 1) 사용자 계정의 값이 비어 있다면 값을 설정하는 것을 막는다.
        if (self.account.text?.isEmpty)! {
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
        
        // 1
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
            let customPlist = "\(account).plist" // 읽어올 파일명
            
            // 2
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) // 2-1
            
            let path = paths[0] as NSString // 2-2
            let clist = path.strings(byAppendingPaths: [customPlist]).first! // 2-3
            let data = NSDictionary(contentsOfFile: clist) // 3
            
            self.name.text = data?["name"] as? String // 4
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0 // 5
            self.married.isOn = data?["married"] as? Bool ?? false // 6
        }
        
        let picker = UIPickerView()
        
        // 1) 피커 뷰의 델리게이터 객체 지정
        picker.delegate = self
        
        // 2) account 텍스트 필드 입력 방식을 가상 키보드 대신 피커 뷰로 설정
        self.account.inputView = picker
        
        // 툴 바 객체 정의
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = UIColor.lightGray
        
        // 액세서리 뷰 영역에 툴 바를 표시
        self.account.inputAccessoryView = toolbar
        
        // 툴 바에 들어갈 닫기 버튼
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        // 신규 계정 등록 버튼
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        // 가변 폭 버튼 정의
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        // 버튼을 툴 바에 추가
        toolbar.setItems([new, flexSpace, done], animated: true)
        
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountList = accountlist
        
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
        }
        
        // 내비게이션 바에 new Account 메소드와 연결된 버튼을 추가한다.
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
        
    }
    
    @objc func pickerDone(_ sender: Any) {
        self.view.endEditing(true)
        
        // 선택된 계정에 대한 커스텀 프로퍼티 파일을 읽어와 세팅한다.
        if let _account = self.account.text {
            let customPlist = "\(_account).plist" // 읽어올 파일명
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
    }
    
    @objc func newAccount(_ sender: Any) {
        self.view.endEditing(true) // 일단 열려 있는 입력용 뷰부터 닫아준다.
        
        // 알림창 객체 생성
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
        
        // 입력 폼 추가
        alert.addTextField() {
            $0.placeholder = "ex) lisayuki@love.com"
        }
        
        // 버튼 및 액션 정의
        alert.addAction(UIAlertAction(title: "OK", style: .default) {
            (_) in
            if let account = alert.textFields?[0].text {
                // 계정 목록을 배열에 추가한다.
                self.accountList.append(account)
                // 계정 텍스트 필드에 표시한다.
                self.account.text = account
                
                // 컨트롤 값을 모두 초기화한다.
                self.name.text = ""
                self.married.isOn = false
                self.gender.selectedSegmentIndex = 0
                
                // 계정 목록을 통째로 저장한다.
                let plist = UserDefaults.standard
                plist.set(self.accountList, forKey: "accountlist")
                plist.set(account, forKey: "selectedAccount")
                plist.synchronize()
            }
        })
        // 알림창 오픈
        self.present(alert, animated: false, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return super.numberOfSections(in: tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && !(self.account.text?.isEmpty)! {
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
            
            alert.addTextField() {
                $0.text = self.name.text
            }
            
            alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
                let value = alert.textFields?[0].text
                
                // 저장 로직 시작
                let customPlist = "\(self.account.text!).plist" // 읽어올 파일명
                
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary(dictionary: self.defaultPList)
                
                data.setValue(value, forKey: "name")
                data.write(toFile: plist, atomically: true)
                
                self.name.text = value
                
                self.gender.isEnabled = true
                self.married.isEnabled = true
            })
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    // 생성할 컴포넌트의 개수를 정의한다.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 우리가 구현할 피커 뷰는 계정 목록 하나만 표시하면 되기 때문
    }
    
    // 지정된 컴포넌트가 가질 목록의 길이를 정한다.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountList.count
    }
    
    // 지정된 컴포넌트의 목록 각 행에 출력될 내용을 정의한다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountList[row]
    }
    
    // 지정된 컴포넌트의 목록 각 행을 사용자가 선택했을 때 실행할 액션을 정의한다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 선택된 계정값을 텍스트 필드에 입력
        let account = self.accountList[row]
        self.account.text = account
        
        // 사용자가 계정을 생성하면 이 계정을 선택한 것으로 간주하고 저장
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
    }
}
