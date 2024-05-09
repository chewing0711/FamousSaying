//
//  checkThema.swift
//  Practice3
//
//  Created by 박민규 on 5/7/24.
//

import SwiftUI

struct checkThema: View {
    
    @State var aboutThema = asdf()
    
    @State var isLove: Bool = false
    @State var isMotive: Bool = false
    
    @State private var showAlert = false
    // 상태 변수를 선언하여 Alert 표시 여부 관리
    
    var body: some View {
        List {
            Section(header: Text("테마 지정").font(.title)) {
                Toggle("사랑", isOn: $isLove)
                    .onChange(of: isLove) {
                        isToggle(thema: "Love", is_: isLove)
                    }
                
                Toggle("동기부여", isOn: $isMotive)
                    .onChange(of: isMotive) {
                        isToggle(thema: "Motive", is_: isMotive)
                    }
            }
        }
        .listStyle(.plain)
    }
    
    func isToggle(thema: String, is_: Bool) {
        if is_ {
            aboutThema.addThemas(thema: thema)
        } else {
            aboutThema.removeThemas(thema: thema)
        }
    }
}

#Preview {
    checkThema()
}
