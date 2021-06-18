//
//  NavigationManager.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import Foundation
import UIKit
import MaterialComponents

public enum NavigationOpeningSender {
    case login
    case mainTabBar
    case main
    case shipment
    case order
    case appeal
    case menu
    case shipmentDetail
    case shipmentMap
    case orderCart
    case appealDetail
    case employee
    case editEmployee
    case typeUser
    case typeUserDetail
    case product
    case customer
    case truck
    case planMaster
    case sequenceShipment
    case typeUserProductDetail
    case typeUserProductAll
    case productDetail
    
    public var storyboardName: String {
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
        case .shipmentDetail:
            return "ShipmentDetail"
        case .shipmentMap:
            return "ShipmentMap"
        case .orderCart:
            return "OrderCart"
        case .appealDetail:
            return "AppealDetail"
        case .employee:
            return "Employee"
        case .editEmployee:
            return "EditEmployee"
        case .typeUser:
            return "TypeUser"
        case .typeUserDetail:
            return "TypeUserDetail"
        case .product:
            return "Product"
        case .customer:
            return "Customer"
        case .truck:
            return "Truck"
        case .planMaster:
            return "PlanMaster"
        case .sequenceShipment:
            return "SequenceShipment"
        case .typeUserProductDetail:
            return "TypeUserProductDetail"
        case .typeUserProductAll:
            return "TypeUserProductAll"
        case .productDetail:
            return "ProductDetail"
        }
    }
    
    public var classNameString: String {
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
        case .shipmentDetail:
            return "ShipmentDetailViewController"
        case .shipmentMap:
            return "ShipmentMapViewController"
        case .orderCart:
            return "OrderCartViewController"
        case .appealDetail:
            return "AppealDetailViewController"
        case .employee:
            return "EmployeeViewController"
        case .editEmployee:
            return "EditEmployeeViewController"
        case .typeUser:
            return "TypeUserViewController"
        case .typeUserDetail:
            return "TypeUserDetailViewController"
        case .product:
            return "ProductViewController"
        case .customer:
            return "CustomerViewController"
        case .truck:
            return "TruckViewController"
        case .planMaster:
            return "PlanMasterViewController"
        case .sequenceShipment:
            return "SequenceShipmentViewController"
        case .typeUserProductDetail:
            return "TypeUserProductDetailViewController"
        case .typeUserProductAll:
            return "TypeUserProductAllViewController"
        case .productDetail:
            return "ProductDetailViewController"
        }
    }
}

class NavigationManager {
    static let instance:NavigationManager = NavigationManager()
    
    var navigationController: UINavigationController!
    var currentPresentation: Presentation = .Root
    
    enum Presentation {
        case Root
        case Replace
        case Push
        case Modal(completion: (() -> Void)?)
        case ModelNav(completion: (() -> Void)?)
        case BottomSheet(completion: (() -> Void)?, height: CGFloat)
                    
    }
    
    init() {
        
    }
    
    //    func pushViewControllerFromBottomBar() {
    //    }
    //
    //    func popToRoot() {
    //    }
    //
    //    func pushViewController(to: NavigationOpeningSender) {
    //
    //    }
    
    func setupWithNavigationController(navigationController: UINavigationController?) {
        if let nav = navigationController {
            self.navigationController = nav
        }
    }
    
    func pushVC(to: NavigationOpeningSender, presentation: Presentation = .Push, isHiddenNavigationBar: Bool = false) {
        let loadingStoryBoard = to.storyboardName
        let storyboard = UIStoryboard(name: loadingStoryBoard, bundle: nil)
        var viewController:UIViewController = UIViewController()
        
        switch to {
        case .orderCart:
            if let className = storyboard.instantiateInitialViewController() as? OrderCartViewController {
                //                className.set(contentType: contentType)
                viewController = className
            }
        default:
            viewController = storyboard.instantiateInitialViewController() ?? UIViewController()
        }
        
        viewController.navigationItem.title = to.storyboardName
        
        if case .Modal(_) = self.currentPresentation {
            //Clear modal if we are presenting one
            self.navigationController.dismiss(animated: true, completion: { self.presentVC(viewController: viewController, presentation: presentation, isHiddenNavigationBar: isHiddenNavigationBar) })
        } else {
            self.presentVC(viewController: viewController, presentation: presentation, isHiddenNavigationBar: isHiddenNavigationBar)
        }
    }
    
    private func presentVC(viewController: UIViewController, presentation: Presentation, isHiddenNavigationBar: Bool) {
        self.navigationController.isNavigationBarHidden = isHiddenNavigationBar
        switch presentation {
        case .Push:
            if (self.navigationController.tabBarController != nil) {
                viewController.hidesBottomBarWhenPushed = true
            }
            
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            self.navigationController.pushViewController(viewController, animated: true)
            
        case .Root:
            self.navigationController.setViewControllers([viewController], animated: true)
        case .Modal(let completion):
            self.navigationController.present(viewController, animated: true, completion: completion)
        case .Replace:
            var viewControllers = Array(self.navigationController.viewControllers.dropLast())
            viewControllers.append(viewController)
            self.navigationController.setViewControllers(viewControllers, animated: true)
        case .ModelNav(let completion):
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController.present(viewController, animated: true, completion: completion)
        case .BottomSheet(let completion, let height):
//            viewController.modalPresentationStyle = .automatic
            viewController.view.setRounded(rounded: 20)
            let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
            bottomSheet.preferredContentSize = CGSize(width: viewController.view.frame.size.width, height: height)
            bottomSheet.view.setRounded(rounded: 20)
            self.navigationController.present(bottomSheet, animated: true, completion: completion)
        }
        self.currentPresentation = presentation
    }
    
    func setRootViewController(rootView: NavigationOpeningSender) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let window = appDelegate.window else {
            return
        }
        
        //        let loadingStoryBoard = rootView.storyboardName
        //        let storyboard = UIStoryboard(name: loadingStoryBoard, bundle: nil)
        //        let vc = storyboard.instantiateInitialViewController()
        //        window.rootViewController = vc
        //        window.makeKeyAndVisible()
        //        UIView.transition(with: window,
        //                          duration: 0.3,
        //                          options: .transitionCrossDissolve,
        //                          animations: nil,
        //                          completion: nil)
    }
    
}
