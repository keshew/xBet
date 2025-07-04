import SwiftUI

class BetDiscussionsViewModel: ObservableObject {
    @Published var discussions: [Discussion] = []
    @Published var isPost = false
    @Published var selectedDiscussion: Discussion? = nil

    func loadDiscussions() {
        NetworkManager().getDiscussions { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let discussionsArray = json["discussions"] as? [[String: Any]] {
                        let loaded = discussionsArray.compactMap { Discussion(json: $0) }
                        self?.discussions = loaded.sorted(by: { $0.dateAdded > $1.dateAdded })
                    }
                case .failure(let error):
                    print("Failed to load discussions: \(error.localizedDescription)")
                    self?.discussions = []
                }
            }
        }
    }
    
    var newDiscussions: [Discussion] {
        let threeHoursAgo = Date().addingTimeInterval(-3 * 3600)
        return discussions.filter { $0.dateAdded >= threeHoursAgo }
    }
    
    var allDiscussions: [Discussion] {
        let threeHoursAgo = Date().addingTimeInterval(-3 * 3600)
        return discussions.filter { $0.dateAdded < threeHoursAgo }
    }
}

