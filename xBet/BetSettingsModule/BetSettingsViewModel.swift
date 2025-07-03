import SwiftUI

class BetSettingsViewModel: ObservableObject {
    let contact = BetSettingsModel()
    @Published var name = ""
    @Published var city = ""
    @Published var weaponType = ""
    @Published var level = ""
    @Published var email = ""
    @Published var password = ""
    
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
}
