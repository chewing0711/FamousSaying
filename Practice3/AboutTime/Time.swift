//
//  Time.swift
//  Practice3
//
//  Created by 박민규 on 5/13/24.
//

import SwiftData

@Model
class Time: Identifiable {
    let id: String
    
    var hour: Int
    var minute: Int
    
    var isAM: Bool
    
    init(hour: Int, minute: Int) {
        self.id = "\(hour)_\(minute)"
        
        self.hour = hour
        self.minute = minute
        
        self.isAM = hour < 12 ? true : false
        
    }
}
