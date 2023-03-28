//
//  SideBarTableViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 이나경 on 2023/03/27.
//

import UIKit

class SideBarTableViewController: UITableViewController {
    
    // 메뉴 제목 배열
    let titles = [
        "메뉴 01",
        "메뉴 02",
        "메뉴 03",
        "메뉴 04",
        "메뉴 05"
    ]
    
    // 메뉴 아이콘 배열
    let icons = [
        UIImage(named: "icon01"),
        UIImage(named: "icon02"),
        UIImage(named: "icon03"),
        UIImage(named: "icon04"),
        UIImage(named: "icon05")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1) 계정 정보를 표시할 레이블 객체를 정의한다.
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        accountLabel.text = "lnk12888@naver.com"
        accountLabel.textColor = UIColor.white
        accountLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        // 2) 테이블 뷰 상단에 표시될 뷰를 정의한다.
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = UIColor.brown
        v.addSubview(accountLabel)
        
        // 3) 생성한 뷰 v를 테이블 헤더 뷰 영역에 등록한다.
        self.tableView.tableHeaderView = v
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 재사용 큐를 사용하지 않아도 되는 경우 (스크롤하지 않아도 될 정도로 메뉴가 많지 않을 때)
        /*let cell = UITableViewCell() // 재사용 큐 대신 매번 셀을 새로 생성한다.
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell*/
        
        // 재사용 큐를 사용할 경우
        // 1) 재사용 큐로부터 테이블 셀을 꺼내 온다. 2) 재사용 큐에 menucell 키로 등록된 테이블 뷰 셀이 없다면 새로 추가한다.
        let id = "menucell" // 재사용 큐에 등록할 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 3) 타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 4) 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
    
}
