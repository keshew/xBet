import SwiftUI

struct BetNewCommentView: View {
    @StateObject var betNewCommentModel = BetNewCommentViewModel()
    
    @Binding var showAddTraining: Bool
    @Binding var isFinish: Bool
    
    @State private var text = ""
    
    let discussionId: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(red: 21/255, green: 157/255, blue: 252/255))
                        .overlay {
                            VStack {
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: 3)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 170)
                                    .padding(.top, 15)
                                
                                HStack {
                                    Text("New comment")
                                        .ProBold(size: 24)
                                        .padding(.top)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                CustomTextView(text: $text, placeholder: "Text comment")
                                
                                HStack {
                                    Text(formattedDate)
                                        .Pro(size: 16)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                .padding(.top)
                                
                                Button(action: {
                                    submitComment()
                                }) {
                                    Rectangle()
                                        .fill(Color(red: 20/255, green: 160/255, blue: 255/255))
                                        .overlay {
                                            Text("Leave a comment")
                                                .Pro(size: 21)
                                                .foregroundColor(.white)
                                        }
                                        .frame(height: 54)
                                        .cornerRadius(16)
                                        .padding(.horizontal)
                                }
                                .padding(.top, 10)
                                .opacity(text.isEmpty ? 0.5 : 1)
                                .disabled(text.isEmpty)
                                
                                Spacer()
                            }
                        }
                }
        }
        .cornerRadius(16)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: Date())
    }
    
    private func submitComment() {
        betNewCommentModel.addComment(discussionId: discussionId, name: "UserName", text: text, dateSent: formattedDate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Comment added: \(success)")
                        withAnimation {
                            showAddTraining = false
                            isFinish = true
                        }
                    } else if let error = json["error"] as? String {
                        print("Error adding comment: \(error)")
                    }
                case .failure(let error):
                    print("Failed to add comment: \(error.localizedDescription)")
                }
            }
        }
    }
}


#Preview {
    BetNewCommentView(showAddTraining: .constant(false), isFinish: .constant(false), discussionId: "")
}

