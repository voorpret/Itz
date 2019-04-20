
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setAppearance()
        loadWindow()
        
        return true
    }
    
    private func loadWindow() {
        window = UIWindow()
        window!.rootViewController = RootViewController()
        window!.makeKeyAndVisible()
    }
    
    private func setAppearance() {
        UIView.appearance().tintColor = .kTint
        
        let navBarProxy = UINavigationBar.appearance()
        navBarProxy.isTranslucent = false
        navBarProxy.barTintColor = .kBackground
        navBarProxy.shadowImage = UIImage()
        navBarProxy.prefersLargeTitles = true
    }


}

