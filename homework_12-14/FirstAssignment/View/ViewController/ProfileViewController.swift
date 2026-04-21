import UIKit

final class ProfileViewController: UIViewController {

    private let cardView = UIView()
    private let avatarContainerView = UIView()
    private let avatarImageView = UIImageView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let followButton = UIButton(type: .system)

    private var user: User
    private var isFollowing: Bool
    var onFollowTap: (() -> Void)?

    init(
        user: User,
        isFollowing: Bool = false,
        onFollowTap: (() -> Void)? = nil
    ) {
        self.user = user
        self.isFollowing = isFollowing
        self.onFollowTap = onFollowTap
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        applyData()
    }

    func update(
        user: User,
        isFollowing: Bool,
        onFollowTap: (() -> Void)? = nil
    ) {
        self.user = user
        self.isFollowing = isFollowing

        if let onFollowTap {
            self.onFollowTap = onFollowTap
        }

        if isViewLoaded {
            applyData()
        }
    }

    private func configureUI() {
        title = "Profile"
        view.backgroundColor = .systemBackground

        cardView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainerView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        followButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(cardView)
        cardView.addSubview(avatarContainerView)
        avatarContainerView.addSubview(avatarImageView)
        cardView.addSubview(nameLabel)
        cardView.addSubview(emailLabel)
        cardView.addSubview(followButton)

        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 24
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.12).cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowRadius = 18
        cardView.layer.shadowOffset = CGSize(width: 0, height: 8)

        avatarContainerView.backgroundColor = .tertiarySystemFill
        avatarContainerView.layer.cornerRadius = 50

        avatarImageView.image = UIImage(systemName: "person.crop.circle.fill")
        avatarImageView.tintColor = .systemGray2
        avatarImageView.contentMode = .scaleAspectFit

        nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0

        emailLabel.font = .systemFont(ofSize: 17, weight: .regular)
        emailLabel.textColor = .secondaryLabel
        emailLabel.textAlignment = .center
        emailLabel.numberOfLines = 0

        var config = UIButton.Configuration.filled()
        config.cornerStyle = .large
        config.title = "Follow"
        followButton.configuration = config

        followButton.addTarget(self, action: #selector(didTapFollow), for: .touchUpInside)

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            avatarContainerView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 32),
            avatarContainerView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            avatarContainerView.widthAnchor.constraint(equalToConstant: 100),
            avatarContainerView.heightAnchor.constraint(equalToConstant: 100),

            avatarImageView.centerXAnchor.constraint(equalTo: avatarContainerView.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: avatarContainerView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 72),
            avatarImageView.heightAnchor.constraint(equalToConstant: 72),

            nameLabel.topAnchor.constraint(equalTo: avatarContainerView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),

            followButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 28),
            followButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            followButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            followButton.heightAnchor.constraint(equalToConstant: 50),
            followButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -24)
        ])
    }

    private func applyData() {
        nameLabel.text = user.userName
        emailLabel.text = user.email
        updateFollowButton()
    }

    private func updateFollowButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .large
        config.title = isFollowing ? "Following" : "Follow"
        followButton.configuration = config
    }

    @objc
    private func didTapFollow() {
        isFollowing.toggle()
        updateFollowButton()
        onFollowTap?()
    }
}
