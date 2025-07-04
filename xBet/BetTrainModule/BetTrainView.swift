import SwiftUI

struct BetTrainView: View {
    @StateObject var betTrainModel = BetTrainViewModel()
    @State private var showAddScheduleView = false
    @State private var isTapped = false
    @State private var isFinish = false
    
    let userId = "user_686835ca2f1095.82273141"
    
    func formatDate(_ dateString: String) -> String {
        return dateString
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    HStack {
                        Text("Your training")
                            .ProBold(size: 32)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showAddScheduleView = true
                            }
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    if betTrainModel.practices.isEmpty {
                        Rectangle()
                            .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 21/255, green: 147/255, blue: 232/255))
                                    .overlay {
                                        HStack(spacing: 20) {
                                            Text("There are no upcoming events or chats")
                                                .ProBold(size: 20)
                                            
                                            Image("message")
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                            }
                            .frame(height: 100)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .onTapGesture {
                                betTrainModel.isMessageList = true
                            }
                    } else {
                        Rectangle()
                            .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 21/255, green: 147/255, blue: 232/255))
                                
                                VStack(spacing: 20) {
                                    HStack {
                                        Text("Events")
                                            .ProBold(size: 24)
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, 20)
                                    
                                    HStack {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 16) {
                                                ForEach(betTrainModel.practices) { training in
                                                    Color.clear
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color(red: 29/255, green: 65/255, blue: 104/255), lineWidth: 3)
                                                                .overlay {
                                                                    VStack(spacing: 20) {
                                                                        HStack {
                                                                            Text("Practice on \(training.dayOfWeek)")
                                                                                .Pro(size: 23)
                                                                            
                                                                            Spacer()
                                                                        }
                                                                        
                                                                        HStack {
                                                                            Text("\(training.dayOfWeek)")
                                                                                .Pro(size: 14, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                                                            Spacer()
                                                                            Text("\(training.time)")
                                                                                .Pro(size: 14, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                                                        }
                                                                    }
                                                                    .padding(.horizontal)
                                                                }
                                                        }
                                                        .frame(width: 270, height: 100)
                                                        .cornerRadius(16)
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                        
                                    }
                                }
                            }
                            .frame(height: 180)
                            .cornerRadius(16)
                            .padding(.horizontal)
                    }
                    
                    Rectangle()
                        .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 21/255, green: 147/255, blue: 232/255))
                                .overlay {
                                    HStack(spacing: 20) {
                                        Text("There are no upcoming events or chats")
                                            .ProBold(size: 20)
                                        
                                        Image("message")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                        }
                        .frame(height: 100)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .onTapGesture {
                            betTrainModel.isMessageList = true
                        }
                    
                    HStack {
                        Text("Sparring opponents")
                            .ProBold(size: 20)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding(.top)
                    
                    VStack {
                        ForEach(betTrainModel.users.prefix(10)) { user in
                            Rectangle()
                                .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 21/255, green: 147/255, blue: 232/255))
                                        .overlay {
                                            VStack(spacing: 15) {
                                                HStack(alignment: .top, spacing: 15) {
                                                    HStack(spacing: 15) {
                                                        Image(user.picture == "" ? "ava6" : user.picture!)
                                                            .resizable()
                                                            .frame(width: 80, height: 80)
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text(user.name)
                                                                .ProBold(size: 22)
                                                            Text(user.level)
                                                                .Pro(size: 14, color: Color(red: 197/255, green: 207/255, blue: 214/255))
                                                        }
                                                    }
                                                    Spacer()
                                                    Text(user.weapon)
                                                        .Pro(size: 14, color: Color(red: 197/255, green: 207/255, blue: 214/255))
                                                }
                                                HStack {
                                                    Rectangle()
                                                        .fill(Color(red: 18/255, green: 46/255, blue: 74/255))
                                                        .overlay {
                                                            HStack {
                                                                Text("I'm ready to fight the best of the best!\nYou want to see what you can do?")
                                                                    .Pro(size: 14)
                                                                    .padding(.leading)
                                                                Spacer()
                                                            }
                                                        }
                                                        .frame(height: 70)
                                                        .cornerRadius(16)
                                                        .padding(.trailing)
                                                    Button(action: {
                                                        betTrainModel.selectedUser = user
                                                        betTrainModel.isMessage = true
                                                    }) {
                                                        Image("message")
                                                            .resizable()
                                                            .frame(width: 40, height: 40)
                                                            .padding(.trailing)
                                                    }
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                }
                                .frame(height: 210)
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                    }
                    
                    Color.clear.frame(height: 80)
                }
                .padding(.top)
            }
            .blur(radius: showAddScheduleView ? 5 : isFinish ? 5 : 0)
            .onTapGesture {
                showAddScheduleView = false
            }
            
            if showAddScheduleView {
                BetAddSheduleView(isTapped: $isTapped, isFinish: $isFinish, showAddScheduleView: $showAddScheduleView)
                    .frame(height: isTapped ? 700 : 440)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .offset(y: -40)
            }
            
            if isFinish {
                Image(.modalSchedule)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 230)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 300)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                isFinish = false
                            }
                        }
                    }
            }
        }
        .fullScreenCover(isPresented: $betTrainModel.isMessage) {
            BetChatView(user: betTrainModel.selectedUser ?? User(id: "", name: "", city: "", weapon: "", level: "", email: "", picture: ""))
        }
        .fullScreenCover(isPresented: $betTrainModel.isMessageList) {
            BetChatListView()
        }
        .onAppear {
            betTrainModel.loadPractices(userId: userId)
            betTrainModel.loadUsers()
        }
    }
}

#Preview {
    BetTrainView()
}
