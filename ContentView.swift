import SwiftUI


struct ContentView: View {
    @State var userName: String = ""
    @State var userPassword: String = ""
    @State var userForNextScreen: User?
    @State var authErrorText: String?

    @StateObject var myViewModel: MyViewModel = MyViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .imageScale(.large)
                .font(.system(size: 60))
                .foregroundStyle(.tint)
                .padding(.bottom, 20)

            Text("Вход")
                .font(.largeTitle)

            TextField("Логин", text: $userName)
                .padding()
                .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                .autocapitalization(.none)

            SecureField("Пароль", text: $userPassword)
                .padding()
                .overlay(Rectangle().frame(height: 1).padding(.top, 30))
                
            if let errorText = authErrorText {
                Text(errorText)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }

            Button {
                let foundUser = myViewModel.authorize(name: userName, password: userPassword)
                
                if let user = foundUser {
                    self.userForNextScreen = user
                    self.authErrorText = nil
                } else {
                    self.authErrorText = "Неверный логин или пароль"
                }
                
            } label: {
                Text("Войти")
                    .foregroundStyle(Color.black)
                    .font(.title)
                    .padding(16)
                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.black.opacity(0.2)))
            }
            .padding(.top, 40)
            
            Spacer()
        }
        .padding()
        .fullScreenCover(item: $userForNextScreen) { user in
            MyNewView(user: user)
        }
    }
}


struct MyNewView: View {
    @Environment(\.dismiss) var dismiss
    
    var user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Аватарка
                Image(user.avatarImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding(.top, 40)
                
                // ФИО
                Text(user.fullName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Возраст
                Text("Возраст: \(user.age) лет")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                // Биография
                VStack(alignment: .leading, spacing: 10) {
                    Text("О себе:")
                        .font(.headline)
                    Text(user.biography)
                        .font(.body)
                }
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)

                Spacer()

                Button {
                    dismiss()
                } label: {
                    Text("Выйти")
                        .foregroundStyle(Color.red)
                        .font(.title2)
                        .padding(12)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 2))
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

