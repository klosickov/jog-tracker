import UIKit

class EmptyJogsViewController: UIViewController {
    // MARK: - UI lets/vars
    // MARK: navigationView
    private let navigationView = NavigationView.instanceFromNib()
    private let navigationViewHeight: CGFloat = 77
    // MARK: centralLogo
    private let centralLogoImageView = UIImageView()
    private let centralLogoImageViewHeight: CGFloat = 86
    private let centralLogoImageViewWidth: CGFloat = 85
    private let centralLogoImageViewCenterYSpacing: CGFloat = -74
    // MARK: centralLabel
    private let centralLabel = UILabel()
    private let centralLabelFontSize: CGFloat = 24
    private let centralLabelTopSpacing: CGFloat = 30
    // MARK: actionButton
    private let actionButton = UIButton()
    private let actionButtonFontSize: CGFloat = 18
    private let actionButtonWidth: CGFloat = 251
    private let actionButtonHeight: CGFloat = 60
    private let actionButtonTopSpacing: CGFloat = 145
    // MARK: - lets/vars
    private let image = Constants.Images.EmptyJogsScreen.self
    private let color = Constants.Colors.EmptyJogsScreen.self
    private let borderWidth = Constants.BorderWidth.EmptyJogsScreen.self
    private let cornerRadius = Constants.CornerRadius.self
    private var isVCConfigured = false

    // MARK: - LIfecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isVCConfigured {
            configureViewController()
            isVCConfigured = true
        }
    }
    
    // MARK: - UI Configuration
    private func configureViewController() {
        view.backgroundColor = .white
        view.addSubview(navigationView)
        view.addSubview(centralLogoImageView)
        view.addSubview(centralLabel)
        view.addSubview(actionButton)
        // MARK: navigationView constraints
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: navigationViewHeight).isActive = true
        // MARK: centralLogoImageView settings
        centralLogoImageView.image = UIImage(named: image.centralLogo)
        // MARK: centralLogoImageView constraints
        centralLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        centralLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centralLogoImageView.heightAnchor.constraint(equalToConstant: centralLogoImageViewHeight).isActive = true
        centralLogoImageView.widthAnchor.constraint(equalToConstant: centralLogoImageViewWidth).isActive = true
        centralLogoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: centralLogoImageViewCenterYSpacing).isActive = true
        // MARK: centralLabel settings
        centralLabel.text = "Nothing is there"
        centralLabel.textColor = color.centralLabel
        centralLabel.font = UIFont(name: Font.sfUITextRegular.rawValue, size: centralLabelFontSize)
        // MARK: centralLabel constraints
        centralLabel.translatesAutoresizingMaskIntoConstraints = false
        centralLabel.topAnchor.constraint(equalTo: centralLogoImageView.bottomAnchor, constant: centralLabelTopSpacing).isActive = true
        centralLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // MARK: actionButton settings
        actionButton.setTitle("Create your jog first", for: .normal)
        actionButton.setTitleColor(color.actionButtonText, for: .normal)
        actionButton.titleLabel?.font = UIFont(name: Font.sfUITextBold.rawValue, size: actionButtonFontSize)
        actionButton.layer.cornerRadius = cornerRadius.actionButton
        actionButton.layer.borderWidth = borderWidth.actionButton
        actionButton.layer.borderColor = color.actionButtonBorder.cgColor
        // MARK: actionButton constraints
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButton.topAnchor.constraint(equalTo: centralLabel.bottomAnchor, constant: actionButtonTopSpacing).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: actionButtonWidth).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: actionButtonHeight).isActive = true
    }
}
