import Foundation

actor UsersRepository {
    private let api = UsersAPI()
    private let cache = UsersCache()

    func user(id: Int) async throws -> User {
        try await cache.loadUser(id: id) { [api] in
            try await api.fetchUser(id: id)
        }
    }

    func users(ids: [Int]) async throws -> [User] {
        try await withThrowingTaskGroup(of: User.self) { group in
            for id in ids {
                group.addTask { [self] in
                    try await self.user(id: id)
                }
            }

            var result: [User] = []

            for try await user in group {
                result.append(user)
            }

            return result.sorted { $0.id < $1.id }
        }
    }
}
