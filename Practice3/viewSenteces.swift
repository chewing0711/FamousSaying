import SwiftUI
import SwiftData

struct viewSentences: View {
    
    @State var aboutThema = Sentence()  // 가정된 데이터 모델
    @Query private var themas: [Thema]
    @State var showAlert = false
    @State var msg: String = ""
    @State private var isRefreshing = false  // 상태 변수를 통해 리프레시 상태를 관리
    @State var temp: [String] = []  // 상태 변수를 통해 temp 배열을 관리
    
    var checkthema = checkThema()
    
    var body: some View {
        NavigationView {
            List {
                ZStack {  // 전체 뷰에 대한 ZStack
                    // 배경 이미지 설정
                    Image("backGround")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.8)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .overlay(
                            RadialGradient(gradient: Gradient(colors: [.clear, .black]), center: .center, startRadius: 0, endRadius: 250)
                        )
                        .edgesIgnoringSafeArea(.all)  // 전체 화면을 커버
                    
                    Spacer()
                    VStack {
                        Spacer()
                        
                        Text(temp.count > 0 ? temp[0] : "")  // temp 배열의 크기를 확인하여 안전하게 접근
                            .font(.custom("YEONGJUSeonbi", size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.white)
                            .listRowBackground(Color.clear)  // 리스트 항목의 배경 투명 처리
                        Text(temp.count > 1 ? "\n- " + temp[1] + " -" : "")  // temp 배열의 크기를 확인하여 안전하게 접근
                            .font(.custom("YEONGJUSeonbi", size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.white)
                            .listRowBackground(Color.clear)  // 리스트 항목의 배경 투명 처리
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.vertical, 50)
                .listRowBackground(Color.clear)  // 리스트 항목의 배경 투명 처리
                .listRowSeparator(.hidden)
            }
            .background(Color.clear)
            .environment(\.colorScheme, .dark)
            .refreshable {
                await refreshItems()  // refreshItems 메서드를 호출하여 상태 업데이트
            }
            .listStyle(.plain)  // 리스트 스타일 적용
        }
        .alert(isPresented: $showAlert) {  // 알림 표시
            Alert(
                title: Text("사용할 수 있는 테마가 없습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
        .background(Color.black)
        .onAppear() {
            for thema in themas {
                checkthema.isToggle(thema: thema.title, is_: thema.isCheck)
            }
        }
    }
    
    func refreshItems() async {  // mutating 키워드 제거
        isRefreshing = true  // 상태 업데이트
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        aboutThema.bringSentence()
        
        if Sentence.Themas.count == 0 {
            showAlert = true  // 상태 업데이트
        } else {
            self.temp = Sentence.msg  // 상태 업데이트
        }
        
        isRefreshing = false  // 상태 업데이트
    }
}

struct ViewSentences_Previews: PreviewProvider {
    static var previews: some View {
        viewSentences()
    }
}
