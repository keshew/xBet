import SwiftUI

struct BetLoginView: View {
    @StateObject var betLoginModel =  BetLoginViewModel()

    var body: some View {
        ZStack {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            
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
                    .padding(.top, 350)
                }
            }
            .scrollDisabled(UIScreen.main.bounds.width > 380  ? true : false)
        }
    }
}

#Preview {
    BetLoginView()
}

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                .frame(height: 57)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 16)
            .frame(height: 47)
            .font(.custom("SFProDisplay-Regular", size: 15))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .Pro(size: 16, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                    .frame(height: 57)
                    .padding(.leading, 30)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                .frame(height: 57)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            HStack {
                if isSecure {
                    SecureField("", text: $text)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .font(.custom("SFProDisplay-Regular", size: 16))
                        .foregroundStyle(.white)
                        .focused($isTextFocused)
                } else {
                    TextField("", text: $text)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .font(.custom("SFProDisplay-Regular", size: 16))
                        .foregroundStyle(.white)
                        .focused($isTextFocused)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 57)
            .cornerRadius(9)
            .padding(.horizontal, 15)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .font(.custom("SFProDisplay-Regular", size: 16))
                    .foregroundColor(Color(red: 141/255, green: 160/255, blue: 179/255))
                    .frame(height: 57)
                    .padding(.leading, 30)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}
