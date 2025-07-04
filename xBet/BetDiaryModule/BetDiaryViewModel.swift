import SwiftUI
import Combine

class BetDiaryViewModel: ObservableObject {
    let contact = BetDiaryModel()

    @Published var diaryEntries: [DiaryEntry] = []
    @Published var userId: String = "user_686835ca2f1095.82273141"
    
    func fetchDiary() {
        NetworkManager().getDiary(userId: userId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let diaryArray = json["diary"] as? [[String: Any]] {
                        self?.diaryEntries = diaryArray.compactMap { dict in
                            guard
                                let id = dict["id"] as? String,
                                let text = dict["text"] as? String,
                                let date = dict["date"] as? String
                            else {
                                return nil
                            }
                            return DiaryEntry(id: id, text: text, date: date)
                        }
                    }
                case .failure(let error):
                    print("Failed to load diary entries: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteEntry(id: String) {
        NetworkManager().deleteDiary(userId: userId, diaryId: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let json):
                    if let error = json["error"] as? String {
                        print("Delete error: \(error)")
                    } else {
                        self?.diaryEntries.removeAll { $0.id == id }
                    }
                case .failure(let error):
                    print("Delete failed: \(error.localizedDescription)")
                }
            }
        }
    }
}
