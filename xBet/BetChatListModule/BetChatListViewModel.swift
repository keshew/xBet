import SwiftUI

class BetChatListViewModel: ObservableObject {
    let contact = BetChatListModel()
    @Published var isMessage = false
    @Published var users: [User] = []
    @Published var selectedUser: User? = nil
    
    func loadUsers(limit: Int = 5) {
        NetworkManager().getUsers { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let error = json["error"] as? String {
                        print("Error loading users: \(error)")
                        self?.users = []
                    } else if let usersArray = json["users"] as? [[String: Any]] {
                        let mappedUsers = usersArray.compactMap { User(json: $0) }
                        self?.users = Array(mappedUsers.prefix(limit))
                    } else {
                        self?.users = []
                    }
                case .failure(let error):
                    print("Failed to load users: \(error.localizedDescription)")
                    self?.users = []
                }
            }
        }
    }
}
