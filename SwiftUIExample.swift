import SwiftUI

struct a: View {
    var body: some View {
        Image("backGround")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: 300)
            .clipped()
            .overlay(
                RadialGradient(gradient: Gradient(colors: [.clear, .black]), center: .center, startRadius: 0, endRadius: 170)
                    
            )
            .edgesIgnoringSafeArea(.all)
            .environment(\.colorScheme, .dark)
    }
    
}

#Preview {
    a()
}
