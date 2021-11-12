import UIKit

class JogsViewController: UIViewController {
    // MARK: - UI lets/vars
    // MARK: navigationView
    private let navigationView = NavigationView.instanceFromNib()
    private let navigationViewHeight: CGFloat = 77
    // MARK: mainTableView
    private let mainTableView = UITableView()
    private let mainTableViewBottomSpazing: CGFloat = -30
    private let cellHeight: CGFloat = 188
    // MARK: addJogButton
    private let addJogButton = UIButton()
    private let addJogButtonBottomSpacing: CGFloat = -30
    private let addJogButtonTrailing: CGFloat = -30
    private let addJogButtonSize: CGFloat = 47
    // MARK: - lets/vars
    private let networkManager = NetworkManager.shared
    private let image = Constants.Images.JogScreen.self
    private let color = Constants.Colors.JogScreen.self
    private var isVCConfigured = false
    public var dataSource: [JogExternal]
    
    // MARK: - init functions
    
    init(dataSource: [JogExternal]) {
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIfecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.register(UINib(nibName: "JogTableViewCell", bundle: nil), forCellReuseIdentifier: "JogTableViewCell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        addJogButton.addTarget(self, action: #selector(addJogButtonPressed), for: .touchUpInside)
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
        view.addSubview(mainTableView)
        view.addSubview(addJogButton)
        // MARK: navigationView constraints
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: navigationViewHeight).isActive = true
        // MARK: mainTableView settings
        mainTableView.separatorColor = color.tableViewSeparator
        // MARK: mainTableView constraints
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: addJogButton.topAnchor, constant: mainTableViewBottomSpazing).isActive = true
        // MARK: addJogButton settings
        addJogButton.setImage(UIImage(named: image.addNewJogButton), for: .normal)
        // MARK: addJogButton constraints
        addJogButton.translatesAutoresizingMaskIntoConstraints = false
        addJogButton.heightAnchor.constraint(equalToConstant: addJogButtonSize).isActive = true
        addJogButton.widthAnchor.constraint(equalToConstant: addJogButtonSize).isActive = true
        addJogButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: addJogButtonTrailing).isActive = true
        addJogButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: addJogButtonBottomSpacing).isActive = true
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
    
    private func showJogFormView(with data: JogExternal?, action: RecordAction) {
        let jogFormView = JogFormView.instanceFromNib()
        jogFormView.delegate = self
        jogFormView.configure(with: data)
        jogFormView.action = action
        view.addSubview(jogFormView)
        jogFormView.frame.size = self.view.frame.size
        jogFormView.frame.origin = CGPoint(x: self.view.frame.origin.x, y: self.view.frame.size.height)
        UIView.animate(withDuration: 0.3) {
            jogFormView.frame.origin.y = self.view.frame.origin.y
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
    
    private func hideJogFormView() {
        self.view.subviews.forEach { view in
            if let jogFormView = view as? JogFormView {
                UIView.animate(withDuration: 0.3) {
                    jogFormView.frame.origin.y = self.view.frame.size.height
                } completion: { _ in
                    jogFormView.removeFromSuperview()
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction private func addJogButtonPressed() {
        showJogFormView(with: nil, action: .add)
    }
    
    @IBAction private func sideMenuButtonPressed() {
        showSideMenu()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource functions
extension JogsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "JogTableViewCell", for: indexPath) as? JogTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let jogExternal = dataSource[indexPath.row]
        showJogFormView(with: jogExternal, action: .edit)
    }
}

// MARK: - JogFormViewDelegate functions

extension JogsViewController: JogFormViewDelegate {
    func showAlertView(title: String, message: String) {
        self.showAlert(title: title, message: message)
    }
    
    func hideFormView() {
        hideJogFormView()
    }
    
    func editSelectedJog(with data: JogExternal) {
        self.startSpinner()
        networkManager.editSelectedJog(data) { result in
            switch result {
            case .success:
                self.networkManager.getSavedJogs(decodeType: JogsDataBody.self) { result in
                    switch result {
                    case .success(let jogsDataBody):
                        self.dataSource = jogsDataBody.response.jogs
                        self.mainTableView.reloadData()
                        self.stopSpinner()
                    case .failure(let jogsDataBodyError):
                        print(jogsDataBodyError)
                    }
                }
                self.stopSpinner()
                self.hideJogFormView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createNewJog(_ jog: JogInternal) {
        self.startSpinner()
        networkManager.addNewJog(jog) { result in
            switch result {
            case .success:
                self.networkManager.getSavedJogs(decodeType: JogsDataBody.self) { result in
                    switch result {
                    case .success(let jogsDataBody):
                        self.dataSource = jogsDataBody.response.jogs
                        self.mainTableView.reloadData()
                        self.stopSpinner()
                    case .failure(let jogsDataBodyError):
                        print(jogsDataBodyError)
                    }
                }
                self.stopSpinner()
                self.hideJogFormView()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - SideMenuViewDelegate functions

extension JogsViewController: SideMenuViewDelegate {
    func hideSideMenu() {
        hideSideMenuView()
    }
    
    func showJogsVC() {
        hideSideMenuView()
    }
}
