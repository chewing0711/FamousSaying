import Foundation
import SwiftData

@Model
class Thema: ObservableObject, Identifiable {
    var id: UUID
    
    var title: String
    
    var isCheck: Bool = false
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
}
