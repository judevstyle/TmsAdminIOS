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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(onDidLoadSplashSuccess(_:)), name: .didLoadSplashSuccess, object: nil)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            NotificationCenter.default.post(name: .didLoadSplashSuccess, object: nil)
//        }
        
    }
    
    
    @objc func onDidLoadSplashSuccess(_ notification:Notification) {
        let loadingStoryBoard = "Login"
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: loadingStoryBoard, bundle: nil)
        let initialViewController = storyboard.instantiateInitialViewController()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }

}
