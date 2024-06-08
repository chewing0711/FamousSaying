//
//  bringSentence.swift
//  Practice3
//
//  Created by 박민규 on 5/7/24.
//

import Foundation

// 개행문자를 기준으로 나누는 코드
func splitString(msg: String) -> [String] {
    return msg.components(separatedBy: "\n")
}

// 랜덤한 정수 반환
func randInt(limit: Int) -> Int {
    return Int.random(in: 0 ... limit - 1)
}

class Sentence: ObservableObject {
    
    // 리턴할 글을 저장하는 변수
    static var returnMsg: String = ""
    
    static var Themas: [String] = []
    
    var temp: [String] = ["", ""]
    var title_msg: String = ""
    
    static var msg: [String] = []
    
    var thema: String = ""
    
    var txtPath: String = ""
    
    init() {
    }
    
    func addThemas(thema: String) {
        Sentence.Themas.append(thema)
    }
    
    func removeThemas(thema: String) {
        Sentence.Themas.removeAll { $0 == thema }
    }
    
    func bringSentence() {
        
        var msgs: String = "" // txt파일의 모든 글을 불러올 변수
        var msgArray: [String] = [] // 불러온 글들을 나눠서 저장할 변수
        
        // 랜덤한 테마를 반환
        thema = Sentence.Themas.count > 0 ? Sentence.Themas[randInt(limit: Sentence.Themas.count)] : ""
        
        txtPath = "\\txts\\" + thema
        
        if let filePath = Bundle.main.path(forResource: thema, ofType: "txt") {
            
            // 파일의 내용을 문자열로 읽어들입니다.
            if let content = try? String(contentsOfFile: filePath) {
                msgs = content // 읽은 내용을 fileContent 상태 변수에 저장합니다.
                msgArray = splitString(msg: msgs)
                
                title_msg = msgArray[randInt(limit: msgArray.count)]
                
                Sentence.msg = title_msg.components(separatedBy: " - ")
                
                // Sentence.returnMsg = msgArray[randInt(limit: msgArray.count)]
                
            } else {
                Sentence.msg.append("파일을 읽을 수 없습니다.1") // 파일 읽기에 실패한 경우의 메시지.
            }
        } else {
            Sentence.msg.append("파일을 찾을 수 없습니다.2")// 파일 경로를 찾지 못한 경우의 메시지.
        }
    }
}
