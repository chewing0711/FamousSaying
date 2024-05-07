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
            
            
            
            Button(action: {
                        showAlert = true  // 버튼을 누를 때 showAlert를 true로 설정
                
//                aboutThema.bringSentence()
                    }) {
                        Text("적용")
                    }
                    .alert(isPresented: $showAlert) {  // showAlert 상태 변수에 따라 Alert를 표시
                        Alert(
                            title: Text("적용 되었습니다."),
                            //message: Text("asd"),
                            dismissButton: .default(Text("확인"))
                        )
                        
                    }
            
//            ForEach(asdf.Themas, id: \.self) { thema in
//                Text(thema)
//            }
            
            
//            Text(asdf.returnMsg)
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
