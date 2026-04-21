import SwiftUI

struct ProfileControllerWrapper: UIViewControllerRepresentable {
    let user: User
    let isFollowing: Bool
    let onFollowTap: () -> Void

    func makeUIViewController(context: Context) -> ProfileViewController {
        ProfileViewController(
            user: user,
            isFollowing: isFollowing,
            onFollowTap: onFollowTap
        )
    }

    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        uiViewController.update(
            user: user,
            isFollowing: isFollowing,
            onFollowTap: onFollowTap
        )
    }
}
