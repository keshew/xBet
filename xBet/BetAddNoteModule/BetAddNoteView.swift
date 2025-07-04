import SwiftUI

import SwiftUI

struct BetAddNoteView: View {
    @StateObject var betAddNoteModel = BetAddNoteViewModel()
    
    @Binding var showAddTraining: Bool
    @Binding var isFinish: Bool
    
    @State private var text = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                                
                                Text("New note")
                                    .ProBold(size: 24)
                                    .padding(.top)
                                
                                CustomTextView(text: $text, placeholder: "Share your results!")
                                
                                HStack {
                                    Text(formattedDate)
                                        .Pro(size: 16)
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                .padding(.top)
                                
                                Button(action: {
                                    addDiaryEntry()
                                }) {
                                    Rectangle()
                                        .fill(Color(red: 126/255, green: 172/255, blue: 47/255))
                                        .overlay {
                                            Text("Add a note")
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: Date())
    }
    
    private func addDiaryEntry() {
        //MARK: - here change
        let userId = "user_686835ca2f1095.82273141"
        
        NetworkManager().addDiary(userId: userId, date: formattedDate, text: text) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let error = json["error"] as? String {
                        alertMessage = error
                        showAlert = true
                    } else {
                        // Успешно добавлено
                        withAnimation {
                            showAddTraining = false
                            isFinish = true
                        }
                    }
                case .failure(let error):
                    alertMessage = error.localizedDescription
                    showAlert = true
                }
            }
        }
    }
}

#Preview {
    BetAddNoteView(showAddTraining: .constant(false), isFinish: .constant(false))
}


