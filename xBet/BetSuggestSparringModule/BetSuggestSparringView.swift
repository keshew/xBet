import SwiftUI

struct BetSuggestSparringView: View {
    @StateObject var betSuggestSparringModel = BetSuggestSparringViewModel()
    
    @Binding var isFinish: Bool
    @Binding var showAddScheduleView: Bool
    
    @State private var selectedRecordingTime: Int? = nil
    @State private var showingPicker = false
    @State private var selectedTime: Date? = nil
    @State private var text = ""
    
    // Добавляем ID пользователя, которому отправляем приглашение
    let fromUserId: String
    let toUserId: String
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
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
                                
                                Button(action: sendInvitation) // вызываем функцию отправки
                                {
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
    
    func sendInvitation() {
        guard let dayIndex = selectedRecordingTime,
              let time = selectedTime else {
            return
        }
        
        let day = days[dayIndex]
        
        // Форматируем дату + время в строку, например "2025-07-06 16:30"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: time)
        
        // Можно отдельно время, если нужно
        formatter.dateFormat = "HH:mm"
        
        // Собираем дату в формате, который ожидает сервер (например, "2025-07-06")
        // Для вашего API дата отдельно, время отдельно, но в запросе есть только date, day_of_week и place
        // В PHP-коде invite_sparring принимает day_of_week, date и place
        
        NetworkManager().inviteSparring(
            fromUserId: fromUserId,
            toUserId: toUserId,
            dayOfWeek: day,
            date: dateString,
            place: text.trimmingCharacters(in: .whitespacesAndNewlines)
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let success = json["success"] as? String {
                        print("Invitation sent: \(success)")
                        withAnimation {
                            isFinish = true
                            showAddScheduleView = false
                        }
                    } else if let error = json["error"] as? String {
                        print("Error sending invitation: \(error)")
                    }
                case .failure(let error):
                    print("Failed to send invitation: \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    BetSuggestSparringView(
        isFinish: .constant(false),
        showAddScheduleView: .constant(false),
        fromUserId: "user_12345",
        toUserId: "user_67890"
    )
}
