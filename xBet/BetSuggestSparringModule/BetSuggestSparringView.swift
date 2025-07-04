import SwiftUI

struct BetSuggestSparringView: View {
    @StateObject var betSuggestSparringModel = BetSuggestSparringViewModel()
    
    @Binding var isFinish: Bool
    @Binding var showAddScheduleView: Bool
    
    // Выбираем только один день (опциональный индекс)
    @State private var selectedRecordingTime: Int? = nil
    @State private var showingPicker = false
    @State private var selectedTime: Date? = nil
    @State private var text = ""
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    // Кнопка активна, если выбран день, время и место не пустое
    var isButtonEnabled: Bool {
        selectedRecordingTime != nil && selectedTime != nil && !text.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
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
                                
                                Text("Suggest Sparring")
                                    .ProBold(size: 24)
                                    .padding(.top)
                                
                                VStack {
                                    HStack {
                                        Text("When?")
                                            .Pro(size: 20)
                                        Spacer()
                                    }
                                    
                                    VStack(spacing: 10) {
                                        HStack {
                                            let times = ["Monday", "Tuesday", "Wednesday"]
                                            ForEach(0..<times.count, id: \.self) { index in
                                                Rectangle()
                                                    .fill(selectedRecordingTime == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                    .overlay {
                                                        Text(times[index])
                                                            .Pro(size: 16)
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(height: 54)
                                                    .cornerRadius(12)
                                                    .onTapGesture {
                                                        selectedRecordingTime = index
                                                    }
                                            }
                                        }
                                        
                                        HStack {
                                            let times = ["Thursday", "Friday", "Saturday"]
                                            ForEach(3..<(3 + times.count), id: \.self) { index in
                                                Rectangle()
                                                    .fill(selectedRecordingTime == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                    .overlay {
                                                        Text(times[index - 3])
                                                            .Pro(size: 16)
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(height: 54)
                                                    .cornerRadius(12)
                                                    .onTapGesture {
                                                        selectedRecordingTime = index
                                                    }
                                            }
                                        }
                                        
                                        HStack {
                                            let times = ["Sunday"]
                                            ForEach(6..<7, id: \.self) { index in
                                                Rectangle()
                                                    .fill(selectedRecordingTime == index ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                    .overlay {
                                                        Text(times[index - 6])
                                                            .Pro(size: 16)
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(height: 54)
                                                    .cornerRadius(12)
                                                    .onTapGesture {
                                                        selectedRecordingTime = index
                                                    }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                
                                Rectangle()
                                    .fill(Color(red: 57/255, green: 91/255, blue: 123/255))
                                    .frame(height: 1)
                                    .padding(.horizontal)
                                    .padding(.top)
                                
                                HStack {
                                    Text("What time?")
                                        .Pro(size: 16)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation {
                                            showingPicker = true
                                        }
                                    }) {
                                        Rectangle()
                                            .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                                            .overlay {
                                                if let time = selectedTime {
                                                    Text(time, style: .time)
                                                        .Pro(size: 18)
                                                        .foregroundColor(.white)
                                                } else {
                                                    Text("Choose")
                                                        .Pro(size: 18)
                                                        .foregroundColor(.white)
                                                }
                                            }
                                            .frame(width: 250, height: 50)
                                            .cornerRadius(12)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                
                                Rectangle()
                                    .fill(Color(red: 57/255, green: 91/255, blue: 123/255))
                                    .frame(height: 1)
                                    .padding(.horizontal)
                                    .padding(.top)
                                
                                HStack {
                                    Text("Where?")
                                        .Pro(size: 16)
                                        .padding(.leading)
                                    Spacer()
                                    
                                    CustomTextFiled(text: $text, placeholder: "Write here place of sparring")
                                        .padding(.leading, 80)
                                }
                                .padding(.top)
                                
                                Button(action: {
                                    withAnimation {
                                        isFinish = true
                                        showAddScheduleView = false
                                    }
                                }) {
                                    Rectangle()
                                        .fill(Color(red: 126/255, green: 172/255, blue: 47/255))
                                        .overlay {
                                            Text("Send an invation")
                                                .Pro(size: 21)
                                                .foregroundColor(.white)
                                        }
                                        .frame(height: 54)
                                        .cornerRadius(16)
                                        .padding(.horizontal)
                                }
                                .padding(.top, 10)
                                .opacity(isButtonEnabled ? 1 : 0.5)
                                .disabled(!isButtonEnabled)
                                
                                Spacer()
                            }
                        }
                }
                .blur(radius: showingPicker ? 5 : 0)
            
            if showingPicker {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showingPicker = false
                        }
                    }
                    .zIndex(1)
                
                VStack {
                    DatePicker(
                        "Select time",
                        selection: Binding(
                            get: { selectedTime ?? Date() },
                            set: { newValue in selectedTime = newValue }
                        ),
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()
                }
                .background(Color.white)
                .cornerRadius(16)
                .padding()
                .frame(maxWidth: 400)
                .shadow(radius: 20)
                .zIndex(2)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .cornerRadius(16)
    }
}

#Preview {
    BetSuggestSparringView(isFinish: .constant(false), showAddScheduleView: .constant(false))
}
