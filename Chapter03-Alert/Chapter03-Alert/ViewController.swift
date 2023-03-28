//
//  ViewController.swift
//  Chapter03-Alert
//
//  Created by 이나경 on 2023/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 알림창 버튼 생성
        let defaultAlertBtn = UIButton(type: .system)
        defaultAlertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlertBtn.center.x = self.view.frame.width / 2
        defaultAlertBtn.setTitle("기본 알림창", for: .normal)
        defaultAlertBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(defaultAlertBtn)
    }
    
    @objc func defaultAlert(_ sender: Any) {
        // 1) 알림창을 정의한다.
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 2) 버튼을 정의한다.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        // 3) 버튼을 알림창에 추가한다.
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        // 알림창에 들어갈 뷰 컨트롤러
        let v = ViewController()
        v.view.backgroundColor = UIColor.red
        
        // 알림창에 뷰 컨트롤러를 등록한다.
        alert.setValue(v, forKey: "contentViewController")
        
        // 4) 알림창을 화면에 표시한다.
        self.present(alert, animated: false)
    }
}

