import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let frame = UIScreen.mainScreen().bounds
        let mainViewController = ViewController.init()
        
        let navigationController = UINavigationController.init(rootViewController: mainViewController)
        
        window = UIWindow.init(frame: frame)
        window!.rootViewController = navigationController
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

