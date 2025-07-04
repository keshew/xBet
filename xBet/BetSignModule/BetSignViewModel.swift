import SwiftUI

class BetSignViewModel: ObservableObject {
    let contact = BetSignModel()
    @Published var name = ""
    @Published var city = ""
    @Published var weaponType = ""
    @Published var level = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isLogin = false
    @Published var isTab = false
}
