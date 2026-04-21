import SwiftUI

struct ContentView: View {
    @State private var viewModel = UsersViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ControlsView(viewModel: viewModel)

                Text(viewModel.statusText)
                    .foregroundStyle(.secondary)

                if viewModel.isLoading {
                    ProgressView()
                }

                if let errorText = viewModel.errorText {
                    Text(errorText)
                        .foregroundStyle(.red)
                }

                List(viewModel.users) { user in
                    NavigationLink {
                        ProfileControllerWrapper(
                            user: user,
                            isFollowing: viewModel.isFollowing(user),
                            onFollowTap: {
                                viewModel.toggleFollow(for: user)
                            }
                        )
                        .navigationTitle("Profile")
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.userName)
                                    .font(.headline)

                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            if viewModel.isFollowing(user) {
                                Text("Following")
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(.blue.opacity(0.12))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .padding()
            .navigationTitle("Users")
        }
    }
}
