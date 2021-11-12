import UIKit

class NavigationView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Initialization function
    class func instanceFromNib() -> NavigationView {
        guard let navigationView = UINib(nibName: "NavigationView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? NavigationView else {
            return NavigationView()
        }
        return navigationView
    }
}
