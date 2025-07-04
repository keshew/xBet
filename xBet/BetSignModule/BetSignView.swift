import SwiftUI

struct BetSignView: View {
    @StateObject var betSignModel = BetSignViewModel()
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        betSignModel.isLogin = true
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
                
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 20) {
                        VStack {
                            HStack {
                                Text("Your name")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSignModel.name, placeholder: "Enter name")
                        }
                        
                        VStack {
                            HStack {
                                Text("Your city")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSignModel.city, placeholder: "Write your city")
                        }
                        
                        VStack {
                            HStack {
                                Text("Prerequisite weapon type")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSignModel.weaponType, placeholder: "Type")
                        }
                        
                        VStack {
                            HStack {
                                Text("Preparation level")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSignModel.level, placeholder: "Low, medium, high")
                        }
                        
                        VStack {
                            HStack {
                                Text("Your e-mail")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSignModel.email, placeholder: "Enter e-mail")
                        }
                        
                        VStack {
                            HStack {
                                Text("Your password")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomSecureField(text: $betSignModel.password, placeholder: "Enter password")
                        }
                    }
                    .padding(.vertical)
                }
                .frame(maxHeight: .infinity)
                
                VStack(spacing: 15) {
                    Button(action: {
                        register()
                    }) {
                        Rectangle()
                            .fill(Color(red: 20/255, green: 160/255, blue: 255/255))
                            .overlay {
                                Text("Register")
                                    .Pro(size: 21)
                            }
                            .frame(height: 57)
                            .cornerRadius(16)
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        // Skip action if needed
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
                        Text("Do you have an account?")
                            .Pro(size: 16, color: Color(red: 86/255, green: 113/255, blue: 142/255))
                        
                        Button(action: {
                            betSignModel.isLogin = true
                        }) {
                            VStack(spacing: 3) {
                                Text("Log in")
                                    .Pro(size: 16, color: Color(red: 20/255, green: 160/255, blue: 255/255))
                                
                                Rectangle()
                                    .fill(Color(red: 20/255, green: 160/255, blue: 255/255))
                                    .frame(width: 40, height: 1)
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $betSignModel.isLogin) {
            BetLoginView()
        }
        .fullScreenCover(isPresented: $betSignModel.isTab) {
            BetTabBarView()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func register() {
        if betSignModel.name.isEmpty ||
            betSignModel.city.isEmpty ||
            betSignModel.weaponType.isEmpty ||
            betSignModel.level.isEmpty ||
            betSignModel.email.isEmpty ||
            betSignModel.password.isEmpty {
            
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        NetworkManager().registration(
            name: betSignModel.name,
            city: betSignModel.city,
            weapon: betSignModel.weaponType,
            level: betSignModel.level,
            email: betSignModel.email,
            password: betSignModel.password,
            picture: ""
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let error = json["error"] as? String {
                        alertMessage = error
                        showAlert = true
                    } else {
                        betSignModel.isTab = true
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
    BetSignView()
}

