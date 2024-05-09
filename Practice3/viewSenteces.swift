//
//  viewSenteces.swift
//  Practice3
//
//  Created by 박민규 on 5/7/24.
//

import SwiftUI

struct viewSentences: View {
    
    @State var aboutThema = asdf()  // 가정된 데이터 모델
    
    @State var showAlert = false
    
    @State var msg: String = ""
    
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationView {
            
            
            List {
                ZStack {  // 전체 뷰에 대한 ZStack
                    // 배경 이미지 설정
                    Image("backGround")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.8)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    // .edgesIgnoringSafeArea(.all)  // 전체 화면을 커버
                    
                    Spacer()
                    HStack {
                        Spacer()
                        Text(msg)
                            .font(.custom("YEONGJUSeonbi", size: 30))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.white)
                        Spacer()
                    }
                    Spacer()
                }
                .padding(.vertical, 50)
                .listRowBackground(Color.clear)  // 리스트 항목의 배경 투명 처리
                // .opacity(0.9)
                
            }
            .refreshable {
                await refreshItems()
            }
            .listStyle(.plain)  // 리스트 스타일 적용
            .background(Color.clear)  // 리스트의 배경 투명 처리
        }
        .alert(isPresented: $showAlert) {  // 알림 표시
            Alert(
                title: Text("사용할 수 있는 테마가 없습니다."),
                dismissButton: .default(Text("확인"))
            )
        }
    }
    
    func refreshItems() async {
        isRefreshing = true
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        aboutThema.bringSentence()
        
        if asdf.Themas.count == 0 {
            showAlert = true
        } else {
            msg = asdf.getMsg()
        }
        
        isRefreshing = false
    }
}

struct viewSentences_Previews: PreviewProvider {
    static var previews: some View {
        viewSentences()
    }
}
