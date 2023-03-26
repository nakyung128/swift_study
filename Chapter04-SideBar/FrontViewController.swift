//
//  FrontViewController.swift
//  Chapter04-SideBar
//
//  Created by 이나경 on 2023/03/27.
//

import UIKit

class FrontViewController: UIViewController {

    @IBOutlet var sidBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 메인 컨트롤러의 참조 정보를 가져온다.
        if let revealVC = self.revealViewController() {
            // 버튼이 클릭될 때 메인 컨트롤러에 정의된 revealToggle(_:)을 호출하도록 정의한다.
            // 일반 버튼이 아니라 BarButtonItem 객체이기 때문에 addTarget을 사용할 수 없다.
            self.sidBarButton.target = revealVC
            self.sidBarButton.action = #selector(revealVC.revealToggle(_:))
            
            // 제스처를 뷰에 추가한다.
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
