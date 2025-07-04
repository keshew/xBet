import SwiftUI

struct BetTabBarView: View {
    @StateObject var betTabBarModel =  BetTabBarViewModel()
    @State private var selectedTab: CustomTabBar.TabType = .Main
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Main {
                    BetMainView()
                } else if selectedTab == .Arena {
                    BetArenaView()
                } else if selectedTab == .Training {
                    BetTrainView()
                } else if selectedTab == .Diary {
                    BetDiaryView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BetTabBarView()
}
