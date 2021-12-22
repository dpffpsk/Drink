//
//  UNNotificationCenter.swift
//  Drink
//
//  Created by 이니텍 on 2021/12/21.
//

import Foundation
import UserNotifications


extension UNUserNotificationCenter {
    func addNotificationRequest(by alert: Alert) {
        //알림 내용 설정
        let content = UNMutableNotificationContent()
        
        content.title = "물 마실 시간이예요"
        content.body = "세계보건기구(WHO)가 권장하는 하루 물 섭취량은 1.5~2리터입니다."
        content.sound = .default
        content.badge = 1
        
        //언제 알림 보낼지 트리거 설정
        let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
        
        //알림 요청 설정
        let request = UNNotificationRequest(identifier: alert.id, content: content, trigger: trigger)
        self.add(request, withCompletionHandler: nil)
    }
}
