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
    
    @Query var times: [Time]
    
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
var stc = Sentence()
func scheduleNotification(time: Time) {
    stc.bringSentence()
    
    let content = UNMutableNotificationContent()
    content.title = "당신의 마음에 한 마디"
    
    var bodyMsg = ""
    for i in 0..<Sentence.msg.count {
        
        if i == 0 {
            bodyMsg += Sentence.msg[i]
            bodyMsg += "\n- "
        }
        else if i == 1 {
            bodyMsg += (Sentence.msg[i] + " -")
        }
        
    }
    content.body = bodyMsg
    
    // content.sound = UNNotificationSound.default
    
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

func cancelNotification(identifier: String) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
}
