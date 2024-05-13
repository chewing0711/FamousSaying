//
//  alamTrigger.swift
//  Practice3
//
//  Created by 박민규 on 5/10/24.
//

import UserNotifications  // 컴퓨터가 알림 도구를 사용할 수 있도록 도와줍니다.

// 'NotificationManager' 라는 새로운 놀이터를 만듭니다.
class NotificationManager: ObservableObject {
    // 이 놀이터는 전세계에서 하나뿐이에요, 'instance'로 불러요.
    static let instance = NotificationManager()

    // 'scheduledDates'는 알림을 보내려고 기다리는 날짜들을 모아 둔 상자에요.
    @Published var scheduledDates = [Date]()

    // 이 함수는 컴퓨터에게 "알림을 보내도 될까요?" 라고 물어봐요.
    func requestAuthorization() {
        // 이 세가지 방법으로 알림을 보낼 수 있어요: 메시지, 소리, 아이콘에 숫자
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if let error = error { // 문제가 생기면, 무슨 문제인지 알려줘요.
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    // 특정 날짜에 알림을 설정하는 함수에요.
    func scheduleNotification(at date: Date) -> Bool {
        let calendar = Calendar.current // 현재 사용 중인 달력을 불러와요.
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date) // 날짜의 구성 요소를 가져와요.
        
        // 이미 그 시간에 알림이 있는지 확인해요. 있다면 더 이상 진행하지 않고 멈춰요.
        guard !scheduledDates.contains(where: { calendar.isDate($0, equalTo: date, toGranularity: .minute) }) else {
            return false // 중복된 경우에는 'false'를 반환해요.
        }
        
        let content = UNMutableNotificationContent() // 알림의 내용을 만들어요.
        content.title = "알림 제목" // 알림의 제목을 설정해요.
        content.subtitle = "여기에 부제목을 넣으세요" // 알림의 부제목을 설정해요.
        content.sound = .default // 알림이 올 때 소리를 낼 수 있어요.
        content.badge = 1 // 앱 아이콘에 숫자 1을 보여줘요.
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false) // 설정한 날짜에 알림을 보내기로 해요.
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger) // 알림을 보낼 요청을 만들어요.
        
        UNUserNotificationCenter.current().add(request) { error in // 요청된 알림을 실제로 추가해요.
            if let error = error { // 문제가 생기면, 무슨 문제인지 알려줘요.
                print("알림 등록 실패: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async { // 성공하면, 날짜 상자에 날짜를 추가해요.
                    self.scheduledDates.append(date)
                }
                print("알림이 성공적으로 스케줄되었습니다.") // 성공 메시지를 출력해요.
            }
        }
        return true // 성공적으로 알림이 설정되었다고 알려줘요.
    }

    // 모든 예정된 알림을 취소하는 함수에요.
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // 모든 대기중인 알림 요청을 지워요.
        scheduledDates.removeAll() // 날짜 상자를 비워요.
        print("모든 알림 스케줄이 취소되었습니다.") // 취소되었다고 알려줘요.
    }

    // 특정 알림만 제거하고 싶을 때 사용하는 함수에요.
    func removeScheduledNotification(at index: IndexSet) {
        index.forEach { idx in // 제거하고 싶은 알림 위치를 하나씩 봐요.
            let date = scheduledDates[idx] // 제거하고 싶은 날짜를 찾아요.
            let calendar = Calendar.current // 달력을 사용해요.
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date) // 그 날짜의 구성 요소를 가져와요.
            UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
                let requestIDs = requests.filter { request in
                    guard let trigger = request.trigger as? UNCalendarNotificationTrigger else { return false }
                    return trigger.dateComponents == components
                }.map { $0.identifier }
                
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: requestIDs) // 해당하는 알림 요청을 제거해요.
            }
            scheduledDates.remove(atOffsets: index) // 날짜 상자에서 그 날짜를 제거해요.
        }
    }
    
    // 예정된 알림 날짜들을 시간 순서대로 나열해 보여주는 변수에요.
    var sortedScheduledDates: [Date] {
        scheduledDates.sorted() // 날짜 상자의 날짜들을 정렬해요.
    }
}

// 'Date'에 대한 확장 기능을 만들어요. 이건 날짜와 시간을 분 단위로 반올림하는 기능이에요.
extension Date {
    func roundedToMinute() -> Date {
        let calendar = Calendar.current // 달력을 불러와요.
        let minute = calendar.component(.minute, from: self) // 현재 분을 찾아요.
        return calendar.date(bySetting: .minute, value: minute, of: self)! // 그 분으로 시간을 설정해요.
    }
}
