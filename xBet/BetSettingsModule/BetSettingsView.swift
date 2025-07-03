import SwiftUI

struct BetSettingsView: View {
    @StateObject var betSettingsModel =  BetSettingsViewModel()

    var body: some View {
        ZStack {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                    
                    Text("Settings")
                        .ProBold(size: 24)
                        .padding(.trailing, 20)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Notification")
                        .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                        .padding(.leading)
                    
                    Spacer()
                }
                .padding(.top, 30)
                
                VStack {
                    HStack {
                        Text("Push notification")
                            .Pro(size: 20)
                        
                        Toggle("", isOn: $betSettingsModel.isNotif)
                            .toggleStyle(CustomToggleStyle())
                    }
                    
                    Rectangle()
                        .fill(Color(red: 141/255, green: 160/255, blue: 179/255))
                        .frame(height: 1)
                    
                    HStack {
                        Text("E-mail notification")
                            .Pro(size: 20)
                        
                        Toggle("", isOn: $betSettingsModel.isEmail)
                            .toggleStyle(CustomToggleStyle())
                    }
                    
                    Rectangle()
                        .fill(Color(red: 141/255, green: 160/255, blue: 179/255))
                        .frame(height: 1)
                }
                .padding(.horizontal)
                
                HStack(spacing: 10) {
                    Image(.avaOpponent)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    VStack(alignment: .leading) {
                        Text("You can choose a ")
                            .font(.custom("SFProDisplay-Regular", size: 18))
                            .foregroundColor(.white)
                            + Text("ready-made photo or upload your own")
                                .underline()
                                .font(.custom("SFProDisplay-Regular", size: 18))
                                .foregroundColor(.white)
                    }
                    .onTapGesture {
                        
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 20) {
                        VStack {
                            HStack {
                                Text("Your name")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSettingsModel.name, placeholder: "Alex")
                        }
                        
                        VStack {
                            HStack {
                                Text("Your city")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSettingsModel.city, placeholder: "Minsk")
                        }
                        
                        VStack {
                            HStack {
                                Text("Prerequisite weapon type")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSettingsModel.weaponType, placeholder: "Sable")
                        }
                        
                        VStack {
                            HStack {
                                Text("Preparation level")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSettingsModel.level, placeholder: "Low")
                        }
                        
                        VStack {
                            HStack {
                                Text("Your e-mail")
                                    .Pro(size: 12, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled(text: $betSettingsModel.email, placeholder: "artom@uandex.cim")
                        }
                    }
                    .padding(.vertical)
                }
                .frame(maxHeight: .infinity)
                
                VStack(spacing: 15) {
                    Button(action: {
                        
                    }) {
                        Rectangle()
                            .fill(Color(red: 20/255, green: 160/255, blue: 255/255))
                            .overlay {
                                Text("Save")
                                    .Pro(size: 21)
                            }
                            .frame(height: 57)
                            .cornerRadius(16)
                            .padding(.horizontal)
                    }
                    
                    HStack(alignment: .top, spacing: 10) {
                        Text("Want to delete an account?")
                            .Pro(size: 16, color: Color(red: 86/255, green: 113/255, blue: 142/255))
                        
                        Button(action: {
                            
                        }) {
                            VStack(spacing: 3) {
                                Text("Delete")
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
    }
}

#Preview {
    BetSettingsView()
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 33/255, green: 85/255, blue: 132/255) : Color(red: 33/255, green: 85/255, blue: 131/255))
                .frame(width: 60, height: 30)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 27/255, green: 123/255, blue: 193/255))
                        .frame(width: 23, height: 23)
                        .offset(x: configuration.isOn ? 13 : -13)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding()
    }
}
