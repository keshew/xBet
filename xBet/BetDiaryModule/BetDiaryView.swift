import SwiftUI

struct BetDiaryView: View {
    @StateObject var betDiaryModel = BetDiaryViewModel()
    @State private var isDeleted = false
    @State private var showAddTraining = false
    @State private var isFinish = false

    var body: some View {
        ZStack(alignment: .bottom) {
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
                                    Text("Add new note")
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
                    .onTapGesture {
                        withAnimation {
                            showAddTraining = true
                        }
                    }
                
                ScrollView {
                    VStack(spacing: 15) {
                        if betDiaryModel.diaryEntries.isEmpty {
                            Text("No diary entries yet")
                                .Pro(size: 18, color: .white.opacity(0.7))
                                .padding()
                        } else {
                            ForEach(betDiaryModel.diaryEntries) { entry in
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
                                                    Text(entry.text)
                                                        .Pro(size: 18)
                                                    Spacer()
                                                }
                                                
                                                Spacer()
                                                
                                                HStack {
                                                    Text(formatDate(entry.date))
                                                        .Pro(size: 14)
                                                    Spacer()
                                                }
                                            }
                                            .padding()
                                        }
                                } onDelete: {
                                    betDiaryModel.deleteEntry(id: entry.id)
                                    isDeleted = true
                                }
                            }
                        }
                        
                        Color.clear.frame(height: 80)
                    }
                }
            }
            .blur(radius: isDeleted ? 5 : showAddTraining ? 5 : isFinish ? 5 : 0)
            .onTapGesture {
                showAddTraining = false
            }
            
            if showAddTraining {
                BetAddNoteView(showAddTraining: $showAddTraining, isFinish: $isFinish)
                    .frame(height: 570)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .offset(y: 20)
            }
            
            if isFinish {
                Image(.customModal)
                    .resizable()
                    .overlay {
                        Text("Note successfully\nadded!")
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
            
            if isDeleted {
                Image(.modalNoteDelete)
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
        .onAppear {
            betDiaryModel.fetchDiary()
        }
    }
    
    func hideModalAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                isDeleted = false
                isFinish = false
            }
        }
    }
    
    func formatDate(_ isoDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: isoDate) else { return isoDate }
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}


#Preview {
    BetDiaryView()
}
