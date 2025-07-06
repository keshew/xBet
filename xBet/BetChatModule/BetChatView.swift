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
    
    @State private var sparringInvites: [[String: Any]] = []
    
    @State var isShowAgree = false
    @State var isShowNo = false
    
    @Environment(\.presentationMode) var presentationMode
    
    let user: User
    
    var pendingInvites: [[String: Any]] {
        sparringInvites.filter { invite in
            if let accepted = invite["accepted"] as? Bool? {
                return accepted == nil
            }
            return true
        }
    }
    
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
                
                if pendingInvites.isEmpty {
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
                } else {
                    let invite = pendingInvites[0]
                    
                    VStack(spacing: 15) {
                        Rectangle()
                            .fill(.gray.opacity(0.7))
                            .frame(height: 0.7)
                        
                        Text("A user suggested event for you\nDo you agree?")
                            .Pro(size: 18)
                            .multilineTextAlignment(.center)
                        
                        HStack {
                            Button(action: {
                                respondToInvite(inviteId: invite["id"] as? String, accepted: true)
                            }) {
                                Rectangle()
                                    .fill(Color(red: 126/255, green: 172/255, blue: 47/255))
                                    .frame(height: 54)
                                    .cornerRadius(12)
                                    .overlay {
                                        Text("Yes")
                                            .Pro(size: 18)
                                    }
                            }
                            
                            Button(action: {
                                respondToInvite(inviteId: invite["id"] as? String, accepted: false)
                            }) {
                                Rectangle()
                                    .fill(Color(red: 56/255, green: 164/255, blue: 255/255))
                                    .frame(height: 54)
                                    .cornerRadius(12)
                                    .overlay {
                                        Text("No")
                                            .Pro(size: 18)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, -20)
                }
                
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
            .blur(radius: show ? 5 : isFinish ? 5 : isShowNo ? 5 : isShowAgree ? 5 : 0)
            
            if show {
                BetSuggestSparringView(isFinish: $isFinish, showAddScheduleView: $show, fromUserId: UserDefaultsManager().getID() ?? "", toUserId: user.id)
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
            
            if isShowNo {
                Image(.discagree)
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
            
            if isShowAgree {
                Image(.agree)
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
            loadSparringInvites()
        }
    }
    
    func hideModalAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                isFinish = false
                isShowAgree = false
                isShowNo = false
            }
        }
    }
    
    func respondToInvite(inviteId: String?, accepted: Bool) {
        guard let inviteId = inviteId else { return }
        
        NetworkManager().respondInvite(inviteId: inviteId, accepted: accepted) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Invite response saved: \(success)")
                        sparringInvites.removeAll { $0["id"] as? String == inviteId }
                        
                        if accepted {
                            isShowAgree = true
                            
                            if let invite = sparringInvites.first(where: { $0["id"] as? String == inviteId }) {
                                let dayOfWeek = invite["day_of_week"] as? String ?? ""
                                let place = invite["place"] as? String ?? ""
                                let time = ""
                                let fromUserId = invite["from_user_id"] as? String ?? ""
                                
                                NetworkManager().addSparring(userId: fromUserId, dayOfWeek: dayOfWeek, time: time, place: place) { sparringResult in
                                    DispatchQueue.main.async {
                                        switch sparringResult {
                                        case .success(let sparringJson):
                                            print("Sparring created: \(sparringJson)")
                                        case .failure(let error):
                                            print("Failed to create sparring: \(error.localizedDescription)")
                                        }
                                    }
                                }
                            }
                            
                        } else {
                            isShowNo = true
                        }
                        
                    } else if let error = json["error"] as? String {
                        print("Error responding to invite: \(error)")
                    }
                case .failure(let error):
                    print("Failed to respond to invite: \(error.localizedDescription)")
                }
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
    
    func loadSparringInvites() {
        NetworkManager().getSparringInvites(userId: UserDefaultsManager().getID() ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let invites = json["invites"] as? [[String: Any]] {
                        self.sparringInvites = invites
                        print(UserDefaultsManager().getID()!)
                    } else {
                        self.sparringInvites = []
                    }
                case .failure(let error):
                    print("Failed to load sparring invites: \(error.localizedDescription)")
                    self.sparringInvites = []
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


