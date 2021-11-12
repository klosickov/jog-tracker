import Foundation

struct JogExternal: Codable {
    let id: Int
    let userID: String
    let distance: Double
    let time: Int
    let date: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case distance, time, date
    }
}
