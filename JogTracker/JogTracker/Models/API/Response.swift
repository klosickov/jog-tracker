import Foundation

// MARK: - ResponseBody
struct ResponseBody: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let scope: String
    let createdAt: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case createdAt = "created_at"
    }
}
