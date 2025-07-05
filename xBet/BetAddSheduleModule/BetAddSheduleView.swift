import SwiftUI

struct BetAddSheduleView: View {
    @StateObject var betAddSheduleModel = BetAddSheduleViewModel()
    @Binding var isTapped: Bool
    @Binding var isFinish: Bool
    @Binding var showAddScheduleView: Bool
    @State private var selectedRecordingTimes: Set<Int> = []
    @State private var isDateSelected = false
    @State private var selectedTimes: [Int: Date] = [:]
    @State private var showingPicker = false
    @State private var pickerIndex: Int? = nil
    
    let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var isButtonEnabled: Bool { !selectedRecordingTimes.isEmpty }
    
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
                                
                                Text("Add Schedule")
                                    .ProBold(size: 24)
                                    .padding(.top)
                                
                                VStack {
                                    HStack {
                                        Text("When will you be practicing?")
                                            .Pro(size: 20)
                                        Spacer()
                                    }
                                    
                                    VStack(spacing: 10) {
                                        HStack {
                                            let times = ["Monday", "Tuesday", "Wednesday"]
                                            ForEach(0..<times.count, id: \.self) { index in
                                                Rectangle()
                                                    .fill(selectedRecordingTimes.contains(index) ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                    .overlay {
                                                        Text(times[index])
                                                            .Pro(size: 16)
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(height: 54)
                                                    .cornerRadius(12)
                                                    .onTapGesture {
                                                        if selectedRecordingTimes.contains(index) {
                                                            selectedRecordingTimes.remove(index)
                                                            selectedTimes[index] = nil
                                                        } else {
                                                            selectedRecordingTimes.insert(index)
                                                        }
                                                    }
                                            }
                                        }
                                        
                                        HStack {
                                            let times = ["Thursday", "Friday", "Saturday"]
                                            ForEach(3..<(3 + times.count), id: \.self) { index in
                                                Rectangle()
                                                    .fill(selectedRecordingTimes.contains(index) ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                    .overlay {
                                                        Text(times[index - 3])
                                                            .Pro(size: 16)
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(height: 54)
                                                    .cornerRadius(12)
                                                    .onTapGesture {
                                                        if selectedRecordingTimes.contains(index) {
                                                            selectedRecordingTimes.remove(index)
                                                            selectedTimes[index] = nil
                                                        } else {
                                                            selectedRecordingTimes.insert(index)
                                                        }
                                                    }
                                            }
                                        }
                                        
                                        HStack {
                                            let times = ["Sunday"]
                                            ForEach(6..<7, id: \.self) { index in
                                                Rectangle()
                                                    .fill(selectedRecordingTimes.contains(index) ? Color(red: 20/255, green: 160/255, blue: 255/255) : Color(red: 24/255, green: 58/255, blue: 93/255))
                                                    .overlay {
                                                        Text(times[index - 6])
                                                            .Pro(size: 16)
                                                            .foregroundColor(.white)
                                                    }
                                                    .frame(height: 54)
                                                    .cornerRadius(12)
                                                    .onTapGesture {
                                                        if selectedRecordingTimes.contains(index) {
                                                            selectedRecordingTimes.remove(index)
                                                            selectedTimes[index] = nil
                                                        } else {
                                                            selectedRecordingTimes.insert(index)
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                
                                if isDateSelected {
                                    Rectangle()
                                        .fill(Color(red: 57/255, green: 91/255, blue: 123/255))
                                        .frame(height: 1)
                                        .padding(.horizontal)
                                        .padding(.top)
                                    
                                    ScrollView {
                                        VStack(spacing: 10) {
                                            ForEach(Array(selectedRecordingTimes).sorted(), id: \.self) { index in
                                                HStack {
                                                    Text("What time will practice be on \(days[index])?")
                                                        .Pro(size: 16)
                                                    
                                                    Spacer()
                                                    
                                                    if let selectedTime = selectedTimes[index] {
                                                        Text(selectedTime, style: .time)
                                                            .Pro(size: 18)
                                                            .foregroundColor(.white)
                                                            .padding(.horizontal, 16)
                                                            .padding(.vertical, 10)
                                                            .background(Color(red: 24/255, green: 58/255, blue: 93/255))
                                                            .cornerRadius(12)
                                                            .onTapGesture {
                                                                withAnimation {
                                                                    pickerIndex = index
                                                                    showingPicker = true
                                                                }
                                                            }
                                                    } else {
                                                        Button(action: {
                                                            withAnimation {
                                                                pickerIndex = index
                                                                showingPicker = true
                                                            }
                                                        }) {
                                                            Rectangle()
                                                                .fill(Color(red: 24/255, green: 58/255, blue: 93/255))
                                                                .overlay {
                                                                    Text("Choose")
                                                                        .Pro(size: 18)
                                                                }
                                                                .frame(height: 50)
                                                                .cornerRadius(12)
                                                                .padding(.leading, 100)
                                                        }
                                                    }
                                                }
                                                .padding(.horizontal)
                                                .padding(.top)
                                            }
                                        }
                                    }
                                    .frame(maxHeight: 230)
                                }
                                
                                Button(action: {
                                    if isTapped {
                                        savePractice()
                                    } else {
                                        withAnimation {
                                            isTapped = true
                                            isDateSelected = true
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
            
            if showingPicker, let pickerIndex = pickerIndex {
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
                            get: { selectedTimes[pickerIndex] ?? Date() },
                            set: { newValue in selectedTimes[pickerIndex] = newValue }
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
    
    private func savePractice() {
        guard !selectedRecordingTimes.isEmpty else { return }
        
        let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        
        let practices = selectedRecordingTimes.compactMap { index -> [String: String]? in
            guard let time = selectedTimes[index] else { return nil }
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            let timeString = formatter.string(from: time)
            return [
                "day_of_week": daysOfWeek[index],
                "time": timeString
            ]
        }
        
        let userId = UserDefaultsManager().getID() ?? ""
        
        NetworkManager().addPractice(userId: userId, practices: practices) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let error = json["error"] as? String {
                        print("Error adding practice: \(error)")
                    } else {
                        withAnimation {
                            isFinish = true
                            isTapped = false
                            showAddScheduleView = false
                        }
                    }
                case .failure(let error):
                    print("Failed to add practice: \(error.localizedDescription)")
                }
            }
        }
    }
}


#Preview {
    BetAddSheduleView(isTapped: .constant(false), isFinish: .constant(false), showAddScheduleView: .constant(false))
}
