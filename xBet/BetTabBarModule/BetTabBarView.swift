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

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Main
        case Arena
        case Training
        case Diary
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                Rectangle()
                    .fill(Color(red: 33/255, green: 85/255, blue: 132/255))
                    .frame(height: 110)
                    .cornerRadius(30)
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: 35)
                    .shadow(color: .black.opacity(0.8), radius: 20, y: -5)
            }
            
            HStack(spacing: 0) {
                TabBarItem(imageName: "tab1", tab: .Main, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Arena, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Training, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .Diary, selectedTab: $selectedTab)
            }
            .padding(.top, 10)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 5) {
                Image(selectedTab == tab ? imageName : imageName)
                    .resizable()
                    .frame(
                        width: 32,
                        height: 32
                    )
                 
        
                Text("\(tab)")
                    .Pro(
                        size: 12
                    )
            }
            .frame(maxWidth: .infinity)
            .opacity(selectedTab == tab ? 1 : 0.4)
        }
    }
}
