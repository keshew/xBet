import SwiftUI

struct BetChatListView: View {
    @StateObject var betChatListModel = BetChatListViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 30))
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        
                        Text("Chat list")
                            .ProBold(size: 24)
                            .padding(.trailing, 25)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        ForEach(betChatListModel.users) { user in
                            VStack {
                                HStack {
                                    Image(user.picture?.isEmpty == false ? user.picture! : "ava6")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(user.name)
                                            .ProBold(size: 18)
                                        
                                        Text(user.level)
                                            .Pro(size: 14, color: Color(red: 198/255, green: 209/255, blue: 217/255))
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        betChatListModel.selectedUser = user
                                        betChatListModel.isMessage = true
                                    }) {
                                        Image("message")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .padding(.trailing)
                                    }
                                }
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 0.8)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .onAppear() {
            betChatListModel.loadUsers()
        }
        .fullScreenCover(isPresented: $betChatListModel.isMessage) {
            if let selectedUser = betChatListModel.selectedUser {
                BetChatView(user: selectedUser)
            } else {
                Text("No user selected")
            }
        }
    }
}

#Preview {
    BetChatListView()
}

