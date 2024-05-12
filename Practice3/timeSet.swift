//
//  timeSet.swift
//  Practice3
//
//  Created by 박민규 on 5/12/24.
//

import SwiftUI
import UserNotifications

struct timeSet: View {
    @ObservedObject var notificationManager = NotificationManager.instance
    @State private var selectedDate = Date()
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                    }
                }
                .formStyle(.columns)
                List {
                    Section(header: Text("스케줄된 알림")) {
                        ForEach(notificationManager.sortedScheduledDates, id: \.self) { date in
                            Text(date, formatter: Self.timeFormatter)
                        }
                        .onDelete(perform: notificationManager.removeScheduledNotification)
                    }
                }
                .listStyle(.plain)
                
                
                Spacer()
                HStack {
                    Button("알림 스케줄") {
                        let success = notificationManager.scheduleNotification(at: selectedDate)
                        if !success {
                            showingAlert = true
                        }
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("중복 알림"), message: Text("이미 이 시간에 스케줄된 알림이 있습니다."), dismissButton: .default(Text("확인")))
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)

//                    Button("알림 취소") {
//                        notificationManager.cancelNotifications()
//                    }
//                    .padding()
//                    .background(Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
                }
                .background(Color.clear)
                .edgesIgnoringSafeArea(.all)
                Spacer()
            }
            .background(Color.clear)
            .navigationTitle("알람 시간 설정")
            .padding(.vertical, 20)
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
    }

    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh시 mm분"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
}


#Preview {
    timeSet()
}
