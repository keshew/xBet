import SwiftUI

struct BetDiscussionsView: View {
    @StateObject var betDiscussionsModel = BetDiscussionsViewModel()
    @State private var showDiscussion = false
    @State private var isFinish = false
    @Environment(\.presentationMode) var presentationMode
    
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
                        
                        Text("Discussion")
                            .ProBold(size: 24)
                            .padding(.trailing, 20)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    if !betDiscussionsModel.newDiscussions.isEmpty {
                        HStack {
                            Text("New discussion")
                                .ProBold(size: 18)
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.top)
                        
                        VStack(spacing: 15) {
                            ForEach(betDiscussionsModel.newDiscussions) { discussion in
                                DiscussionRow(discussion: discussion)
                                    .onTapGesture {
                                           betDiscussionsModel.selectedDiscussion = discussion
                                           betDiscussionsModel.isPost = true
                                       }
                            }
                        }
                    }
                    
                    if !betDiscussionsModel.allDiscussions.isEmpty {
                        HStack {
                            Text("All discussion")
                                .ProBold(size: 18)
                                .padding(.leading)
                            Spacer()
                        }
                        .padding(.top)
                        
                        VStack(spacing: 15) {
                            ForEach(betDiscussionsModel.allDiscussions) { discussion in
                                DiscussionRow(discussion: discussion)
                                    .onTapGesture {
                                           betDiscussionsModel.selectedDiscussion = discussion
                                           betDiscussionsModel.isPost = true
                                       }
                            }
                        }
                    }
                }
            }
            .blur(radius: showDiscussion ? 5 : isFinish ? 5 : 0)
            .onAppear {
                betDiscussionsModel.loadDiscussions()
            }
            
            Button(action: {
                withAnimation {
                    showDiscussion = true
                }
            }) {
                Rectangle()
                    .fill(Color(red: 22/255, green: 159/255, blue: 253/255))
                    .overlay {
                        Text("Create a new discussion")
                            .Pro(size: 18)
                    }
                    .frame(height: 54)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom)
            .blur(radius: showDiscussion ? 5 : isFinish ? 5 : 0)
            
            if showDiscussion {
                BetAddDiscussionView(showDiscussion: $showDiscussion, isFinish: $isFinish)
                    .frame(height: 670)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .offset(y: 40)
            }
            
            if isFinish {
                Image(.customModal)
                    .resizable()
                    .overlay {
                        Text("Discussion successfully\nadded!")
                            .Pro(size: 18)
                            .multilineTextAlignment(.center)
                            .offset(y: 50)
                    }
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
        .fullScreenCover(isPresented: $betDiscussionsModel.isPost) {
            BetPostView(discussion: betDiscussionsModel.selectedDiscussion ?? Discussion(id: "", userId: "", title: "", text: "", dateAdded: Date()))
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

struct DiscussionRow: View {
    let discussion: Discussion
    
    var body: some View {
        VStack {
            HStack {
                Image(.ava2)
                    .resizable()
                    .frame(width: 60, height: 60)
                
                Text(discussion.title)
                    .Pro(size: 18)
                
                Spacer()
                
                Image(systemName: "envelope.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(.white)
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 0.8)
        }
        .padding(.horizontal)
    }
}


#Preview {
    BetDiscussionsView()
}

