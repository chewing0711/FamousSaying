//
//  timeSet.swift
//  Practice3
//
//  Created by 박민규 on 5/12/24.
//

import SwiftUI  // SwiftUI 도구를 사용할 수 있게 해줘요. SwiftUI는 화면을 만드는 도구예요.
import UserNotifications  // 알림을 관리할 수 있는 도구를 사용할 수 있게 해줘요.

// 'timeSet'이라는 화면을 만드는 구조체예요. SwiftUI에서 화면은 'View'라고 불러요.
struct timeSet: View {
    @ObservedObject var timeListControl = TimeListViewModel()
    
    @State private var selectedDate = Date()  // 사용자가 날짜를 선택할 수 있는 공간을 만들어요.
    @State private var showingAlert = false  // 경고 메시지를 보여줄지 말지 결정하는 표시기예요.
    
    @Environment(\.calendar) var calendar
    
    // 데이터 피커로 정한 시와 분을 따로 따로 정의
    var hour: Int { calendar.component(.hour, from: selectedDate) }
    var minute: Int { calendar.component(.minute, from: selectedDate) }
    
    
    // 화면에 보여지는 모습을 만들어요.
    var body: some View {
        NavigationView {  // 전체 화면을 네비게이션 뷰로 감싸요.
            VStack {  // 세로로 내용을 쌓을 수 있는 뷰예요.
                Form {  // 폼을 사용해 입력란을 만들어요.
                    Section {  // 섹션으로 구분해서 깔끔하게 보여줘요.
                        DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())  // 시간을 선택하는 바퀴 모양의 선택기를 사용해요.
                            .labelsHidden()  // 라벨을 숨겨서 깔끔하게 보이게 해요.
                    }
                }
                .formStyle(.columns)  // 폼의 스타일을 열로 구성해요.
                
                List {  // 목록을 만들어요.
                    Section(header: Text("스케줄된 알림")) {  // 목록의 헤더에 "스케줄된 알림"이라고 표시해요.
                        ForEach(sortTimes(times: timeListControl.times), id: \.id) { Time in
                            Text(displayTime(hour: Time.hour, minute: Time.minute, isAM: Time.isAM, id: Time.id))  // 날짜를 보여주는 텍스트예요.
                            
                        }
                        .onDelete(perform: removeTimes)  // 삭제할 수 있게 해요.
                    }
                }
                .listStyle(.plain)  // 목록 스타일을 단순하게 해요.
                
                Spacer()  // 빈 공간을 만들어요.
                HStack {  // 가로로 내용을 쌓을 수 있는 뷰예요.
                    Button("알림 스케줄") {
                        // 해당 시간에 따른 객체 생성, 배열 추가
                        timeListControl.addTime(time: Time(hour: hour, minute: minute))
                    }
                    .alert(isPresented: $showingAlert) {  // 경고 메시지를 어떻게 보여줄지 설정해요.
                        Alert(title: Text("중복 알림"), message: Text("이미 이 시간에 스케줄된 알림이 있습니다."), dismissButton: .default(Text("확인")))
                    }
                    .padding()  // 버튼 주변에 여백을 줘요.
                    .background(Color.black)  // 버튼 배경색을 검정색으로 해요.
                    .foregroundColor(.white)  // 글자색을 흰색으로 해요.
                    .cornerRadius(10)  // 버튼 모서리를 둥글게 해요.
                }
                .background(Color.clear)  // 배경색은 투명하게 해요.
                .edgesIgnoringSafeArea(.all)  // 안전 영역을 무시하고 모든 곳에 내용을 표시해요.
                Spacer()  // 빈 공간을 만들어요.
            }
            .background(Color.clear)  // 배경색을 투명하게 해요.
            .navigationTitle("알람 시간 설정")  // 네비게이션 바의 제목을 설정해요.
            .padding(.vertical, 20)  // 세로 방향 여백을 줘요.
        }
        .background(Color(.systemGray6))  // 전체 배경색을 회색으로 해요.
        .edgesIgnoringSafeArea(.all)  // 안전 영역을 무시하고 모든 곳에 내용을 표시해요.
    }
    
    func displayTime(hour: Int, minute: Int, isAM: Bool, id: String) -> String {
        let hour12 = hour % 12 == 0 ? 12 : hour % 12
        
        let suffix = isAM ? "오전" : "오후"
        
        let id = id
        
        return "\(suffix) \(hour12):\(String(format: "%02d", minute)) \(id)"
    }
    
    func removeTimes(at offsets: IndexSet) {
            timeListControl.removeTime(at: offsets)
        }
}

// 이 부분은 이 화면을 미리 보여주는 설정이에요.
#Preview {
    timeSet()
}
