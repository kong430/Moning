//
//  AlarmViewController.swift
//  Moning
//
//  Created by Yun Jeong on 2020/06/23.
//  Copyright © 2020 이제인. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmViewController: UIViewController {
    

    @IBOutlet weak var tableView1: UITableView!
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
       func sendNotification(seconds: Double) {
           let notificationContent = UNMutableNotificationContent()

           notificationContent.title = "알림 테스트"
           notificationContent.body = "이것은 알림을 테스트 하는 것이다"

           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
           let request = UNNotificationRequest(identifier: "testNotification",
                                               content: notificationContent,
                                               trigger: trigger)

           userNotificationCenter.add(request) { error in
               if let error = error {
                   print("Notification Error: ", error)
               }
           }
       }

}
