import SwiftUI

class BetPostViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    
    func loadComments(for discussionId: String) {
        NetworkManager().getComments(discussionId: discussionId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let commentsArray = json["comments"] as? [[String: Any]] {
                        let loaded = commentsArray.compactMap { Comment(json: $0) }
                        self?.comments = loaded.sorted(by: { $0.dateSent > $1.dateSent })
                    }
                case .failure(let error):
                    print("Failed to load comments: \(error.localizedDescription)")
                    self?.comments = []
                }
            }
        }
    }
}
