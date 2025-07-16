import SwiftUI

struct User: Identifiable {
    var id: UUID = UUID()
    
    // Поля для входа
    var name: String
    var password: String
    
    var fullName: String
    var age: Int
    var biography: String
    var avatarImageName: String
}

class MyViewModel: ObservableObject {
    var users: [User] = [
        User(name: "user1",
             password: "password1",
             fullName: "Иван Иванов",
             age: 34,
             biography: "Разработчик с 10-летним стажем.",
             avatarImageName: "avatar_ivan"),
        User(name: "user2",
             password: "password2",
             fullName: "Мария Сидорова",
             age: 28,
             biography: "Увлекается йогой.",
             avatarImageName: "avatar_maria")
    ]


    func authorize(name: String, password: String) -> User? {
        for user in users {
            if user.name == name && user.password == password {
                return user
            }
        }
        return nil
    }
}


