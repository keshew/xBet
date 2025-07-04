import SwiftUI

struct BetPostModel {
 
}

struct Comment: Identifiable {
    let id: String
    let discussionId: String
    let name: String
    let text: String
    let dateSent: Date
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
              let discussionId = json["discussion_id"] as? String,
              let name = json["name"] as? String,
              let text = json["text"] as? String,
              let dateStr = json["date_sent"] as? String,
              let date = Comment.dateFormatter.date(from: dateStr) else {
            return nil
        }
        self.id = id
        self.discussionId = discussionId
        self.name = name
        self.text = text
        self.dateSent = date
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}
