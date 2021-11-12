import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = AuthenticationViewController()
//        let controller = EmptyJogsViewController()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        return true
    }
}
