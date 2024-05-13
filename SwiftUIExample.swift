import SwiftUI

struct a: View {
    var Array: [String] = ["1", "2", "3"]
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 300, height: 300)
                .foregroundStyle(Color.blue)
            
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(Color.red)
            
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(Color.yellow)
        }
    }
}

#Preview {
    a()
}


struct a_: View {
    var Array: [String] = ["1", "2", "3"]
    
    var body: some View {
        HStack {
            ForEach(Array, id: \.self) { item in
                Text(item)
            }
        }
    }
}
