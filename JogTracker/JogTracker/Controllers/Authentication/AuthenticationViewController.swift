import UIKit
import Alamofire

class AuthenticationViewController: UIViewController {
    // MARK: - UI lets/vars
    // MARK: navigationView
    private let navigationView = NavigationView.instanceFromNib()
    private let navigationViewHeight: CGFloat = 77
    // MARK: centralLogo
    private let centralLogoImageView = UIImageView()
    private let centralLogoImageViewHeight: CGFloat = 150
    private let centralLogoImageViewWidth: CGFloat = 160
    private let centralLogoImageViewCenterYSpacing: CGFloat = -40
    // MARK: actionButton
    private let actionButton = UIButton()
    private let actionButtonFontSize: CGFloat = 18
    private let actionButtonWidth: CGFloat = 151
    private let actionButtonHeight: CGFloat = 60
    private let actionButtonTopSpacing: CGFloat = 103
    // MARK: - lets/vars
    private let networkManager = NetworkManager.shared
    private let image = Constants.Images.AuthenticationScreen.self
    private let color = Constants.Colors.AuthenticationScreen.self
    private let borderWidth = Constants.BorderWidth.AuthenticationScreen.self
    private let cornerRadius = Constants.CornerRadius.self
    private var isVCConfigured = false
    
    
    // MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        navigationView.actionButton.addTarget(self, action: #selector(sideMenuButtonPressed), for: .touchUpInside)
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
        // MARK: actionButton settings
        actionButton.setTitle("Let me in", for: .normal)
        actionButton.setTitleColor(color.actionButtonText, for: .normal)
        actionButton.titleLabel?.font = UIFont(name: Font.sfUITextBold.rawValue, size: actionButtonFontSize)
        actionButton.layer.cornerRadius = cornerRadius.actionButton
        actionButton.layer.borderWidth = borderWidth.actionButton
        actionButton.layer.borderColor = color.actionButtonBorder.cgColor
        // MARK: actionButton constraints
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButton.topAnchor.constraint(equalTo: centralLogoImageView.bottomAnchor, constant: actionButtonTopSpacing).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: actionButtonWidth).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: actionButtonHeight).isActive = true
    }
    
    // MARK: - Navigation transition functions
    private func showJogsViewController(with data: [JogExternal]) {
        guard let app = UIApplication.shared.delegate,
              let window = app.window else {
            return
        }
        let controller = JogsViewController(dataSource: data)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    private func showSideMenu() {
        let sideMenu = SideMenuView.instanceFromNib()
        sideMenu.delegate = self
        view.addSubview(sideMenu)
        sideMenu.frame.size = self.view.frame.size
        sideMenu.frame.origin = CGPoint(x: self.view.frame.size.width, y: self.view.frame.origin.y)
        UIView.animate(withDuration: 0.3) {
            sideMenu.frame.origin.x = self.view.frame.origin.x
        }
    }
    
    private func hideSideMenuView() {
        self.view.subviews.forEach { view in
            if let sideMenu = view as? SideMenuView {
                UIView.animate(withDuration: 0.3) {
                    sideMenu.frame.origin.x = self.view.frame.size.width
                } completion: { _ in
                    sideMenu.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: - Network functions
    
    private func signInIntoAPIResponse() {
        self.startSpinner()
        self.networkManager.signInIntoAPI(decodeType: ResponseBody.self) { firstResult in
            switch firstResult {
            case .success(let responseBody):
                self.networkManager.saveAccessTokenData(responseBody.response.accessToken)
                self.getSavedJogsResponse()
            case .failure(let responseError):
                print(responseError)
            }
        }
    }
    
    private func getSavedJogsResponse() {
        self.networkManager.getSavedJogs(decodeType: JogsDataBody.self) { result in
            switch result {
            case .success(let jogsDataBody):
                self.showJogsViewController(with: jogsDataBody.response.jogs)
                self.stopSpinner()
            case .failure(let jogsDataBodyError):
                print(jogsDataBodyError)
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction private func actionButtonPressed() {
        signInIntoAPIResponse()
    }
    
    @IBAction private func sideMenuButtonPressed() {
        showSideMenu()
    }
}

extension AuthenticationViewController: SideMenuViewDelegate {
    func showJogsVC() {
        if networkManager.getAccessToken() == nil {
            showAlert(title: "Access denied!", message: "Please sign in.")
            return
        }
        self.startSpinner()
        getSavedJogsResponse()
    }
    func hideSideMenu() {
        hideSideMenuView()
    }
}
