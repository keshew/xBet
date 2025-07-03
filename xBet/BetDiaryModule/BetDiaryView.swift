import SwiftUI

struct BetDiaryView: View {
    @StateObject var betDiaryModel =  BetDiaryViewModel()
    @State private var isDeleted = false
    var body: some View {
        ZStack {
            ZStack {
                Color(red: 28/255, green: 66/255, blue: 103/255)
                    .ignoresSafeArea()
                
                Image(.backDiary)
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                HStack {
                    Text("Results diary")
                        .ProBold(size: 32)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                Rectangle()
                    .fill(Color(red: 21/255, green: 52/255, blue: 83/255))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(red: 21/255, green: 147/255, blue: 232/255))
                            .overlay {
                                HStack(spacing: 20) {
                                    Text("Add schedule")
                                        .ProBold(size: 24)
                                    
                                    Image(systemName: "plus")
                                        .font(.system(size: 44, weight: .bold))
                                        .foregroundStyle(.white)
                                }
                            }
                    }
                    .frame(height: 200)
                    .cornerRadius(16)
                    .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(0..<4, id: \.self) { index in
                            SwipeToDeleteRow {
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 21/255, green: 147/255, blue: 232/255))
                                    .background(
                                        Color(red: 24/255, green: 58/255, blue: 93/255)
                                            .cornerRadius(16)
                                    )
                                    .overlay {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("At practice, finally practiced a lunge without losing my balance - feeling progress and in control! I feel like I can do more!")
                                                    .Pro(size: 18)
                                                
                                                Spacer()
                                            }
                                            
                                            Spacer()
                                            
                                            HStack {
                                                Text("30.06.2025")
                                                    .Pro(size: 14)
                                                
                                                Spacer()
                                            }
                                        }
                                        .padding()
                                    }
                            } onDelete: {
                                isDeleted = true
                                print("Delete item at index \(index)")
                            }
                        }
                        
                        Color.clear.frame(height: 80)
                    }
                }
                
                
            }
            .blur(radius: isDeleted ? 5 : 0)
            
            if isDeleted {
                Image(.modalNoteDelete)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 230)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)
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
                isDeleted = false
            }
        }
    }
}

#Preview {
    BetDiaryView()
}

struct SwipeToDeleteRow<Content: View>: View {
    let content: Content
    let onDelete: () -> Void
    
    @State private var offsetX: CGFloat = 0
    @GestureState private var isDragging = false
    
    init(@ViewBuilder content: () -> Content, onDelete: @escaping () -> Void) {
        self.content = content()
        self.onDelete = onDelete
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Button(action: {
                onDelete()
            }) {
                HStack {
                    Spacer()
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    Spacer()
                }
                .frame(width: 80, height: 130)
                .background(Color.red)
                .cornerRadius(16)
            }
            
            content
                .offset(x: offsetX)
                .gesture(
                    DragGesture()
                        .updating($isDragging) { value, state, _ in
                            state = true
                        }
                        .onChanged { value in
                            if value.translation.width < 0 {
                                offsetX = max(value.translation.width, -100)
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -50 {
                                offsetX = -100
                            } else {
                                offsetX = 0
                            }
                        }
                )
                .animation(.easeInOut, value: offsetX)
        }
        .frame(height: 130)
        .padding(.horizontal)
    }
}
