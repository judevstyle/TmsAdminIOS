//
//  SplashViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 4/1/21.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoding()
        NavigationManager.instance.setupWithNavigationController(navigationController: self.navigationController)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.stopLoding()
            self.onDidLoadSplashSuccess()
        }
        
        
    }
    
    
    func onDidLoadSplashSuccess() {
//        NavigationManager.instance.pushVC(to: .login, presentation: .Root, isHiddenNavigationBar: true)
        
        let loadingStoryBoard = NavigationOpeningSender.login.storyboardName
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: loadingStoryBoard, bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
}
