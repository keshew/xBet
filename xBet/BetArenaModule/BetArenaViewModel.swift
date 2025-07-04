import SwiftUI

class BetArenaViewModel: ObservableObject {
    let contact = BetArenaModel()
    @Published var isList = true
    @Published var isMap = false
}
