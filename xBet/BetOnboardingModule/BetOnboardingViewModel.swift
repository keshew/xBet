import SwiftUI

class BetOnboardingViewModel: ObservableObject {
    let contact = BetOnboardingModel()
    @Published var isLog = false
    @Published var isSign = false
    @Published var isTab = false
}
