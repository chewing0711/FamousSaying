//
//  alamTrigger.swift
//  Practice3
//
//  Created by 박민규 on 5/10/24.
//

import UserNotifications

class NotificationManager: ObservableObject {
    static let instance = NotificationManager() // 알림과 관련된 객체를 만듦
    @Published var scheduledDates = [Date]() // 스케줄된 시간들을 저장하는 리스트
    
    // 알림 권한 요청
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if granted {
                print("알림 권한이 허가되었습니다.")
            } else if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // 특정 시간대에 푸시 알림을 보내고자 하는 함수
    func scheduleNotification(at date: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        guard !scheduledDates.contains(where: { calendar.isDate($0, equalTo: date, toGranularity: .minute) }) else {
            return false // 중복된 경우
        }
        
        let content = UNMutableNotificationContent()
        content.title = "알림 제목"
        content.subtitle = "여기에 부제목을 넣으세요"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 등록 실패: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.scheduledDates.append(date)
                }
                print("알림이 성공적으로 스케줄되었습니다.")
            }
        }
        return true
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        scheduledDates.removeAll()
        print("모든 알림 스케줄이 취소되었습니다.")
    }
    
    // 특정 알림만 제거 하고자 하는 함수
    func removeScheduledNotification(at index: IndexSet) {
        index.forEach { idx in
            let date = scheduledDates[idx]
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
                let requestIDs = requests.filter { request in
                    guard let trigger = request.trigger as? UNCalendarNotificationTrigger else { return false }
                    return trigger.dateComponents == components
                }.map { $0.identifier }
                
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: requestIDs)
            }
            scheduledDates.remove(atOffsets: index)
        }
    }
    
    // 스케쥴된 알림, 시간대 별로 정렬
    var sortedScheduledDates: [Date] {
        scheduledDates.sorted()
    }
}


extension Date {
    // 분 단위로 날짜 시간을 반올림하는 메소드
    func roundedToMinute() -> Date {
        let calendar = Calendar.current
        let minute = calendar.component(.minute, from: self)
        return calendar.date(bySetting: .minute, value: minute, of: self)!
    }
}
