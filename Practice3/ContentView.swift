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
        TabView {
            
            viewSenteces()
                .tabItem {
                    Image(systemName: "character.bubble.fill")
                    Text("명언")
                }
            
            checkThema()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("테마 설정")
                }
                .toolbarBackground(.black, for: .tabBar)
                
        }
        
        .padding(10)
        .listStyle(.plain)
        
    }
}

#Preview {
    ContentView()
}