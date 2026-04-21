import Foundation
import Observation

@MainActor
@Observable
final class UsersViewModel {
    var users: [User] = []
    var isLoading = false
    var errorText: String?
    var statusText = "Нажми Load"
    var requestedID = "1"

    var followedUserIDs: Set<Int> = []

    private let repository = UsersRepository()
    private var loadTask: Task<Void, Never>?

    func loadAll() {
        loadTask?.cancel()

        loadTask = Task {
            isLoading = true
            errorText = nil
            statusText = "Загрузка..."

            defer { isLoading = false }

            do {
                let loaded = try await repository.users(ids: Array(1...10))
                try Task.checkCancellation()

                users = loaded
                statusText = "Загружено \(loaded.count) пользователей"
            } catch is CancellationError {
                statusText = "Загрузка отменена"
            } catch {
                errorText = error.localizedDescription
                statusText = "Ошибка загрузки"
            }
        }
    }

    func loadSingleFromTextField() {
        guard let id = Int(requestedID) else {
            errorText = "Введите корректный ID"
            return
        }

        loadTask?.cancel()

        loadTask = Task {
            isLoading = true
            errorText = nil

            defer { isLoading = false }

            do {
                let user = try await repository.user(id: id)
                try Task.checkCancellation()

                if !users.contains(where: { $0.id == user.id }) {
                    users.append(user)
                    users.sort { $0.id < $1.id }
                }

                statusText = "Пользователь \(user.userName) получен"
            } catch is CancellationError {
                statusText = "Запрос отменён"
            } catch {
                errorText = error.localizedDescription
                statusText = "Ошибка загрузки"
            }
        }
    }

    func cancelLoading() {
        loadTask?.cancel()
    }

    func isFollowing(_ user: User) -> Bool {
        followedUserIDs.contains(user.id)
    }

    func toggleFollow(for user: User) {
        if followedUserIDs.contains(user.id) {
            followedUserIDs.remove(user.id)
            statusText = "Ты больше не подписан на \(user.userName)"
        } else {
            followedUserIDs.insert(user.id)
            statusText = "Теперь ты подписан на \(user.userName)"
        }
    }
}
