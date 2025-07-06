import SwiftUI

class NetworkManager {
    
    // MARK: - Registration
    func registration(name: String, city: String, weapon: String, level: String, email: String, password: String, picture: String?, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "registration",
            "name": name,
            "city": city,
            "weapon": weapon,
            "level": level,
            "email": email,
            "password": password,
            "picture": picture ?? ""
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "login",
            "email": email,
            "password": password
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Edit Profile
    func editProfile(userId: String, name: String?, city: String?, weapon: String?, level: String?, newEmail: String?, picture: String?, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        var params: [String: Any] = [
            "method": "edit_profile",
            "user_id": userId
        ]
        if let name = name { params["name"] = name }
        if let city = city { params["city"] = city }
        if let weapon = weapon { params["weapon"] = weapon }
        if let level = level { params["level"] = level }
        if let newEmail = newEmail { params["new_email"] = newEmail }
        if let picture = picture { params["picture"] = picture }
        
        request(params: params, completion: completion)
    }
    
    // MARK: - Add Training
    func addTraining(userId: String, arenaName: String, trainerName: String, address: String, arenaHours: String, recordTime: String, recordDate: String, trainingType: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "add_training",
            "user_id": userId,
            "arena_name": arenaName,
            "trainer_name": trainerName,
            "address": address,
            "arena_hours": arenaHours,
            "record_time": recordTime,
            "record_date": recordDate,
            "training_type": trainingType
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Trainings
    func getTrainings(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_trainings",
            "user_id": userId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Add Practice
    func addPractice(userId: String, practices: [[String: String]], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "add_practice",
            "user_id": userId,
            "practices": practices
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Practices
    func getPractices(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_practices",
            "user_id": userId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Add Diary
    func addDiary(userId: String, date: String, text: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "add_diary",
            "user_id": userId,
            "date": date,
            "text": text
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Diary
    func getDiary(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_diary",
            "user_id": userId
        ]
        request(params: params, completion: completion)
    }
    
    func changeAvatar(userId: String, picture: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
         let params: [String: Any] = [
             "method": "change_avatar",
             "user_id": userId,
             "picture": picture
         ]
         request(params: params, completion: completion)
     }
    
    // MARK: - Delete Diary
    func deleteDiary(userId: String, diaryId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "delete_diary",
            "user_id": userId,
            "id": diaryId
        ]
        request(params: params, completion: completion)
    }
    
    func deleteAccount(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "delete_account",
            "user_id": userId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Add Sparring
    func addSparring(userId: String, dayOfWeek: String, time: String, place: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "add_sparring",
            "user_id": userId,
            "day_of_week": dayOfWeek,
            "time": time,
            "place": place
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Sparrings
    func getSparrings(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_sparrings",
            "user_id": userId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Add Discussion
    func addDiscussion(userId: String, title: String, text: String, dateAdded: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "add_discussion",
            "user_id": userId,
            "title": title,
            "text": text,
            "date_added": dateAdded
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Discussions
    func getDiscussions(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_discussions"
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Add Comment
    func addComment(discussionId: String, name: String, text: String, dateSent: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "add_comment",
            "discussion_id": discussionId,
            "name": name,
            "text": text,
            "date_sent": dateSent
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Comments
    func getComments(discussionId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_comments",
            "discussion_id": discussionId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Send Message
    func sendMessage(fromUserId: String, toUserId: String, text: String, dateSent: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "send_message",
            "from_user_id": fromUserId,
            "to_user_id": toUserId,
            "text": text,
            "date_sent": dateSent
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Messages
    func getMessages(userId: String, withUserId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_messages",
            "user_id": userId,
            "with_user_id": withUserId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Invite Sparring
    func inviteSparring(fromUserId: String, toUserId: String, dayOfWeek: String, date: String, place: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "invite_sparring",
            "from_user_id": fromUserId,
            "to_user_id": toUserId,
            "day_of_week": dayOfWeek,
            "date": date,
            "place": place
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Respond Invite
    func respondInvite(inviteId: String, accepted: Bool, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "respond_invite",
            "invite_id": inviteId,
            "accepted": accepted
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Unread Count
    func getUnreadCount(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_unread_count",
            "user_id": userId
        ]
        request(params: params, completion: completion)
    }
    
    func getUsers(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_users"
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Mark Messages Read
    func markMessagesRead(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "mark_messages_read",
            "user_id": userId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Sparring Invites
    /// Получить все приглашения на спарринг, адресованные конкретному пользователю
    func getSparringInvites(userId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_sparring_invites",
            "user_id": userId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Get Rejected Sparring Invites
    /// Получить все отклонённые приглашения, отправленные конкретным пользователем
    func getRejectedSparringInvites(fromUserId: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let params: [String: Any] = [
            "method": "get_rejected_sparring_invites",
            "from_user_id": fromUserId
        ]
        request(params: params, completion: completion)
    }
    
    // MARK: - Private Request Helper
    private func request(params: [String: Any], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let url = URL(string: "https://sparringteams.cyou/app.php") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(json))
                } else {
                    completion(.failure(NSError(domain: "Invalid JSON", code: 0)))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
