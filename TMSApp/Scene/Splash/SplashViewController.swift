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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.stopLoding()
            self.onDidLoadSplashSuccess()
        }
        
    }
    
    
    func onDidLoadSplashSuccess() {
        NavigationManager.instance.setRootViewController(rootView: .login)
    }
    
}
