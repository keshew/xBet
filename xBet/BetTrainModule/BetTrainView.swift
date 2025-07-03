import SwiftUI

struct BetTrainView: View {
    @StateObject var betTrainModel =  BetTrainViewModel()
    @State private var showAddScheduleView = false
    @State private var isTapped = false
    @State private var isFinish = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Nearest arenas")
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
                
                Rectangle()
                    .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(red: 21/255, green: 147/255, blue: 232/255))
                            .overlay {
                                HStack(spacing: 20) {
                                    Text("Add schedule")
                                        .ProBold(size: 24)
                                    
                                    Image(systemName: "plus")
                                        .font(.system(size: 44, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                            }
                    }
                    .frame(height: 200)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    .onTapGesture {
                        withAnimation {
                            showAddScheduleView = true
                        }
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
                
                HStack {
                    Text("Sparring opponents")
                        .ProBold(size: 20)
                        .padding(.leading)
                    
                    Spacer()
                }
                .padding(.top)
                
                VStack {
                    HStack {
                        Text("Filters")
                            .Pro(size: 15)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Rectangle()
                                    .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 21/255, green: 147/255, blue: 232/255), lineWidth: 0.5)
                                            .overlay {
                                                HStack(spacing: 10) {
                                                    Text("All weapons")
                                                        .Pro(size: 14)
                                                    
                                                    Image(systemName: "plus")
                                                        .font(.system(size: 14, weight: .regular))
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                    }
                                    .frame(width: 120, height: 30)
                                    .cornerRadius(12)
                                
                                Rectangle()
                                    .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 21/255, green: 147/255, blue: 232/255), lineWidth: 0.5)
                                            .overlay {
                                                HStack(spacing: 10) {
                                                    Text("Minsk")
                                                        .Pro(size: 14)
                                                    
                                                    Image(systemName: "plus")
                                                        .font(.system(size: 14, weight: .regular))
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                    }
                                    .frame(width: 90, height: 30)
                                    .cornerRadius(12)
                                
                                Rectangle()
                                    .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 21/255, green: 147/255, blue: 232/255), lineWidth: 0.5)
                                            .overlay {
                                                HStack(spacing: 10) {
                                                    Text("Training level")
                                                        .Pro(size: 14)
                                                    
                                                    Image(systemName: "plus")
                                                        .font(.system(size: 14, weight: .regular))
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                    }
                                    .frame(width: 120, height: 30)
                                    .cornerRadius(12)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    HStack {
                        Text("Найдено 24 соперника")
                            .Pro(size: 12, color: Color(red: 86/255, green: 113/255, blue: 142/255))
                            .padding(.leading)
                        
                        Spacer()
                    }
                }
                .padding(.top, 10)
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(0..<4, id: \.self) { index in
                            Rectangle()
                                .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 21/255, green: 147/255, blue: 232/255))
                                        .overlay {
                                            VStack(spacing: 15) {
                                                HStack(alignment: .top, spacing: 15) {
                                                    HStack(spacing: 15) {
                                                        Image(.avaOpponent)
                                                            .resizable()
                                                            .frame(width: 80, height: 80)
                                                        
                                                        VStack(alignment: .leading, spacing: 10) {
                                                            Text("Name opponents")
                                                                .ProBold(size: 22)
                                                            
                                                            Text("Professional level")
                                                                .Pro(size: 14, color: Color(red: 197/255, green: 207/255, blue: 214/255))
                                                        }
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                    Text("Rapier")
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
                                                    
                                                    Image("message")
                                                        .resizable()
                                                        .frame(width: 40, height: 40)
                                                        .padding(.trailing)
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                }
                                .frame(height: 210)
                                .cornerRadius(16)
                                .padding(.horizontal)
                        }
                        
                        Color.clear.frame(height: 80)
                    }
                }
                .padding(.top)
            }
            .blur(radius: showAddScheduleView ? 5 : isFinish ? 5 : 0)
            
            if showAddScheduleView {
                BetAddSheduleView(isTapped: $isTapped, isFinish: $isFinish, showAddScheduleView: $showAddScheduleView)
                    .frame(height: isTapped ? 700 : 440)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .offset(y: 40)
                
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
                        hideModalAfterDelay()
                    }
            }
        }
    }
    
    func hideModalAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                isFinish = false
            }
        }
    }
}

#Preview {
    BetTrainView()
}

