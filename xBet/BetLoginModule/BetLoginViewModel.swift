import SwiftUI

class BetLoginViewModel: ObservableObject {
    let contact = BetLoginModel()
    @Published var email = ""
    @Published var password = ""
}
