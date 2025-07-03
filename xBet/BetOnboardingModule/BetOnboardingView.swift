import SwiftUI

struct BetOnboardingView: View {
    @StateObject var betOnboardingModel =  BetOnboardingViewModel()

    var body: some View {
        ZStack {
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
                .padding(.top, 450)
            }
            .scrollDisabled(UIScreen.main.bounds.width > 380  ? true : false)
        }
    }
}

#Preview {
    BetOnboardingView()
}

