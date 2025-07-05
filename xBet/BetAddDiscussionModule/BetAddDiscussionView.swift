import SwiftUI

struct BetAddDiscussionView: View {
    @StateObject var betAddDiscussionModel = BetAddDiscussionViewModel()

    @Binding var showDiscussion: Bool
    @Binding var isFinish: Bool
    
    @State private var text = ""
    @State private var title = ""
    
    @State private var selectedIndex: Int? = nil
    @State private var showingPhotoPicker = false
    @State private var pickedImage: UIImage? = nil
    
    let userId = UserDefaultsManager().getID() ?? ""
    
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
                                    Text("New discussion")
                                        .ProBold(size: 24)
                                        .padding(.top)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    if let image = pickedImage {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipShape(Circle())
                                    } else {
                                        Image(.ava3)
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                    }
                                    
                                    Button(action: {
                                        showingPhotoPicker = true
                                    }) {
                                        Text("Upload new photo")
                                            .Pro(size: 16)
                                            .underline()
                                    }
                                    .sheet(isPresented: $showingPhotoPicker) {
                                        PhotoPicker(selectedImage: $pickedImage)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                                CustomTextFiled(text: $title, placeholder: "Title discussion")
                                    .padding(.top, 5)
                                
                                CustomTextView(text: $text, placeholder: "Share your results!")
                                    .padding(.top, 5)
                                
                                HStack {
                                    Text(formattedDate)
                                        .Pro(size: 16)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                .padding(.top)
                                
                                Button(action: {
                                    createDiscussion()
                                }) {
                                    Rectangle()
                                        .fill(Color(red: 126/255, green: 172/255, blue: 47/255))
                                        .overlay {
                                            Text("Create discussion")
                                                .Pro(size: 21)
                                                .foregroundColor(.white)
                                        }
                                        .frame(height: 54)
                                        .cornerRadius(16)
                                        .padding(.horizontal)
                                }
                                .padding(.top, 10)
                                .opacity(text.isEmpty || title.isEmpty ? 0.5 : 1)
                                .disabled(text.isEmpty || title.isEmpty)
                                
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
    
    private func createDiscussion() {
        betAddDiscussionModel.addDiscussion(userId: userId, title: title, text: text, dateAdded: formattedDate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Discussion created: \(success)")
                        withAnimation {
                            showDiscussion = false
                            isFinish = true
                        }
                    } else if let error = json["error"] as? String {
                        print("Error creating discussion: \(error)")
                    }
                case .failure(let error):
                    print("Failed to create discussion: \(error.localizedDescription)")
                }
            }
        }
    }
}


#Preview {
    BetAddDiscussionView(showDiscussion: .constant(false), isFinish: .constant(false))
}

