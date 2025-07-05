import SwiftUI

class BetChoosePhotoViewModel: ObservableObject {
    let contact = BetChoosePhotoModel()
    
    var currentAvatar: String = "ava3"
    
    @Published var selectedIndex: Int
    
    init() {
        if let index = contact.arrayOfAva.firstIndex(of: currentAvatar) {
            selectedIndex = index
        } else {
            selectedIndex = 0
        }
    }
    
    func changeAvatar(completion: @escaping (Result<Void, Error>) -> Void) {
        let selectedAvatar = contact.arrayOfAva[selectedIndex]
        
        NetworkManager().changeAvatar(
            userId: UserDefaultsManager().getID() ?? "",
            picture: selectedAvatar
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Avatar changed: \(success)")
                        completion(.success(()))
                    } else if let error = json["error"] as? String {
                        completion(.failure(NSError(domain: error, code: 1)))
                    } else {
                        completion(.failure(NSError(domain: "Unknown error", code: 0)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
