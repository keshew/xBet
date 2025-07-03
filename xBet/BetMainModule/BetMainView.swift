import SwiftUI

struct BetMainView: View {
    @StateObject var betMainModel =  BetMainViewModel()

    var body: some View {
        ZStack {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Hello, Alexandr!")
                            .ProBold(size: 32)
                        
                        Spacer()
                        
                        Button(action: {
                            
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
                        .frame(height: 150)
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
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 16) {
                                            ForEach(0..<3, id: \.self) { index in
                                                Image(.calendarTrainingImg)
                                                    .resizable()
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Color(red: 29/255, green: 65/255, blue: 104/255))
                                                            .overlay {
                                                                VStack(spacing: 8) {
                                                                    HStack {
                                                                        Text("Training with Alexandr")
                                                                            .Pro(size: 23)
                                                                        Spacer()
                                                                    }

                                                                    HStack {
                                                                        Text("24.06")
                                                                            .Pro(size: 14, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                                                        Spacer()
                                                                        Text("19:30")
                                                                            .Pro(size: 14, color: Color(red: 191/255, green: 194/255, blue: 195/255))
                                                                    }

                                                                    HStack {
                                                                        Text("Milskshake str.32")
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
                                }
                                .padding(.horizontal)

                            }
                        }
                        .frame(height: 190)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    
                    Image(.block3)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 280)
                        .padding(.horizontal)
                }
                .padding(.top)
            }
            .scrollDisabled(UIScreen.main.bounds.width > 380  ? true : false)
        }
    }
}

#Preview {
    BetMainView()
}

