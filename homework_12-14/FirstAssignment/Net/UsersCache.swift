import Foundation

actor UsersCache {
    private var storage: [Int: User] = [:]
    private var inFlight: [Int: Task<User, Error>] = [:]

    func user(for id: Int) -> User? {
        storage[id]
    }

    func save(_ user: User) {
        storage[user.id] = user
        print("Cache SAVE:", user.id)
    }

    func loadUser(
        id: Int,
        loader: @Sendable @escaping () async throws -> User
    ) async throws -> User {
        if let cached = storage[id] {
            print("Cache HIT:", id)
            return cached
        }

        if let runningTask = inFlight[id] {
            print("Cache JOIN inFlight:", id)
            return try await runningTask.value
        }

        print("Cache MISS:", id)

        let task = Task<User, Error> {
            try await loader()
        }

        inFlight[id] = task

        do {
            let user = try await task.value
            storage[id] = user
            inFlight[id] = nil
            return user
        } catch {
            inFlight[id] = nil
            throw error
        }
    }
}
