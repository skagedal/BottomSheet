//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let mapViewController = MapViewController()
        let shortcutsViewController = CountriesTableViewController()
        window.rootViewController = BottomSheetContainerViewController(mainViewController: mapViewController,
                                                                       sheetViewController: shortcutsViewController)
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
}

