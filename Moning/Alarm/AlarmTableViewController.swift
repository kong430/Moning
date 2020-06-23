//
//  AlarmTableViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/05/18.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
import UserNotifications

var materialList = [String]()
var switchModeList = [Bool]()
//var alarmTimes = [Date(),Date()]
var materialAlarmTime : Date?
var weatherAlarmTime : Date?
var loadedTime : Int = 0

class AlarmTableViewController: UITableViewController {
    
    var isOpenPickerView1 = false
    var isOpenPickerView2 = false
    

    override func viewDidLoad() {
        requestNotificationAuthorization()
        super.viewDidLoad()
        loadAllData()
        
    }
    /*override func viewDidAppear(_ animated: Bool) {
        saveAllData()
        tableView.reloadData()
    }*/
    
    override func viewDidDisappear(_ animated: Bool) {
        saveAllData()
        sendNotification()
        //tableView.reloadData()
    }
    /*
    override func viewWillAppear(_ animated: Bool) {
        loadAllData()
    }
 */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    //notification 부분
    let userNotificationCenter = UNUserNotificationCenter.current()

    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }

    }
    //test용 콘텐츠
    func sendNotification() {
        loadAllData()
        let notificationContent1 = UNMutableNotificationContent()
        let notificationContent2 = UNMutableNotificationContent()
        var alarmMList = [String]()
        for i in 0..<switchModeList.count{
            if switchModeList[i]{
                alarmMList.append(materialList[i])
            }
        }
        var str : String
        if alarmMList.count == 0{
            str = "챙길 준비물이 없어요."
        }
        else{
            str = alarmMList[0]
            for i in 1..<alarmMList.count{
                str += ", " + alarmMList[i]
            }
        }

        notificationContent1.title = "오늘 들고 나갈 것 챙겼닝?"
        notificationContent1.body = str
        let calendar1 = Calendar.current
        let components1 = calendar1.dateComponents([.hour, .minute], from: materialAlarmTime ?? Date())
        
        //let trigger1 = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let trigger1 = UNCalendarNotificationTrigger(dateMatching:components1 , repeats: true)
        let request1 = UNNotificationRequest(identifier: "materialNotification",
                                            content: notificationContent1,
                                            trigger: trigger1)
        userNotificationCenter.add(request1) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
        
        notificationContent2.title = "오늘의 날씨가 궁금하닝?"
        notificationContent2.body = "궁금하다면 모닝 앱에서 확인해봐!"
        //let calendar2 = Calendar.current
        let components2 = calendar1.dateComponents([.hour, .minute], from: weatherAlarmTime ?? Date())
        let trigger2 = UNCalendarNotificationTrigger(dateMatching:components2 , repeats: true)
        let request2 = UNNotificationRequest(identifier: "weatherNotification",
                                            content: notificationContent2,
                                            trigger: trigger2)

        userNotificationCenter.add(request2) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
 
    }
    // MARK: - Table view data source
    //
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return materialList.count
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 0
        }
    }
        
    

    @objc func switchChanged(_ sender : UISwitch){
        switchModeList[sender.tag] = sender.isOn
    }
    @objc func dateChanged(_ sender : UIDatePicker){
        if sender.tag == 2{
            materialAlarmTime = sender.date
        }
        else if sender.tag == 4{
            weatherAlarmTime = sender.date
        }
        self.tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "materialCell", for: indexPath) as! AlarmCustomCell

        /*let nameList = UserDefaults.standard.stringArray(forKey: "nameKey")
        let switchList = UserDefaults.standard.array(forKey: "switchKey")
        print(nameList)
 */
            cell.alarmNameLabel?.text = materialList[indexPath.row]
            cell.alarmSwitch.isOn = switchModeList[indexPath.row]
        //switch저장 문제
            cell.alarmSwitch.setOn(switchModeList[indexPath.row], animated: !switchModeList[indexPath.row])
            cell.alarmSwitch.tag = indexPath.row
            cell.alarmSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            
            if cell.alarmNameLabel.adjustsFontSizeToFitWidth == false{
                cell.alarmNameLabel.adjustsFontSizeToFitWidth = true
            }
            return cell
        case 1:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "mTimecell", for: indexPath)
            //수정하기
            
            let df = DateFormatter()
            df.dateStyle = .none
            df.timeStyle = .short
            cell1.textLabel?.text = "준비물 알림 시간 설정"
            cell1.detailTextLabel?.text = df.string(from: materialAlarmTime ?? Date())
            /*if materialAlarmTime == nil{
                materialAlarmTime = Date()
                cell1.detailTextLabel?.text = df.string(from: materialAlarmTime ?? Date())
            }else{
                cell1.detailTextLabel?.text = df.string(from: materialAlarmTime ?? Date())
            }*/
            
            return cell1
            
        case 2:
            //datepicker 저장 문제
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "mDatepickercell", for: indexPath) as! DatePickerCell
            var datePicker = cell2.datePicker
            datePicker?.tag = indexPath.section
            datePicker?.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
            //weatherAlarmTime = datePicker?.date as! Date
            return cell2
            
        case 3:
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "wTimecell", for: indexPath)
            //수정하기
            
            let df = DateFormatter()
            df.dateStyle = .none
            df.timeStyle = .short
            cell3.textLabel?.text = "추천 준비물 알림 시간 설정"
            
            /*if weatherAlarmTime == nil{
                weatherAlarmTime = Date()
                cell3.detailTextLabel?.text = df.string(from: weatherAlarmTime ?? Date())
            }else{
                cell3.detailTextLabel?.text = df.string(from: weatherAlarmTime ?? Date())
            }*/
            cell3.detailTextLabel?.text = df.string(from: weatherAlarmTime ?? Date())
            
            return cell3
            
        case 4:
            let cell4 = tableView.dequeueReusableCell(withIdentifier: "wDatepickercell", for: indexPath) as! SecondDatePickerCell
            var datePicker2 = cell4.datePicker
            datePicker2?.tag = indexPath.section
            datePicker2?.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
            return cell4
            
            
        default:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            return cell2
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            let row = materialList[indexPath.row]
            let height = CGFloat(60 + (row.count/30) * 20)
            
            return height
        case 1:
            return 60
        case 2:
            return self.isOpenPickerView1 ? 160 : 0
        case 3:
            return 60
        case 4:
            return self.isOpenPickerView2 ? 160 : 0
            
            
        default:
            return 60
    
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 1:
            self.isOpenPickerView1 = !isOpenPickerView1
            self.tableView.reloadSections(IndexSet(2...2), with: .fade)
            break;
        case 3:
            self.isOpenPickerView2 = !isOpenPickerView2
            self.tableView.reloadSections(IndexSet(2...2), with: .fade)
            break;
        default:
            break;
        }
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "준비물 입력", message: "추가할 준비물을 입력해주세요", preferredStyle: .alert)
        alert.addTextField(){ (tf) in
            tf.placeholder = "내용을 입력하세요."
        }
        //3.OK 버튼 객체를 생성 : 아직 알림창 객체에 버튼이 등록되지않은 상태
        let ok  = UIAlertAction(title: "OK", style: .default){ (_) in
            //4.알림창의 0번째 입력필드에 값이 있다면
            if let title = alert.textFields?[0].text{
                //5.배열에 입력된 값을 추가하고 테이블을 갱신
                materialList.append(title)
                switchModeList.append(true)
                
                for material in materialList{
                    print(material)
                }
                for switchm in switchModeList{
                    print(switchm)
                }
                self.tableView.reloadData()
            }
        }
        //취소 버튼 객체를 생성 : 아직 알림창 객체에 버튼이 등록되지 않은 상태
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        
        //6.알림창 객체에 버튼 객체를 등록한다.
        alert.addAction(ok)
        alert.addAction(cancel)
        
        //7.알림창을 띄운다.
        self.present(alert, animated: false)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if editingStyle == .delete {
                // Delete the row from the data source
                materialList.remove(at: indexPath.row)
                switchModeList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .bottom)
            }
        }
        else {}
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "뭐가 필요하닝?"
        case 1:
            return "언제 알림받고 싶닝?"
        case 3:
            return "오늘이 궁금하닝?"
        default :
            return ""
            
        
        }
    }
    
    func saveAllData(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(materialList,forKey: "materialKey")
        userDefaults.set(switchModeList,forKey : "switchKey")
        userDefaults.set(materialAlarmTime,forKey: "materialTimeKey")
        userDefaults.set(weatherAlarmTime,forKey: "weatherTimeKey")
        //userDefaults.set(alarmTimes,forKey: "alarmKey")
        userDefaults.synchronize()
        
        loadedTime += 1
    }
    
    func loadAllData(){
        /*if loadedTime == 0{
            materialList = [String]()
            switchModeList = [Bool]()
            materialAlarmTime = Date()
            weatherAlarmTime = Date()
        }*/
        
        let userDefaults = UserDefaults.standard
        let mList = userDefaults.stringArray(forKey: "materialKey") ?? [String]()
        let sList = userDefaults.array(forKey: "switchKey") as? [Bool] ?? [Bool]()
        let mDate = userDefaults.object(forKey: "materialTimeKey")
        let wDate = userDefaults.object(forKey: "weatherTimeKey")
        //let aList = userDefaults.array(forKey: "alarmKey") as? [Date] ?? [Date]()
        materialList = []
        switchModeList = []
        for i in 0..<mList.count{
            materialList.append(mList[i])
        }
        //materialList = mList
        for i in 0..<sList.count{
            switchModeList.append(sList[i])
        }
        //에러터짐여
        materialAlarmTime = mDate as! Date
        weatherAlarmTime = wDate as! Date
        
            //loadedTime += 1
        
    }
    /*
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 || section == 4{
            return 0
        }
        else {
            return 30
        }
    }
 */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
