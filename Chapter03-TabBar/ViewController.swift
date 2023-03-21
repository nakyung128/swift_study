//
//  ViewController.swift
//  Chapter03-TabBar
//
//  Created by 이나경 on 2023/03/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        // 2
        title.text = "첫 번째 탭"
        title.textColor = UIColor.red // 텍스트 빨간색으로
        title.textAlignment = .center // 중앙 정렬
        title.font = UIFont.boldSystemFont(ofSize: 14) // 폰트는 System Font, 14pt
        
        // 3
        title.sizeToFit() // 콘텐츠의 내용에 맞게 레이블 크기 변경
        
        // 4
        title.center.x = self.view.frame.width / 2 // x축의 중앙에 오도록 한다
        
        // 5
        self.view.addSubview(title)
        
        // 탭 바 아이템에 커스텀 이미지를 등록하고 탭 이름을 입력한다.
        /*self.tabBarItem.image = UIImage(named: "calendar.png")
        self.tabBarItem.title = "calendar"*/
    }
    
    override func touchesEnded (_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
        //tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true
        UIView.animate(withDuration: TimeInterval(0.15), animations: {
            // alpha값이 0이면 1로, 1이면 0으로 바꾸어 준다.
            // 호출될 때마다 점점 투명해졌다가 점점 진해질 것이다.
            tabBar?.alpha = ( tabBar?.alpha == 0 ? 1 : 0 )
        })
    }


}

