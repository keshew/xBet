import SwiftUI

class BetSettingsViewModel: ObservableObject {
    let contact = BetSettingsModel()
    @Published var name = ""
    @Published var city = ""
    @Published var weaponType = ""
    @Published var level = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isPhoto = false
    @Published var picture: String? = nil
    @Published var isSign = false
    
    @Published var isNotif: Bool {
        didSet {
            UserDefaults.standard.set(isNotif, forKey: "isNotif")
        }
    }
    
    @Published var isEmail: Bool {
        didSet {
            UserDefaults.standard.set(isEmail, forKey: "isEmail")
        }
    }
    
    init() {
        self.isNotif = UserDefaults.standard.bool(forKey: "isNotif")
        self.isEmail = UserDefaults.standard.bool(forKey: "isEmail")
    }
    
    func updateProfile(completion: @escaping (Result<Void, Error>) -> Void) {
        let userId: String = "user_686835ca2f1095.82273141"
        
        NetworkManager().editProfile(
            userId: userId,
            name: name.isEmpty ? nil : name,
            city: city.isEmpty ? nil : city,
            weapon: weaponType.isEmpty ? nil : weaponType,
            level: level.isEmpty ? nil : level,
            newEmail: email.isEmpty ? nil : email,
            picture: picture
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Profile updated: \(success)")
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
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        let userId: String = "user_686835ca2f1095.82273141"
        
        NetworkManager().deleteAccount(userId: userId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Account deleted: \(success)")
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
