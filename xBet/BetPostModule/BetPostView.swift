import SwiftUI

struct BetPostView: View {
    @StateObject var betPostModel = BetPostViewModel()
    @State private var isShow = false
    @State private var isFinish = false
    @Environment(\.presentationMode) var presentationMode
    let discussion: Discussion
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
                                    Text(discussion.title)
                                        .ProBold(size: 22)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(discussion.text)
                                        .Pro(size: 18)
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                            .padding()
                        }
                        .frame(height: 280)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    HStack {
                        Text("Comments on the post")
                            .ProBold(size: 18)
                        
                        Spacer()
                    }
                    .padding()
                    
                    VStack(spacing: 20) {
                        ForEach(betPostModel.comments) { comment in
                            VStack(spacing: 10) {
                                HStack {
                                    Text(comment.name)
                                        .ProBold(size: 18)
                                    
                                    Spacer()
                                    
                                    Text(Comment.dateFormatter.string(from: comment.dateSent))
                                        .Pro(size: 14, color: Color(red: 99/255, green: 125/255, blue: 151/255))
                                }
                                
                                HStack {
                                    Text(comment.text)
                                        .Pro(size: 14)
                                        .lineLimit(nil)
                                    
                                    Spacer()
                                }
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height: 0.3)
                            }
                            .padding(.horizontal)
                        }
                        
                        Color.clear.frame(height: 70)
                    }
                }
            }
            .blur(radius: isShow ? 5 : isFinish ? 5 : 0)
            .onAppear {
                betPostModel.loadComments(for: discussion.id)
            }
            
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
                BetNewCommentView(showAddTraining: $isShow, isFinish: $isFinish, discussionId: discussion.id)
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
                        betPostModel.loadComments(for: discussion.id)
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
    BetPostView(discussion: Discussion(id: "", userId: "", title: "", text: "", dateAdded: Date()))
}

