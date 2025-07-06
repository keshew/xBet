import SwiftUI

struct BetLoginView: View {
    @StateObject var betLoginModel = BetLoginViewModel()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            betLoginModel.isSign = true
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 30))
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        
                        Text("Welcome back")
                            .ProBold(size: 24)
                            .padding(.trailing, 20)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Sign in to continue organizing  your schedule")
                            .Pro(size: 18)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    
                    VStack(spacing: 20) {
                        VStack {
                            HStack {
                                Text("e-mail")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betLoginModel.email, placeholder: "Your e-mail")
                        }
                        
                        VStack {
                            HStack {
                                Text("Password")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomSecureField(text: $betLoginModel.password, placeholder: "Your password")
                        }
                    }
                    .padding(.top)
                    
                    VStack(spacing: 15) {
                        Button(action: {
                            login()
                        }) {
                            Rectangle()
                                .fill(Color(red: 20/255, green: 160/255, blue: 255/255))
                                .overlay {
                                    Text("Log in")
                                        .Pro(size: 21)
                                }
                                .frame(height: 57)
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                        
                        Button(action: {
                            UserDefaultsManager().enterAsGuest()
                            betLoginModel.isTab = true
                        }) {
                            Rectangle()
                                .fill(.clear)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 20/255, green: 160/255, blue: 255/255), lineWidth: 2)
                                    Text("Skip")
                                        .Pro(size: 21, color: Color(red: 20/255, green: 160/255, blue: 255/255))
                                }
                                .frame(height: 57)
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                        
                        HStack(alignment: .top, spacing: 5) {
                            Text("Don't have an account?")
                                .Pro(size: 16, color: Color(red: 86/255, green: 113/255, blue: 142/255))
                            
                            Button(action: {
                                betLoginModel.isSign = true
                            }) {
                                VStack(spacing: 3) {
                                    Text("Sign Up")
                                        .Pro(size: 16, color: Color(red: 20/255, green: 160/255, blue: 255/255))
                                    
                                    Rectangle()
                                        .fill(Color(red: 20/255, green: 160/255, blue: 255/255))
                                        .frame(width: 60, height: 1)
                                        .cornerRadius(16)
                                }
                            }
                        }
                    }
                    .padding(.top, UIScreen.main.bounds.width > 900 ? 800 : UIScreen.main.bounds.width > 600 ? 650 :  UIScreen.main.bounds.width > 430 ? 350 : 280)
                }
            }
            .scrollDisabled(UIScreen.main.bounds.width > 380  ? true : false)
        }
        .fullScreenCover(isPresented: $betLoginModel.isSign) {
            BetSignView()
        }
        .fullScreenCover(isPresented: $betLoginModel.isTab) {
            BetTabBarView()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func login() {
        if betLoginModel.email.isEmpty || betLoginModel.password.isEmpty {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        NetworkManager().login(email: betLoginModel.email, password: betLoginModel.password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let error = json["error"] as? String {
                        alertMessage = error
                        showAlert = true
                    } else if let user = json["user"] as? [String: Any] {
                        if let userId = user["user_id"] as? String {
                            UserDefaultsManager().saveID(userId)
                            UserDefaultsManager().saveCurrentEmail(betLoginModel.email)
                            UserDefaultsManager().savePassword(betLoginModel.password)
                            
                            if let name = user["name"] as? String {
                                UserDefaultsManager().saveName(name)
                            }
                            if let city = user["city"] as? String {
                                UserDefaultsManager().saveCity(city)
                            }
                            if let level = user["level"] as? String {
                                UserDefaultsManager().saveLevel(level)
                            }
                            if let weaponType = user["weapon"] as? String {
                                UserDefaultsManager().saveWeapon(weaponType)
                            }
                            
                            if let picture = user["picture"] as? String {
                                UserDefaultsManager().saveImage(picture)
                            }
                            
                            UserDefaultsManager().saveLoginStatus(true)
                        }
                        betLoginModel.isTab = true
                    } else {
                        alertMessage = "Unexpected response from server."
                        showAlert = true
                    }
                case .failure(let error):
                    alertMessage = error.localizedDescription
                    showAlert = true
                }
            }
        }
    }
}


#Preview {
    BetLoginView()
}
