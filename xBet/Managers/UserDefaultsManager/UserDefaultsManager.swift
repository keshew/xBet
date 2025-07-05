import SwiftUI

class UserDefaultsManager: ObservableObject {
    func isFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")
        
        if !isFirstLaunch {
            defaults.set(true, forKey: "isFirstLaunch")
            return true
        }
        
        return false
    }
    
    func enterAsGuest() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "guest")
    }
    
    func isGuest() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "guest")
    }
    
    func quitQuest() {
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "guest")
    }
    
    func checkLogin() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "isLoggedIn")
    }
    
    func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func getEmail() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "currentEmail")
    }

    func getPassword() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "password")
    }
    
    func logout() {
        saveLoginStatus(false)
    }
    
    func saveCurrentEmail(_ email: String) {
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "currentEmail")
    }
    
    func savePassword(_ password: String) {
        let defaults = UserDefaults.standard
        defaults.set(password, forKey: "password")
    }
    
    func deletePassword() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "password")
    }

    func deletePhone() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "currentEmail")
    }
    
    func saveName(_ name: String) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "name")
    }
    
    func getName() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "name")
    }
    
    func deleteName() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "name")
    }
    
    func saveID(_ name: String) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "id")
    }
    
    func getID() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "id")
    }
    
    func deleteID() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "id")
    }
    
    func clearAllUserData() {
          let defaults = UserDefaults.standard
          
          let keysToRemove = [
              "guest",
              "isLoggedIn",
              "currentEmail",
              "password",
              "name"
          ]
          
          for key in keysToRemove {
              defaults.removeObject(forKey: key)
          }
        
          defaults.synchronize()
      }
}
