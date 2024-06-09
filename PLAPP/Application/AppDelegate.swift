//
//  AppDelegate.swift
//  PLAPP
//
//  Created by AnhNTV3 on 25/03/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var shared = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let vc = SharedData.accessToken == nil ? LoginVC.create() : MainVC.create()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
    
    func changeRoot(_ controller: UIViewController) {
        SystemBoots.instance.changeRoot(window: &window, rootController: controller)
    }
}

class SystemBoots {
    
    // MARK: - Singleton
    static let instance = SystemBoots()
    
    // MARK: - Variables
    weak var appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    
    // MARK: - Actions
    func changeRoot(window: inout UIWindow?, rootController: UIViewController) {
        // Setup app's window
        guard window == nil else {
            window?.rootViewController = rootController
            window?.makeKeyAndVisible()
            return
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
    }
}
