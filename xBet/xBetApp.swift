import SwiftUI

@main
struct xBetApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLogin() {
                BetTabBarView()
            } else {
                if UserDefaultsManager().isFirstLaunch() {
                    BetOnboardingView()
                } else {
                    BetLoginView()
                        .onAppear() {
                            UserDefaultsManager().quitQuest()
                        }
                }
            }
        }
    }
}
