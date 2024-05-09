//
//  time.swift
//  Practice3
//
//  Created by 박민규 on 5/9/24.
//

import SwiftUI

struct time: View {
    @State var hour: String = ""
    @State var min: String = ""
    
    var body: some View {
        HStack {
            TextField("hour", text: $hour)
                .font(.title2)
                .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 2)
                )
                .padding(.horizontal, 50)
            
            TextField("min", text: $min)
                .font(.title2)
                .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 2)
                )
                .padding(.horizontal, 50)
        }
        Button(action: {
//            var hourInt: Int = Int(hour) ?? 0
//            var minInt = Int(min) ?? 0
//            
//            if (hourInt < 24 && hourInt > 0) && (minInt < 59 && minInt > 0) {
//                timeSet.times.append(Int(hour))
//                timeSet.times.append(Int(min))
//            }
            
        }, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
    
    func asd() {
        
    }
}

#Preview {
    time()
}
