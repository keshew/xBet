import SwiftUI

class BetNewCommentViewModel: ObservableObject {
    let contact = BetNewCommentModel()

    func addComment(discussionId: String, name: String, text: String, dateSent: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        NetworkManager().addComment(discussionId: discussionId, name: name, text: text, dateSent: dateSent, completion: completion)
    }
}
