//
//  NavigationManager.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import Foundation
import UIKit

enum NavigationOpeningSender {
    case login
    case mainTabBar
    case main
    case shipment
    case order
    case appeal
    case menu
    
    var storyboardName: String {
        switch self {
        case .login:
            return "Login"
        case .mainTabBar:
            return "MainTabBar"
        case .main:
            return "Main"
        case .shipment:
            return "Shipment"
        case .order:
            return "Order"
        case .appeal:
            return "Appeal"
        case .menu:
            return "Menu"
        }
    }
    
    var classNameString: String {
        switch self {
        case .login:
            return "LoginViewController"
        case .mainTabBar:
            return "MainTabBarViewController"
        case .main:
            return "MainViewController"
        case .shipment:
            return "ShipmentViewController"
        case .order:
            return "OrderViewController"
        case .appeal:
            return "AppealViewController"
        case .menu:
            return "MenuViewController"
        }
    }
}

class NavigationManager {
    static let instance:NavigationManager = NavigationManager()
    
    func pushViewControllerFromBottomBar() {
    }
    
    func popToRoot() {
    }
    
    func pushViewController(to: NavigationOpeningSender) {
    }
    
    func setRootViewController(rootView: NavigationOpeningSender) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let window = appDelegate.window else {
            return
        }
        
        let loadingStoryBoard = rootView.storyboardName
        let storyboard = UIStoryboard(name: loadingStoryBoard, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
}
