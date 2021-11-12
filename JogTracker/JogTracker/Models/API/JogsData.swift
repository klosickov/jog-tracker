import Foundation

// MARK: - JogsDataBody
struct JogsDataBody: Codable {
    let response: JogsData
}

// MARK: - Response
struct JogsData: Codable {
    let jogs: [JogExternal]
    let users: [User]
}

// MARK: - User
struct User: Codable {
    let id, email, phone, role: String
    let firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case id, email, phone, role
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
