import Foundation

struct User: Identifiable, Decodable, Sendable {
    let id: Int
    let userName: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "firstName"
        case email
    }
}
