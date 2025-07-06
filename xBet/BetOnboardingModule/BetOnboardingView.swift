import SwiftUI

struct BetOnboardingView: View {
    @StateObject var betOnboardingModel =  BetOnboardingViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(.onb)
                .resizable()
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Find like-minded people nearby to train, grow and win together.")
                        .Pro(size: 44)
                        .padding(.horizontal)
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            betOnboardingModel.isLog = true
                        }) {
                            Rectangle()
                                .fill(Color(red: 20/255, green: 160/255, blue: 255/255))
                                .overlay {
                                    Text("Log in")
                                        .Pro(size: 21)
                                }
                                .frame(height: 54)
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            betOnboardingModel.isSign = true
                        }) {
                            Rectangle()
                                .fill(Color(red: 126/255, green: 172/255, blue: 47/255))
                                .overlay {
                                    Text("Register")
                                        .Pro(size: 21)
                                }
                                .frame(height: 54)
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            betOnboardingModel.isTab = true
                            UserDefaultsManager().enterAsGuest()
                        }) {
                            VStack(spacing: 5) {
                                Text("Continue with guest access")
                                    .Pro(size: 21, color: Color(red: 20/255, green: 160/255, blue: 255/255))
                                
                                Rectangle()
                                    .fill(Color(red: 20/255, green: 160/255, blue: 255/255))
                                    .frame(height: 1)
                                    .cornerRadius(16)
                                    .padding(.horizontal, 100)
                            }
                        }
                    }
                }
                .padding(.top, UIScreen.main.bounds.width > 900 ? 1000 : UIScreen.main.bounds.width > 600 ? 850 :
                            UIScreen.main.bounds.width > 430 ? 450 : 370)
            }
            .scrollDisabled(UIScreen.main.bounds.width > 380  ? true : false)
        }
        .fullScreenCover(isPresented: $betOnboardingModel.isLog) {
            BetLoginView()
        }
        .fullScreenCover(isPresented: $betOnboardingModel.isSign) {
            BetSignView()
        }
        .fullScreenCover(isPresented: $betOnboardingModel.isTab) {
            BetTabBarView()
        }
    }
}

#Preview {
    BetOnboardingView()
}

