import SwiftUI

struct BetTrainModel {
 
}

struct Practice: Identifiable {
    let id: String
    let dayOfWeek: String
    let time: String?
    let place: String?
    let isSparring: Bool
    let opponentName: String?
    
    init(id: String, dayOfWeek: String, time: String?, place: String? = nil, isSparring: Bool = false, opponentName: String? = nil) {
        self.id = id
        self.dayOfWeek = dayOfWeek
        self.time = time
        self.place = place
        self.isSparring = isSparring
        self.opponentName = opponentName
    }
    
    init?(json: [String: Any], index: Int) {
        guard let dayOfWeek = json["day_of_week"] as? String,
              let time = json["time"] as? String else {
            return nil
        }
        self.id = json["id"] as? String ?? "practice_\(index)"
        self.dayOfWeek = dayOfWeek
        self.time = time
        self.place = nil
        self.isSparring = false
        self.opponentName = nil
    }
    
    init?(sparringJson json: [String: Any], index: Int) {
        guard let dayOfWeek = json["day_of_week"] as? String else {
            return nil
        }
        self.id = json["id"] as? String ?? "sparring_\(index)"
        self.dayOfWeek = dayOfWeek
        self.time = json["time"] as? String
        self.place = json["place"] as? String
        self.isSparring = true
        self.opponentName = json["opponent_name"] as? String  
    }
}


struct User: Identifiable {
    let id: String
    let name: String
    let city: String
    let weapon: String
    let level: String
    let email: String
    let picture: String?

    init?(json: [String: Any]) {
        guard let id = json["user_id"] as? String,
              let name = json["name"] as? String,
              let city = json["city"] as? String,
              let weapon = json["weapon"] as? String,
              let level = json["level"] as? String,
              let email = json["email"] as? String else {
            return nil
        }
        self.id = id
        self.name = name
        self.city = city
        self.weapon = weapon
        self.level = level
        self.email = email
        self.picture = json["picture"] as? String
    }

    init(id: String, name: String, city: String, weapon: String, level: String, email: String, picture: String?) {
        self.id = id
        self.name = name
        self.city = city
        self.weapon = weapon
        self.level = level
        self.email = email
        self.picture = picture
    }
}

