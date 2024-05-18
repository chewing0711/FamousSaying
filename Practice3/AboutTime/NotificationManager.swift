//
//  alamTrigger.swift
//  Practice3
//
//  Created by 박민규 on 5/10/24.
//

import SwiftUI
import UserNotifications  // 컴퓨터가 알림 도구를 사용할 수 있도록 도와줍니다.
import SwiftData

class TimeListViewModel: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    
    @Query var times: [Time]  = [Time(hour: 1, minute: 1), Time(hour: 2, minute: 2)]
    
    
    private func alertForDuplicate() {
        // Alert는 SwiftUI View에서 처리합니다.
    }
}

func sortTimes(times: [Time]) -> [Time] {
    return times.sorted { (first, second) -> Bool in
        if first.isAM != second.isAM {
            return first.isAM  // 오전인 경우 true, 오후인 경우 false로 오전을 먼저 정렬합니다.
        } else if first.hour % 12 != second.hour % 12 {
            return (first.hour % 12) < (second.hour % 12)  // 12시간 기준 시간으로 비교합니다.
        } else {
            return first.minute < second.minute  // 분으로 정렬합니다.
        }
    }
}

func scheduleNotification(time: Time) {
    
    let content = UNMutableNotificationContent()
    content.title = "알림"
    content.body = "설정된 시간입니다: \(time.hour)시 \(time.minute)분"
    content.sound = UNNotificationSound.default
    
    var dateComponents = DateComponents()
    
    dateComponents.hour = time.hour
    dateComponents.minute = time.minute
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    let request = UNNotificationRequest(identifier: time.id, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { (error) in
        if let error = error {
            print("Error scheduling notification: \(error)")
        }
    }
}