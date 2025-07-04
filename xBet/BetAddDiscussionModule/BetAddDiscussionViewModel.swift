import SwiftUI

class BetAddDiscussionViewModel: ObservableObject {
    let contact = BetAddDiscussionModel()
    func addDiscussion(userId: String, title: String, text: String, dateAdded: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        NetworkManager().addDiscussion(userId: userId, title: title, text: text, dateAdded: dateAdded, completion: completion)
    }
}
