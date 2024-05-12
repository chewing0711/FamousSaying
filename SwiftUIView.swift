//import SwiftUI
//import UserNotifications
//
//class NotificationManager_: ObservableObject {
//    static let instance = NotificationManager_()
//    @Published var scheduledDates = [Date]() // 스케줄된 시간들을 저장하는 리스트
//    
//    func requestAuthorization() {
//        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
//        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
//            if granted {
//                print("알림 권한이 허가되었습니다.")
//            } else if let error = error {
//                print("Error: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func scheduleNotification(at date: Date) -> Bool {
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
//        guard !scheduledDates.contains(where: { calendar.isDate($0, equalTo: date, toGranularity: .minute) }) else {
//            return false // 중복된 경우
//        }
//        
//        let content = UNMutableNotificationContent()
//        content.title = "알림 제목"
//        content.subtitle = "여기에 부제목을 넣으세요"
//        content.sound = .default
//        content.badge = 1
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("알림 등록 실패: \(error.localizedDescription)")
//            } else {
//                DispatchQueue.main.async {
//                    self.scheduledDates.append(date)
//                }
//                print("알림이 성공적으로 스케줄되었습니다.")
//            }
//        }
//        return true
//    }
//    
//    func cancelNotifications() {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        scheduledDates.removeAll()
//        print("모든 알림 스케줄이 취소되었습니다.")
//    }
//    
//    func removeScheduledNotification(at index: IndexSet) {
//        index.forEach { idx in
//            let date = scheduledDates[idx]
//            let calendar = Calendar.current
//            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
//            UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
//                let requestIDs = requests.filter { request in
//                    guard let trigger = request.trigger as? UNCalendarNotificationTrigger else { return false }
//                    return trigger.dateComponents == components
//                }.map { $0.identifier }
//                
//                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: requestIDs)
//            }
//            scheduledDates.remove(atOffsets: index)
//        }
//    }
//}
//
//
//extension Date {
//    // 분 단위로 날짜 시간을 반올림하는 메소드
//    func roundedToMinute_() -> Date {
//        let calendar = Calendar.current
//        let minute = calendar.component(.minute, from: self)
//        return calendar.date(bySetting: .minute, value: minute, of: self)!
//    }
//}
//
//
//struct asd: View {
//    @ObservedObject var notificationManager = NotificationManager.instance
//    @State private var selectedDate = Date()
//    @State private var showingAlert = false // Alert를 표시하기 위한 상태 변수
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("알림 설정")) {
//                    DatePicker("시간 선택", selection: $selectedDate, displayedComponents: .hourAndMinute)
//                        .datePickerStyle(WheelDatePickerStyle())
//                }
//                Section(header: Text("스케줄된 알림")) {
//                    List {
//                        ForEach(notificationManager.scheduledDates, id: \.self) { date in
//                            Text(date, formatter: Self.timeFormatter)
//                        }
//                        .onDelete(perform: notificationManager.removeScheduledNotification) // 삭제 기능 추가
//                    }
//                }
//            }
//        }
//            HStack {
//                Button("알림 권한 요청") {
//                    notificationManager.requestAuthorization()
//                }
//                .padding()
//                Button("알림 스케줄") {
//                    let success = notificationManager.scheduleNotification(at: selectedDate)
//                    if !success {
//                        showingAlert = true
//                    }
//                }
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text("중복 알림"), message: Text("이미 이 시간에 스케줄된 알림이 있습니다."), dismissButton: .default(Text("확인")))
//                }
//                .padding()
//                Button("알림 취소") {
//                    notificationManager.cancelNotifications()
//                }
//                .padding()
//            }
//        
//    }
//    
//    static var timeFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "a hh시 mm분"
//        formatter.locale = Locale(identifier: "ko_KR")
//        return formatter
//    }
//}
//
//#Preview {
//    asd()
//}
