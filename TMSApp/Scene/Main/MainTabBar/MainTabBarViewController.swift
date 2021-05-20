//
//  MainTabBarViewController.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import UIKit


class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        
        tabBar.tintColor = UIColor.Primary
        tabBar.unselectedItemTintColor = UIColor.PrimaryUnselectTabbar
        tabBar.backgroundColor = UIColor.PrimaryBGTabbar
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        let homeController = tabBarNavigation(unselectImage: UIImage(named: "home"), selectImage: UIImage(named: "home"), title: "หน้าหลัก", badgeValue: nil, navigationTitle: "Dashboard ประจำวันที่ \(Date().dateFormattedEn_US)", navigationOpeningSender: .main)
        
        let shipmentController = tabBarNavigation(unselectImage: UIImage(named: "delivery"), selectImage: UIImage(named: "delivery"), title: "ทำงาน", badgeValue: nil, navigationTitle: "Shipment", navigationOpeningSender: .shipment)
        
        let orderController = tabBarNavigation(unselectImage: UIImage(named: "package"), selectImage: UIImage(named: "package"), title: "สั่งซื้อ", badgeValue: nil, navigationTitle: "Order", navigationOpeningSender: .order)
        
        let appealController = tabBarNavigation(unselectImage: UIImage(named: "rating"), selectImage: UIImage(named: "rating"), title: "ร้องเรียน", badgeValue: nil, navigationTitle: "Order", navigationOpeningSender: .appeal)
        
        let menuController = tabBarNavigation(unselectImage: UIImage(named: "menu"), selectImage: UIImage(named: "menu"), title: "เพิ่มเติม", badgeValue: nil, navigationTitle: "Menu", navigationOpeningSender: .menu)
        
        viewControllers = [homeController, shipmentController, orderController, appealController, menuController]
    }
    
    
    fileprivate func tabBarNavigation(unselectImage: UIImage?, selectImage: UIImage?, title: String?, badgeValue: String?,navigationTitle: String?, navigationOpeningSender: NavigationOpeningSender) -> UINavigationController {
        
        let loadingStoryBoard = navigationOpeningSender.storyboardName
        let storyboard = UIStoryboard(name: loadingStoryBoard, bundle: nil)
        let rootViewcontroller = storyboard.instantiateInitialViewController()
        
        let navController = UINavigationController(rootViewController: rootViewcontroller ?? UIViewController())
        navController.tabBarItem.image = unselectImage
        navController.tabBarItem.selectedImage =  selectImage
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 1, left: 0, bottom: -3, right: 0)
        navController.tabBarItem.title = title
        navController.tabBarItem.badgeColor = .red
        navController.tabBarItem.badgeValue = badgeValue
        navController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.PrimaryText(size: 11)], for: .normal)
        
        
        //navigationController
        rootViewcontroller?.navigationItem.title = navigationTitle ?? ""
        rootViewcontroller?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.PrimaryMedium(size: 18), NSAttributedString.Key.foregroundColor: UIColor.white]
        rootViewcontroller?.navigationController?.navigationBar.barTintColor = UIColor.Primary
        rootViewcontroller?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.bottom, barMetrics: .default)
        rootViewcontroller?.navigationController?.navigationBar.shadowImage = UIImage()
        rootViewcontroller?.navigationController?.navigationBar.isTranslucent = false
        rootViewcontroller?.navigationController?.navigationBar.barStyle = .black
        rootViewcontroller?.navigationController?.navigationBar.tintColor = .white
        
        return navController
    }
    
}


extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.lastIndex(of: viewController)
        
        return true
    }
}
