//
//  ContentView.swift
//  Practice3
//
//  Created by 박민규 on 5/7/24.
//

import SwiftUI

struct ContentView: View {
    var checker = checkThema()
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // 전체 배경을 검은색으로 설정
            TabView {
                viewSentences()
                    .tabItem {
                        Image(systemName: "character.bubble.fill")
                        Text("명언")
                    }
                    
                
                checkThema()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("테마 설정")
                    }
                    
                
                timeSet()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("시간 설정")
                    }
                    
                
            }
            
            
            .padding(10)
            .listStyle(.plain)
        }
        .environment(\.colorScheme, .dark)
    }
}

#Preview {
    ContentView()
}
