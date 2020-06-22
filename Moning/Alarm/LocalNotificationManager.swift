//
//  LocalNotificationManager.swift
//  Moning
//
//  Created by Yun Jeong on 2020/06/22.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import UserNotifications

struct Notification {
    var id:String
    var title:String
    var datetime:DateComponents
}
class LocalNotificationManager
{
    
    var notifications = [Notification]()
    
    

}



