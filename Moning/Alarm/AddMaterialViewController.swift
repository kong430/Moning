//
//  AddMaterialViewController.swift
//  Moning
//
//  Created by Yun Jeong on 2020/06/08.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit

class AddMaterialViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var checkList : [String] = ["손풍기","핫팩","마스크","선글라스","선크림","우산","목도리","충전기", "이어폰"]
    var selectedMaterials = [String]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "materialCell", for: indexPath)
        cell.textLabel!.text = checkList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectedRowAt indexPath: IndexPath){
        let selectedMaterial = checkList[indexPath.row]
        selectedMaterials.append(contentsOf: selectedMaterial.map(String.init))
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkList.count
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
