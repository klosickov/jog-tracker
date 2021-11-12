import UIKit

class InfoViewController: UIViewController {
    // MARK: - UI lets/vars
    // MARK: navigationView
    private let navigationView = NavigationView.instanceFromNib()
    private let navigationViewHeight: CGFloat = 77
    // MARK: mainScrollView
    private let mainScrollView = UIScrollView()
    // MARK: titleLabel
    private let titleLabel = UILabel()
    private let titleLabelLeading: CGFloat = 25
    private let titleLabelTopSpacing: CGFloat = 24
    private let titleLabelFontSize: CGFloat = 25
    // MARK: labelsContainerView
    private let labelsContainerView = UIView()
    // MARK: firstTextContainerLabel
    private let firstTextContainerLabel = UILabel()
    private let firstTextContainerLabelTopSpacing: CGFloat = 6
    private let firstTextContainerLabelLeading: CGFloat = 25
    private let firstTextContainerLabelTrailing: CGFloat = -25
    private let firstTextContainerLabelFontSize: CGFloat = 12
    private let firstTextContainerLabelLineHeight: CGFloat = 12
    // MARK: secondTextContainerLabel
    private let secondTextContainerLabel = UILabel()
    private let secondTextContainerLabelTopSpacing: CGFloat = 331
    private let secondTextContainerLabelFontSize: CGFloat = 12
    private let secondTextContainerLabelLineHeight: CGFloat = 12
    private let secondTextContainerLabelMinimumBottomSpacing: CGFloat = -30
    // MARK: - lets/vars
    private let networkManager = NetworkManager.shared
    private let color = Constants.Colors.InfoScreen.self
    private let text = Constants.Texts.InfoScreen.self
    private var isVCConfigured = false
    
    // MARK: - LIfecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
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
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(labelsContainerView)
        labelsContainerView.addSubview(titleLabel)
        labelsContainerView.addSubview(firstTextContainerLabel)
        labelsContainerView.addSubview(secondTextContainerLabel)
        // MARK: navigationView constraints
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: navigationViewHeight).isActive = true
        // MARK: mainScrollView constraints
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainScrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainScrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        // MARK: labelsContainerView constraints
        labelsContainerView.translatesAutoresizingMaskIntoConstraints = false
        labelsContainerView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true
        labelsContainerView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true
        labelsContainerView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true
        labelsContainerView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true
        labelsContainerView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor, multiplier: 1).isActive = true
        // MARK: titleLabel settings
        titleLabel.font = UIFont(name: Font.sfUITextBold.rawValue, size: titleLabelFontSize)
        titleLabel.textColor = color.titleLabel
        titleLabel.text = "INFO"
        // MARK: titleLabel constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor, constant: titleLabelLeading).isActive = true
        titleLabel.topAnchor.constraint(equalTo: labelsContainerView.topAnchor, constant: titleLabelTopSpacing).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // MARK: firstTextContainerLabel settings
        firstTextContainerLabel.font = UIFont(name: Font.sfUITextRegular.rawValue, size: firstTextContainerLabelFontSize)
        let firstAttributedString = NSMutableAttributedString(string: text.firstTextContainer)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = firstTextContainerLabelLineHeight
        firstAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, firstAttributedString.length))
        firstTextContainerLabel.attributedText = firstAttributedString
        firstTextContainerLabel.numberOfLines = 0
        // MARK: firstTextContainerLabel constants
        firstTextContainerLabel.translatesAutoresizingMaskIntoConstraints = false
        firstTextContainerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: firstTextContainerLabelTopSpacing).isActive = true
        firstTextContainerLabel.leadingAnchor.constraint(equalTo: labelsContainerView.leadingAnchor, constant: firstTextContainerLabelLeading).isActive = true
        firstTextContainerLabel.trailingAnchor.constraint(equalTo: labelsContainerView.trailingAnchor, constant: firstTextContainerLabelTrailing).isActive = true
        // MARK: secondTextContainerLabel settings
        secondTextContainerLabel.font = UIFont(name: Font.sfUITextRegular.rawValue, size: secondTextContainerLabelFontSize)
        let secondAttributedString = NSMutableAttributedString(string: text.secondTextContainer)
        paragraphStyle.lineSpacing = secondTextContainerLabelLineHeight
        secondAttributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, secondAttributedString.length))
        secondTextContainerLabel.attributedText = secondAttributedString
        secondTextContainerLabel.numberOfLines = 0
        // MARK: firstTextContainerLabel constants
        secondTextContainerLabel.translatesAutoresizingMaskIntoConstraints = false
        secondTextContainerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: secondTextContainerLabelTopSpacing).isActive = true
        secondTextContainerLabel.leadingAnchor.constraint(equalTo: firstTextContainerLabel.leadingAnchor).isActive = true
        secondTextContainerLabel.trailingAnchor.constraint(equalTo: firstTextContainerLabel.trailingAnchor).isActive = true
        secondTextContainerLabel.bottomAnchor.constraint(lessThanOrEqualTo: labelsContainerView.bottomAnchor, constant: secondTextContainerLabelMinimumBottomSpacing).isActive = true
    }
    
    // MARK: - Actions functions
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
    
    private func showJogsViewController(with data: [JogExternal]) {
        guard let app = UIApplication.shared.delegate,
              let window = app.window else {
            return
        }
        let controller = JogsViewController(dataSource: data)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Network function
    
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
    
    @IBAction private func sideMenuButtonPressed() {
        showSideMenu()
    }
}

// MARK: - SideMenuViewDelegate functions

extension InfoViewController: SideMenuViewDelegate {
    func hideSideMenu() {
        hideSideMenuView()
    }
    
    func showJogsVC() {
        if networkManager.getAccessToken() == nil {
            showAlert(title: "Access denied!", message: "Please sign in.")
            return
        }
        self.startSpinner()
        getSavedJogsResponse()
    }
}
