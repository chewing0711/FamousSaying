//
//  alamTrigger.swift
//  Practice3
//
//  Created by 박민규 on 5/10/24.
//

import SwiftUI
import UserNotifications  // 컴퓨터가 알림 도구를 사용할 수 있도록 도와줍니다.

class TimeListViewModel: ObservableObject {
    @Published var times = [Time(hour: 0, minute: 1), Time(hour: 14, minute: 1), Time(hour: 9, minute: 30), Time(hour: 12, minute: 0)]
    
    
    private func alertForDuplicate() {
        // Alert는 SwiftUI View에서 처리합니다.
    }
    
    func addTime(time: Time) {
        if self.times.contains(where: { $0.id == time.id }) {
            // 중복된 ID가 있다면 알림
            DispatchQueue.main.async {
                withAnimation {
                    self.alertForDuplicate()
                }
            }
        } else {
            // 중복된 ID가 없다면 푸시 알림 설정
            self.times.append(time)
            scheduleNotification(time: time)
        }
    }
    func removeTime(at offsets: IndexSet) {
            times.remove(atOffsets: offsets)
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

import UIKit
import SwiftData


class Time {
    let id: String
    
    var hour: Int
    var minute: Int
    
    var isAM: Bool
    
    init(hour: Int, minute: Int) {
        self.id = "\(hour)_\(minute)"
        
        self.hour = hour
        self.minute = minute
        
        self.isAM = hour < 12 ? true : false
        
    }
}
