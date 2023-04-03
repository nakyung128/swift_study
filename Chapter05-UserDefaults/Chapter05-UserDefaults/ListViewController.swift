//
//  ListViewController.swift
//  Chapter05-UserDefaults
//
//  Created by 이나경 on 2023/03/29.
//

import UIKit

class ListViewController: UITableViewController {

    @IBOutlet var name: UILabel!
    
    @IBOutlet var gender: UISegmentedControl!
    
    @IBOutlet var married: UISwitch!
    
    @IBAction func edit(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
        
        alert.addTextField() {
            $0.text = self.name.text
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
            let value = alert.textFields?[0].text
            
            let plist = UserDefaults.standard
            plist.setValue(value, forKey: "name")
            plist.synchronize()
            
            self.name.text = value
        })
        self.present(alert, animated: false, completion: nil)
    }
    
    public enum GenderType: Int {
        case male = 0
        case femail = 1
        
        func getGenderValue(value: Int) -> GenderType? {
            switch value {
            case 0:
                return .male
            case 1:
                return .femail
            default:
                return nil;
            }
        }
        
        func getGenderCode(value: GenderType) -> Int {
            return value.rawValue
        }
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex
        
        let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "gender") // "gender"라는 키로 값을 저장한다.
        plist.synchronize() // 동기화
    }
    
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn // true면 기혼 false면 미혼
        
        let plist = UserDefaults.standard
        plist.set(value, forKey: "married")
        plist.synchronize()
    }
    
    override func viewDidLoad() {
        let plist = UserDefaults.standard
        
        // 저장된 값을 꺼내어 각 컨트롤에 설정한다.
        self.name.text = plist.string(forKey: "name")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        self.married.isOn = plist.bool(forKey: "married")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return super.numberOfSections(in: tableView)
    }

    // 화면에 표시될 행의 개수를 반환하는 메소드로,
    // 화면에 표시할 행의 수와 반환하는 값이 항상 정확히 일치해야 한다.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 부모 클래스에 정의된 메소드를 이용해 테이블 뷰의 행 개수를 처리
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { // 첫 번째 셀이 클릭되었을 때
            // 입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다.
            let alert = UIAlertController(title: nil, message: "이름을 입력해 주세요", preferredStyle: .alert)
            
            // 입력 필드 추가
            alert.addTextField() {
                $0.text = self.name.text // name 레이블의 텍스트를 입력 폼에 기본값으로 넣어 준다.
            }
            
            // 입력 필드 추가
            alert.addAction(UIAlertAction(title: "OK", style: .default) { (_) in
                // 사용자가 ok 버튼을 누르면 입력 필드에 입력된 값을 저장한다.
                let value = alert.textFields?[0].text
                
                let plist = UserDefaults.standard
                plist.set(value, forKey: "name")
                plist.synchronize()
                
                // 수정된 값을 이름 레이블에도 적용한다.
                self.name.text = value
            })
            
            // 알림창을 띄운다.
            self.present(alert, animated: false, completion: nil)
        }
    }*/

}
