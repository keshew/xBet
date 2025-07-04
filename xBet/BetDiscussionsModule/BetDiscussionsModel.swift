import SwiftUI

struct BetDiscussionsModel {
 
}

struct Discussion: Identifiable {
    let id: String
    let userId: String
    let title: String
    let text: String
    let dateAdded: Date
    
    init(id: String, userId: String, title: String, text: String, dateAdded: Date) {
        self.id = id
        self.userId = userId
        self.title = title
        self.text = text
        self.dateAdded = dateAdded
    }
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? String,
              let userId = json["user_id"] as? String,
              let title = json["title"] as? String,
              let text = json["text"] as? String,
              let dateStr = json["date_added"] as? String,
              let date = Discussion.dateFormatter.date(from: dateStr) else {
            return nil
        }
        self.id = id
        self.userId = userId
        self.title = title
        self.text = text
        self.dateAdded = date
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy" 
        return formatter
    }()
}

