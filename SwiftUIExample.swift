import SwiftUI

struct a: View {
    @State private var selectedTime = Date()
    @Environment(\.calendar) var calendar
    
    var hour: Int {
        calendar.component(.hour, from: selectedTime)
    }
    
    var minute: Int {
        calendar.component(.minute, from: selectedTime)
    }
    
    @State var num: Int = 0
    @State var num2: Int = 0

    var body: some View {
        VStack {
            DatePicker(
                "Select Time",
                selection: $selectedTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(WheelDatePickerStyle())
            .frame(maxWidth: 300)
            
            Button(action: {
                num = hour
                num2 = minute
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            // 시간과 분을 따로 표시
            Text("Hour: \(num)")
            Text("Minute: \(num2)")
        }
    }
}


#Preview {
    a()
}
