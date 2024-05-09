//
//  timeSet.swift
//  Practice3
//
//  Created by 박민규 on 5/9/24.
//


import SwiftUI
import UserNotifications

struct timeSet: View {
    @State static var times: [Int] = [1, 2, 3]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(timeSet.times, id: \.self) { time in
                        // Text(String(time))
                        NavigationLink(String(time), destination: Text("asd"))
                            
                    }
                    
                }
            }
            .navigationTitle("ASD")
            
            .toolbar {
                ToolbarItem {
                    EditButton() // 애플에서 만들어 둔거
                }
                ToolbarItem {
                    // 이게 바로 위의 코드와 동일 동작
                    Button(action: asd, label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
        
    }
    
    
    
    func addTime(time: Int) {
        // times.append(time)
    }
    
    
}

func asd() {
    
}

#Preview {
    timeSet()
}

func scheduleNotifications(times: [Int]) {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        if granted {
            print("알림 권한 허용")
        } else {
            print("알림 권한 거부")
        }
    }
    
    for hour in times {
        let content = UNMutableNotificationContent()
        content.title = "정기 알림"
        content.body = "현재 시각은 \(hour)시 입니다."
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            if let error = error {
                print("알림 등록 실패: \(error.localizedDescription)")
            } else {
                print("알림이 \(hour)시에 설정되었습니다.")
            }
        }
    }
}
