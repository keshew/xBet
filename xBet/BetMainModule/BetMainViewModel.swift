import SwiftUI
import Combine

class BetMainViewModel: ObservableObject {
    let contact = BetMainModel()
    @Published var isDiscussion = false
    @Published var isSettings = false
    @Published var trainings: [Training] = []
       
       private var cancellables = Set<AnyCancellable>()
       
       let userId: String = "user_686835ca2f1095.82273141"
       
       init() {
           fetchTrainings()
       }
       
       func fetchTrainings() {
           NetworkManager().getTrainings(userId: userId) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let json):
                       if let trainingsArray = json["trainings"] as? [[String: Any]] {
                           self?.trainings = trainingsArray.compactMap { dict in
                               guard
                                   let id = dict["id"] as? String,
                                   let arenaName = dict["arena_name"] as? String,
                                   let recordDate = dict["record_date"] as? String,
                                   let recordTime = dict["record_time"] as? String,
                                   let address = dict["address"] as? String
                               else {
                                   return nil
                               }
                               return Training(id: id, arenaName: arenaName, recordDate: recordDate, recordTime: recordTime, address: address)
                           }
                       }
                   case .failure(let error):
                       print("Failed to fetch trainings:", error.localizedDescription)
                   }
               }
           }
       }
   }
