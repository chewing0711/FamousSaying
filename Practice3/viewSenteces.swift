//
//  viewSenteces.swift
//  Practice3
//
//  Created by 박민규 on 5/7/24.
//

import SwiftUI

struct viewSenteces: View {
    
    @State var aboutThema = asdf()
    
    @State var showAlert = false
    
    @State var msg: String = ""
    
    var body: some View {
        List {
            Section {
                Text(msg)
                
            }
            Button(action: {
                // showAlert = true  // 버튼을 누를 때 showAlert를 true로 설정
                aboutThema.bringSentence()
                print(aboutThema.thema)
                print("1")
                print(asdf.getMsg())
                msg = asdf.getMsg()
                print(msg)
                print("2")
            }) {
                Text("새로 고침")
            }
        }
        .listStyle(.insetGrouped)
        
        
    }
}

#Preview {
    viewSenteces()
}
