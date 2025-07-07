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
    @Published var isLogin = false
    @Published var pickedImage: UIImage? = nil
      @Published var avatarImageName: String? = UserDefaultsManager().getImage()
    
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
        
        if let savedImage = loadImageFromUserDefaults(key: "selectedPhoto") {
            _pickedImage = Published(initialValue: savedImage)
            UserDefaultsManager().deleteImage()
        } else {
            _pickedImage = Published(initialValue: nil)
        }
    }
    
    func loadImageFromUserDefaults(key: String) -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func updateProfile(completion: @escaping (Result<Void, Error>) -> Void) {
        let userId: String = UserDefaultsManager().getID() ?? ""
        
        NetworkManager().editProfile(
            userId: userId,
            name: name.isEmpty ? UserDefaultsManager().getName() : name,
            city: city.isEmpty ? UserDefaultsManager().getCity() : city,
            weapon: weaponType.isEmpty ? UserDefaultsManager().getWeapon() : weaponType,
            level: level.isEmpty ? nil : UserDefaultsManager().getLevel(),
            newEmail: email.isEmpty ? UserDefaultsManager().getEmail() : email,
            picture: picture
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Profile updated: \(success)")
                        if !self.email.isEmpty {
                            UserDefaultsManager().saveCurrentEmail(self.email)
                        }
                        if !self.name.isEmpty {
                            UserDefaultsManager().saveName(self.name)
                        }
                        if !self.city.isEmpty {
                            UserDefaultsManager().saveCity(self.city)
                        }
                        if !self.weaponType.isEmpty {
                            UserDefaultsManager().saveWeapon(self.weaponType)
                        }
                        if !self.level.isEmpty {
                            UserDefaultsManager().saveLevel(self.level)
                        }
                        completion(.success(()))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func deleteAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        let userId: String = UserDefaultsManager().getID() ?? ""
        
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
