import UIKit

protocol SideMenuViewDelegate: AnyObject {
    func hideSideMenu()
    func showJogsVC()
}

class SideMenuView: UIView {
    // MARK: - lets/vars
    private let networkManager = NetworkManager.shared
    weak var delegate: SideMenuViewDelegate?
    
    // MARK: - Initialization function
    class func instanceFromNib() -> SideMenuView {
        guard let sideMenuView = UINib(nibName: "SideMenuView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? SideMenuView else {
            return SideMenuView()
        }
        return sideMenuView
    }
    
    // MARK: - IBActions
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        delegate?.hideSideMenu()
    }
    
    @IBAction func jogsButtonPressed(_ sender: UIButton) {
        delegate?.showJogsVC()
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        guard let app = UIApplication.shared.delegate,
              let window = app.window else {
            return
        }
        let controller = InfoViewController()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
    
    @IBAction func contactUsButtonPressed(_ sender: UIButton) {
    }
}
