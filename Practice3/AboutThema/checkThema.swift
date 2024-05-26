//
//  checkThema.swift
//  Practice3
//
//  Created by 박민규 on 5/7/24.
//

import SwiftUI
import SwiftData

struct checkThema: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var themas: [Thema]
    
    @State var aboutThema = Sentence()
    
    var body: some View {
        VStack {
            Section(header: Text("테마 지정").font(.title)) {
                List {
                    ForEach(themas, id: \.id) { thema in
                        Toggle(thema.title, isOn: Binding(
                            get: { thema.isCheck },
                            set: { newValue in
                                if let index = themas.firstIndex(where: { $0.id == thema.id }) {
                                    themas[index].isCheck = newValue
                                    isToggle(thema: thema.title, is_: newValue)
                                    try? modelContext.save()
                                    
                                }
                            }
                        ))
                    }
                }
            }
            .listStyle(.plain)
            .padding()
            .cornerRadius(10)
            .onAppear {
                addInitialThemas()
            }
        }
        
    }
    
    func isToggle(thema: String, is_: Bool) {
        if is_ {
            aboutThema.addThemas(thema: thema)
        } else {
            aboutThema.removeThemas(thema: thema)
        }
    }
    
    // Initial Themas를 추가하는 함수
    func addInitialThemas() {
        let themaTitles = ["사랑", "동기부여"]
        
        // 데이터베이스에 이미 존재하는 테마 타이틀을 가져옵니다.
        let existingTitles = themas.map { $0.title }
        
        // 초기 테마 타이틀과 비교하여 누락된 타이틀만 추가합니다.
        for title in themaTitles where !existingTitles.contains(title) {
            let thema = Thema(title: title)
            modelContext.insert(thema)
        }
        try? modelContext.save()
    }
    
    func setThema() {
        
        addInitialThemas()
        
        for i in 0 ..< themas.count {
            isToggle(thema: themas[i].title, is_: themas[i].isCheck)
        }
        
        //        for i in 0 ..< themas.count {
        //            if themas[i].isCheck {
        //                Sentence.Themas.append(themas[i].title)
        //            }
        //        }
        
        
    }
}

#Preview {
    checkThema()
}
