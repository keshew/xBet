import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isMe: Bool
}

struct BetChatView: View {
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hey, how about we practice? When do you have time?", isMe: true),
        ChatMessage(text: "Why not\nLet's go Friday at 4!", isMe: false)
    ]
    
    @State private var text: String = ""
    @State private var show = false
    @State private var isFinish = false
    @Environment(\.presentationMode) var presentationMode
    let user: User
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 28/255, green: 66/255, blue: 103/255)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    Text("Chat")
                        .ProBold(size: 24)
                        .padding(.trailing, 25)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                HStack(alignment: .top) {
                    Image((user.picture == "" ? "ava6" : user.picture) ?? "ava3")
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
                    Text(user.weapon)
                        .Pro(size: 14, color: Color(red: 198/255, green: 209/255, blue: 217/255))
                }
                .padding(.horizontal)
                .padding(.top, 25)
                .padding(.bottom, 8)
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(messages) { message in
                            HStack {
                                if message.isMe { Spacer() }
                                Text(message.text)
                                    .Pro(size: 16, color: .white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 16)
                                    .background(
                                        RoundedCornerShape(
                                            radius: 16,
                                            corners: message.isMe
                                            ? [.topLeft, .topRight, .bottomLeft]
                                            : [.topLeft, .topRight, .bottomRight]
                                        )
                                        .fill(
                                            message.isMe
                                            ? Color(red: 56/255, green: 164/255, blue: 255/255)
                                            : Color(red: 21/255, green: 52/255, blue: 83/255)
                                        )
                                    )
                                    .overlay(
                                        RoundedCornerShape(
                                            radius: 16,
                                            corners: message.isMe
                                            ? [.topLeft, .topRight, .bottomLeft]
                                            : [.topLeft, .topRight, .bottomRight]
                                        )
                                        .stroke(Color(red: 56/255, green: 164/255, blue: 255/255), lineWidth: 0.5)
                                    )
                                    .frame(maxWidth: 260, alignment: message.isMe ? .trailing : .leading)
                                if !message.isMe { Spacer() }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                
                Button(action: {
                    withAnimation {
                        show = true
                    }
                }) {
                    Text("Suggest a user event")
                        .Pro(size: 18, color: Color(red: 56/255, green: 164/255, blue: 255/255))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(red: 56/255, green: 164/255, blue: 255/255), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, -20)
                
                Rectangle()
                    .fill(Color(red: 33/255, green: 85/255, blue: 132/255))
                    .frame(height: 130)
                    .cornerRadius(26)
                    .overlay(content: {
                        HStack {
                            CustomTextFiled2(text: $text, placeholder: "Type text here")
                            
                            Button(action: sendMessage) {
                                Image(systemName: "paperplane.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                            }
                            .disabled(text.isEmpty)
                            .opacity(text.isEmpty ? 0.5 : 1)
                        }
                        .offset(y: -10)
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                    })
                    .ignoresSafeArea(edges: .bottom)
                    .offset(y: 40)
            }
            .blur(radius: show ? 5 : isFinish ? 5 : 0)
            
            if show {
                BetSuggestSparringView(isFinish: $isFinish, showAddScheduleView: $show)
                    .frame(height: 650)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .offset(y: 40)
            }
            
            if isFinish {
                Image(.modalInvaite)
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
        .onAppear() {
            loadMessages()
        }
    }
    
    func hideModalAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                isFinish = false
            }
        }
    }
    
    func loadMessages() {
        NetworkManager().getMessages(userId: UserDefaultsManager().getID() ?? "", withUserId: user.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let messagesArray = json["messages"] as? [[String: Any]] {
                        self.messages = messagesArray.compactMap { dict in
                            guard let text = dict["text"] as? String,
                                  let fromId = dict["from_user_id"] as? String else { return nil }
                            return ChatMessage(text: text, isMe: fromId == UserDefaultsManager().getID() ?? "")
                        }
                    }
                case .failure(let error):
                    print("Failed to load messages: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func sendMessage() {
        guard !text.isEmpty else { return }
        let messageText = text
        text = ""
        
        messages.append(ChatMessage(text: messageText, isMe: true))
        
        NetworkManager().sendMessage(fromUserId: UserDefaultsManager().getID() ?? "", toUserId: user.id, text: messageText, dateSent: ISO8601DateFormatter().string(from: Date())) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Message sent: \(success)")
                    } else if let error = json["error"] as? String {
                        print("Error sending message: \(error)")
                    }
                case .failure(let error):
                    print("Failed to send message: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct RoundedCornerShape: Shape {
    var radius: CGFloat = 16
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    let previewUser = User(
        id: "user_12345",
        name: "Ivan Ivanov",
        city: "Moscow",
        weapon: "Rapier",
        level: "Professional",
        email: "ivan@example.com",
        picture: nil
    )
    
    BetChatView(user: previewUser)
}

struct CustomTextFiled2: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                .frame(height: 52)
                .cornerRadius(12)
                .padding(.horizontal, 0)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 16)
            .frame(height: 47)
            .font(.custom("SFProDisplay-Regular", size: 15))
            .cornerRadius(9)
            .foregroundStyle(.white)
            .focused($isTextFocused)
            .padding(.horizontal, 0)
            
            if text.isEmpty && !isTextFocused {
                Text(placeholder)
                    .Pro(size: 16, color: Color(red: 141/255, green: 160/255, blue: 179/255))
                    .frame(height: 52)
                    .padding(.leading, 15)
                    .onTapGesture {
                        isTextFocused = true
                    }
            }
        }
    }
}
