//
//  FirstViewController.swift
//  Chapter03-CSTabBar
//
//  Created by 이나경 on 2023/03/24.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 150, width: 100, height: 30))
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.text = "첫 번째 화면"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.sizeToFit()
        label.center.x = self.view.frame.width / 2
        
        self.view.addSubview(label)

        // Do any additional setup after loading the view.
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
