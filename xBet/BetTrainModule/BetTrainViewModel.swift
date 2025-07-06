import SwiftUI

class BetTrainViewModel: ObservableObject {
    @Published var practices: [Practice] = []
    @Published var users: [User] = []
    @Published var isMessage = false
    @Published var isMessageList = false
    @Published var selectedUser: User? = nil
    
    func loadPracticesAndSparrings(userId: String) {
        loadPractices(userId: userId)
        loadSparrings(userId: userId)
    }
    
    func loadPractices(userId: String) {
        NetworkManager().getPractices(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let error = json["error"] as? String {
                        print("Error loading practices: \(error)")
                        self?.practices = []
                    } else if let practicesArray = json["practices"] as? [[String: Any]] {
                        self?.practices = practicesArray.enumerated().compactMap { index, practiceDict in
                            Practice(json: practiceDict, index: index)
                        }
                    } else {
                        self?.practices = []
                    }
                case .failure(let error):
                    print("Failed to load practices: \(error.localizedDescription)")
                    self?.practices = []
                }
            }
        }
    }
    
    func loadUsers(limit: Int = 10) {
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
    
    func loadSparrings(userId: String) {
        NetworkManager().getSparrings(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let error = json["error"] as? String {
                        print("Error loading sparrings: \(error)")
                    } else if let sparringsArray = json["sparrings"] as? [[String: Any]] {
                        let sparrings = sparringsArray.enumerated().compactMap { index, sparringDict in
                            Practice(sparringJson: sparringDict, index: index)
                        }
                        self?.practices.append(contentsOf: sparrings)
                    }
                case .failure(let error):
                    print("Failed to load sparrings: \(error.localizedDescription)")
                }
            }
        }
    }
}
