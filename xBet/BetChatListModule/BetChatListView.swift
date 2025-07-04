import SwiftUI

struct BetChatListView: View {
    @StateObject var betChatListModel =  BetChatListViewModel()

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
                        
                        Text("Chat list")
                            .ProBold(size: 24)
                            .padding(.trailing, 25)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        ForEach(0..<4, id: \.self) { index in
                            VStack {
                                HStack {
                                    Image(.ava6)
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Name opponents")
                                            .ProBold(size: 18)
                                        
                                        Text("Professional level")
                                            .Pro(size: 14, color: Color(red: 198/255, green: 209/255, blue: 217/255))
                                    }
                                    
                                    Spacer()
                                    
                                    Image(.message)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.trailing)
                                }
                                
                                Rectangle()
                                    .fill(.gray.opacity(0.5))
                                    .frame(height: 0.8)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BetChatListView()
}

