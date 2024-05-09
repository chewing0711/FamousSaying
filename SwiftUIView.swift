import SwiftUI

struct SwiftUIView: View {
    @State private var items = ["1", "2", "3"]

    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                Text(item)
            }
            .refreshable {
                await refreshItems()
            }
            .navigationTitle("당겨서 새로고침")
        }
    }
    
    func refreshItems() async {
        // 비동기 작업을 시뮬레이션하기 위해 잠시 기다림
        try? await Task.sleep(nanoseconds: 2_000_000_000)  // 2초 대기
        
        // 새로운 데이터 가져오기를 여기에서 수행
        // 예제를 위해 아이템 목록에 새로운 아이템 추가
        let newItems = ["4", "5", "6"]
        items.append(contentsOf: newItems)
        
    }
}

#Preview {
    SwiftUIView()
}
