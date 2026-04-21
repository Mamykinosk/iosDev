import Foundation

struct UsersAPI {
    func fetchUser(id: Int) async throws -> User {
        try Task.checkCancellation()

        let url = URL(string: "https://dummyjson.com/users/\(id)")!
        print(url)
        let (data, response) = try await URLSession.shared.data(from: url)

        try Task.checkCancellation()

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.badStatusCode(httpResponse.statusCode)
        }

        return try JSONDecoder().decode(User.self, from: data)
    }
}
