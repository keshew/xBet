import SwiftUI

struct BetTrainingView: View {
    @StateObject var betTrainingModel =  BetTrainingViewModel()
    @Binding var isTapped: Bool
    @Binding var isFinish: Bool
    @Binding var showBetTraining: Bool
    
    @State private var selectedRecordDate: Int? = nil
    @State private var selectedRecordingTime: Int? = nil
    @State private var selectedTrainingType: Int? = nil
    
    var isButtonEnabled: Bool {
        selectedRecordDate != nil && selectedRecordingTime != nil && selectedTrainingType != nil
    }
    
    var body: some View {
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
                            
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Arena name")
                                            .ProBold(size: 24)
                                        
                                        Text("There's a coach to choose from")
                                            .Pro(size: 16, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                    }
                                    
                                    Rectangle()
                                        .fill(Color(red: 58/255, green: 84/255, blue: 110/255))
                                        .frame(height: 1)
                                        .padding(.trailing, 10)
                                        .padding(.top, 5)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Training price:")
                                            .Pro(size: 14, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                        
                                        Text("15$ (regular)")
                                            .Pro(size: 14, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                        
                                        Text("20$ (advanced)")
                                            .Pro(size: 14, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                        
                                        Text("10$ (just sparring)")
                                            .Pro(size: 14, color: Color(red: 196/255, green: 204/255, blue: 213/255))
                                    }
                                    .padding(.top, 5)
                                }
                                
                                
                                Image(.arenaImg)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 120, height: 170)
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Text("Burga Street 21")
                                    .Pro(size: 14, color: Color(red: 139/255, green: 153/255, blue: 170/255))
                                
                                Spacer()
                                
                                Text("9:00 - 21:00")
                                    .Pro(size: 14, color: Color(red: 139/255, green: 153/255, blue: 170/255))
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 5)
                            
                            if isTapped {
                                VStack {
                                    HStack {
                                        Text("Record date:")
                                            .Pro(size: 20)
                                        Spacer()
                                    }
                                    
                                    let firstTwoTitles = ["Monday (07.07)", "Wednesday (09.07)"]
                                    HStack {
                                        ForEach(0..<firstTwoTitles.count, id: \.self) { index in
                                            Rectangle()
                                                .fill(selectedRecordDate == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                .overlay {
                                                    Text(firstTwoTitles[index])
                                                        .Pro(size: 16)
                                                        .foregroundColor(.white)
                                                }
                                                .frame(height: 44)
                                                .cornerRadius(12)
                                                .onTapGesture {
                                                    selectedRecordDate = index
                                                }
                                        }
                                    }
                                    
                                    HStack {
                                        Rectangle()
                                            .fill(selectedRecordDate == 2 ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                            .overlay {
                                                Text("Friday (11.07)")
                                                    .Pro(size: 16)
                                                    .foregroundColor(.white)
                                            }
                                            .frame(height: 44)
                                            .cornerRadius(12)
                                            .onTapGesture {
                                                selectedRecordDate = 2
                                            }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                                
                                VStack {
                                    HStack {
                                        Text("Available recording time:")
                                            .Pro(size: 20)
                                        Spacer()
                                    }
                                    
                                    VStack(spacing: 10) {
                                        HStack {
                                            ForEach(0..<3) { index in
                                                let times = ["17:00 - 18:00", "18:00 - 19:00", "19:00 - 20:00"]
                                                Rectangle()
                                                    .fill(selectedRecordingTime == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                    .overlay {
                                                        Text(times[index])
                                                            .Pro(size: 16)
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(height: 44)
                                                    .cornerRadius(12)
                                                    .onTapGesture {
                                                        selectedRecordingTime = index
                                                    }
                                            }
                                        }
                                        
                                        HStack {
                                            ForEach(3..<5) { index in
                                                let times = ["20:00 - 21:00", "21:00 - 21:40"]
                                                Rectangle()
                                                    .fill(selectedRecordingTime == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                    .overlay {
                                                        Text(times[index - 3])
                                                            .Pro(size: 16)
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(height: 44)
                                                    .cornerRadius(12)
                                                    .onTapGesture {
                                                        selectedRecordingTime = index
                                                    }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                                
                                VStack {
                                    HStack {
                                        Text("Training Type:")
                                            .Pro(size: 20)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        ForEach(0..<3) { index in
                                            let types = ["Regular", "Advanced", "Just sparring"]
                                            Rectangle()
                                                .fill(selectedTrainingType == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                .overlay {
                                                    Text(types[index])
                                                        .Pro(size: 16)
                                                        .foregroundColor(.white)
                                                }
                                                .frame(height: 44)
                                                .cornerRadius(12)
                                                .onTapGesture {
                                                    selectedTrainingType = index
                                                }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 5)
                            }
                            
                            Button(action: {
                                if isTapped {
                                    withAnimation {
                                        isFinish = true
                                        isTapped = false
                                        showBetTraining = false
                                    }
                                } else {
                                    withAnimation {
                                        isTapped = true
                                    }
                                }
                            }) {
                                Rectangle()
                                    .fill(Color(red: 126/255, green: 172/255, blue: 47/255))
                                    .overlay {
                                        Text("Sign up for training")
                                            .Pro(size: 21)
                                            .foregroundColor(.white)
                                    }
                                    .frame(height: 44)
                                    .cornerRadius(16)
                                    .padding(.horizontal)
                            }
                            .padding(.top, 10)
                            .opacity(isTapped ? isButtonEnabled ? 1 : 0.5 : 1)
                            .disabled(isTapped ? !isButtonEnabled : false)
                            
                            Spacer()
                        }
                    }
            }
            .cornerRadius(16)
    }
}

#Preview {
    BetTrainingView(isTapped: .constant(false), isFinish: .constant(false), showBetTraining: .constant(false))
}
