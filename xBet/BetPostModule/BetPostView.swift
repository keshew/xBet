import SwiftUI

struct BetPostView: View {
    @StateObject var betPostModel =  BetPostViewModel()
    @State private var isShow = false
    @State private var isFinish = false
    var body: some View {
        ZStack(alignment: .bottom) {
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
                        
                        Text("Post title")
                            .ProBold(size: 24)
                            .padding(.trailing, 25)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Rectangle()
                        .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                        .overlay {
                            VStack(spacing: 15) {
                                HStack {
                                    Text("Post title")
                                        .ProBold(size: 22)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Question from the forum. It's never too late to learn. And considering that the lower threshold at the veteran world championships is 50 years old, you have a good chance of winning gold. :-) You will master it in 30 ( 20, 10 ) years. And seriously, this is a question first of all to yourself. If you are interested and have an opportunity, what does age have to do with it?")
                                        .Pro(size: 18)
                                    
                                    Spacer()
                                }
                            }
                            .padding()
                        }
                        .frame(height: 280)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Comments on the post")
                            .ProBold(size: 18)
                        
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: 20) {
                        ForEach(0..<8, id: \.self) { index in
                            VStack(spacing: 10) {
                                HStack {
                                    Text("Alex")
                                        .ProBold(size: 18)
                                    
                                    Spacer()
                                    
                                    Text("01.06.2025")
                                        .Pro(size: 14, color: Color(red: 99/255, green: 125/255, blue: 151/255))
                                }
                                
                                HStack {
                                    Text("the text of a comment written by the user")
                                        .Pro(size: 14)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                }
                                
                                Rectangle()
                                    .fill(.gray.opacity(0.5))
                                    .frame(height: 0.3)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .blur(radius: isShow ? 5 : isFinish ? 5 : 0)
            
            Button(action: {
                withAnimation {
                    isShow = true
                }
            }) {
                Rectangle()
                    .fill(Color(red: 22/255, green: 159/255, blue: 253/255))
                    .overlay {
                        Text("Leave a comment")
                            .Pro(size: 18)
                    }
                    .frame(height: 54)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom)
            .blur(radius: isShow ? 5 : isFinish ? 5 : 0)
            
            if isShow {
                BetNewCommentView(showAddTraining: $isShow, isFinish: $isFinish)
                    .frame(height: 520)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .offset(y: 40)
            }
            
            if isFinish {
                Image(.commentModal)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 230)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 340)
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
    BetPostView()
}

