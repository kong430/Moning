//
//  PlaceViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/25.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
var placeList = [String]()
var locationList = [String]()

class PlaceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var placeListTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        placeListTable.delegate = self
        placeListTable.dataSource = self
    }
    
    // 뷰가 노출될 때마다 리스트의 데이터를 다시 불러옴
    override func viewWillAppear(_ animated: Bool) {
        placeListTable.reloadData()
    }
    
    // view가 view 계층구조에 추가 됨을 viewContoller에 notify 함
    override func viewDidAppear(_ animated: Bool) {
        // 테이블의 데이터를 새로 업데이트 함
        placeListTable.reloadData()
    }
 
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        
        cell.textLabel?.text = placeList[indexPath.row]
        cell.detailTextLabel?.text = locationList[indexPath.row]
        //cell.detailTextLabel?.text = placeList[indexPath.row]
        return cell
    }
}

