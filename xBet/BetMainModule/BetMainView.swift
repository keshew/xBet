import SwiftUI

struct BetMainView: View {
    @StateObject var betMainModel = BetMainViewModel()
    
    var body: some View {
        ZStack {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Hello, \(UserDefaultsManager().getName() ?? "user")!")
                            .ProBold(size: 32)
                        
                        Spacer()
                        
                        Button(action: {
                            betMainModel.isSettings = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 30))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.horizontal)
                    
                    Rectangle()
                        .fill(Color(red: 1/255, green: 10/255, blue: 21/255))
                        .overlay {
                            VStack(spacing: 20) {
                                HStack {
                                    Text("Updates")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                    
                                    Image(.message)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .padding(.trailing)
                                }
                                .padding(.horizontal, 20)
                                
                                HStack {
                                    Text("There are no upcoming meetings as of yet.\nCreate one in your calendar and it will show up\nhere for a reminder")
                                        .Pro(size: 16, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                        .padding(.leading, 20)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .frame(height: 140)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    
                    Rectangle()
                        .fill(Color(red: 1/255, green: 10/255, blue: 21/255))
                        .overlay {
                            HStack {
                                Spacer()
                                
                                Image(.calendarImg)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 250)
                            }
                            
                            VStack(spacing: 20) {
                                HStack {
                                    Text("Calendar")
                                        .ProBold(size: 24)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                
                                HStack {
                                    if betMainModel.trainings.isEmpty {
                                        Text("Create your first train!")
                                            .ProBold(size: 24)
                                            .padding(.horizontal)
                                            .frame(height: 100, alignment: .center)
                                    } else {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 16) {
                                                ForEach(betMainModel.trainings) { training in
                                                    Image(.calendarTrainingImg)
                                                        .resizable()
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 16)
                                                                .stroke(Color(red: 29/255, green: 65/255, blue: 104/255))
                                                                .overlay {
                                                                    VStack(spacing: 8) {
                                                                        HStack {
                                                                            Text("\(training.arenaName)")
                                                                                .Pro(size: 23)
                                                                            Spacer()
                                                                        }
                                                                        
                                                                        HStack {
                                                                            Text(formatDate(training.recordDate))
                                                                                .Pro(size: 14, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                                                            Spacer()
                                                                            Text(training.recordTime)
                                                                                .Pro(size: 14, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                                                        }
                                                                        
                                                                        HStack {
                                                                            Text(training.address)
                                                                                .Pro(size: 14, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                                                            Spacer()
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
                        }
                        .frame(height: 180)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    
                    Button(action: {
                        betMainModel.isDiscussion = true
                    }) {
                        Rectangle()
                            .fill(Color(red: 1/255, green: 10/255, blue: 21/255))
                            .overlay {
                                HStack(alignment: .top) {
                                    VStack(alignment: .leading, spacing: 10) {
                                    Text("Discussions")
                                            .ProBold(size: 24)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.7)
                                        
                                        Text("Communicate on any topic you want")
                                            .Pro(size: 16, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(30)
                                    
                                    Spacer()
                                    
                                    Image(.duisc)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 170, height: 270)
                                }
                                
                            }
                            .frame(height: 270)
                            .cornerRadius(16)
                            .padding(.horizontal)
                    }
                    
                    Color.clear.frame(height: 30)
                }
                .padding(.top)
            }
        }
        .fullScreenCover(isPresented: $betMainModel.isDiscussion) {
            BetDiscussionsView()
        }
        .fullScreenCover(isPresented: $betMainModel.isSettings) {
            BetSettingsView()
        }
    }
    
    func formatDate(_ isoDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: isoDate) else { return isoDate }
        formatter.dateFormat = "dd.MM"
        return formatter.string(from: date)
    }
}


#Preview {
    BetMainView()
}

