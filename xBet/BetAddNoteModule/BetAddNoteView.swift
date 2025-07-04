import SwiftUI

struct BetAddNoteView: View {
    @StateObject var betAddNoteModel =  BetAddNoteViewModel()
    
    @Binding var showAddTraining: Bool
    @Binding var isFinish: Bool
    
    @State private var text = ""
    
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
                                    withAnimation {
                                        showAddTraining = false
                                        isFinish = true
                                    }
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
    }
    
    private var formattedDate: String {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd.MM.yyyy"
           return formatter.string(from: Date())
       }
}

#Preview {
    BetAddNoteView(showAddTraining: .constant(false), isFinish: .constant(false))
}

struct CustomTextView: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var placeholder: String
    var height: CGFloat = 260
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                .cornerRadius(16)
                .padding(.horizontal)
            
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, 15)
                .padding(.horizontal)
                .padding(.top, 5)
                .frame(height: height)
                .font(.custom("SFProDisplay-Regular", size: 18))
                .foregroundStyle(.white)
                .focused($isTextFocused)
            
            if text.isEmpty && !isTextFocused {
                VStack {
                    Text(placeholder)
                        .Pro(size: 18, color: Color(red: 153/255, green: 173/255, blue: 200/255))
                        .padding(.leading, 15)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        .onTapGesture {
                            isTextFocused = true
                        }
                    Spacer()
                }
            }
        }
        .frame(height: height)
    }
}
