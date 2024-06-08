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
                        Text("A Sentence")
                    }
                    
                
                checkThema()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Thema")
                    }
                    
                
                timeSet()
                    .tabItem {
                        Image(systemName: "timer.circle.fill")
                        Text("Time")
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
