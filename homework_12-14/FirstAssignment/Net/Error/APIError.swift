import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case badStatusCode(Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Некорректный ответ сервера"
        case .badStatusCode(let code):
            return "Ошибка сервера: \(code)"
        }
    }
}
