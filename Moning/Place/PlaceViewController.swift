//
//  PlaceViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/25.
//  Copyright © 2020 이제인. All rights reserved.
//
import UIKit
var placeList = [PlaceList]()
//var placeList = [String]()
//var locationList = [String]()
class PlaceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var placeListTable: UITableView!

    override func viewDidLoad() {
        /*for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: "items")
        }*/
        super.viewDidLoad()
        placeListTable.delegate = self
        placeListTable.dataSource = self
        
        loadAllData()
    }
    
    // 뷰가 노출될 때마다 리스트의 데이터를 다시 불러옴
    override func viewWillAppear(_ animated: Bool) {
        placeListTable.reloadData()
    }
    
    // view가 view 계층구조에 추가 됨을 viewContoller에 notify 함
    override func viewDidAppear(_ animated: Bool) {
        // 테이블의 데이터를 새로 업데이트 함
        saveAllData()
        placeListTable.reloadData()
    }
 
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        
        cell.textLabel?.text = placeList[indexPath.row].place
        cell.detailTextLabel?.text = placeList[indexPath.row].location
        //cell.detailTextLabel?.text = placeList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            placeList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            UserDefaults.standard.removeObject(forKey: "items")
            saveAllData()
            placeListTable.reloadData()
        }
    }
    
    //userdefault 저장
    func saveAllData() {
        let data = placeList.map {
            [
                "place": $0.place,
                "location": $0.location,
                "latitude": $0.latitude,
                "longitude": $0.longitude
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "items") // 키, value 설정
        userDefaults.set(data, forKey: "items")
        userDefaults.synchronize()  // 동기화
    }
    
    // userDefault 데이터 불러오기
    func loadAllData() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
            return
        }
        
        //print(data.description)
        
        // list 배열에 저장하기
        //print(type(of: data))
        placeList = data.map {
            let place = $0["place"] as? String
            let location = $0["location"] as? String
            let latitude = $0["latitude"] as? Double
            let longitude = $0["longitude"] as? Double
            
            return PlaceList(place: place!, location: location!, latitude: latitude!, longitude: longitude!)
        }
    }
}
