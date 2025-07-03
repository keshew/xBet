import SwiftUI

class BetArenaViewModel: ObservableObject {
    let contact = BetArenaModel()
    @Published var isList = false
    @Published var isMap = true
}
