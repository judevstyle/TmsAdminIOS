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
    case shipmentDetail(item: ShipmentItems)
    case shipmentMap
    case orderCart(orderId: String)
    case appealDetail
    case employee
    case editEmployee
    case typeUser
    case typeUserDetail(item: TypeUserData?)
    case product
    case customer
    case truck
    case planMaster
    case sequenceShipment
    case typeUserProductDetail(itemTypeUser: TypeUserData?,
                               itemProduct: Product?,
                               itemProductSpecial: ProductSpecialForTypeUserItems?,
                               typeAction: TypeUserProductDetailAction,
                               delegate: TypeUserProductDetailViewModelDelegate
         )
    case typeUserProductAll(item: TypeUserData?)
    case productDetail(productId: Int)
    case editTruck
    case editProduct(product: Product?)
    case editPlanMaster(isEdit: Bool)
    case selectEmployee(delegate: SelectEmployeeViewModelDelegate)
    case sortShop(items: [GetShopResponse]?, delegate: SortShopViewModelDelegate)
    case selectShop(items: [GetShopResponse]?, delegate: SelectShopViewModelDelegate)
    case assetList
    case editAsset
    case assetDetail(items: AssetsItems?)
    case assetWithdraw(items: AssetsItems?)
    case chat
    case modalAssetStock(astId: Int?, delegate: ModalAssetStockViewModelDelegate, modalAssetType: ModalAssetType)
    case collectible
    case coleectibleDetail
    case editCollectible
    
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
        case .editTruck:
            return "EditTruck"
        case .editProduct:
            return "EditProduct"
        case .editPlanMaster:
            return "EditPlanMaster"
        case .selectEmployee(_):
            return "SelectEmployee"
        case .sortShop(_, _):
            return "SortShop"
        case .selectShop(_, _):
            return "SelectShop"
        case .assetList:
            return "AssetList"
        case .editAsset:
            return "EditAsset"
        case .assetDetail:
            return "AssetDetail"
        case .assetWithdraw:
            return "AssetWithdraw"
        case .chat:
            return "Chat"
        case .modalAssetStock:
            return "ModalAssetStock"
        case .collectible:
            return "Collectible"
        case .coleectibleDetail:
            return "CollectibleDetail"
        case .editCollectible:
            return "EditCollectible"
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
        case .editTruck:
            return "EditTruckViewController"
        case .editProduct:
            return "EditProductViewController"
        case .editPlanMaster:
            return "EditPlanMasterViewController"
        case .selectEmployee(_):
            return "SelectEmployeeViewController"
        case .sortShop(_, _):
            return "SortShopViewController"
        case .selectShop(_, _):
            return "SelectShopViewController"
        case .assetList:
            return "AssetListViewController"
        case .editAsset:
            return "EditAssetViewController"
        case .assetDetail:
            return "AssetDetailViewController"
        case .assetWithdraw:
            return "AssetWithdrawViewController"
        case .chat:
            return "ChatViewController"
        case .modalAssetStock:
            return "ModalAssetStockViewController"
        case .collectible:
            return "CollectibleViewController"
        case .coleectibleDetail:
            return "CollectibleDetailViewController"
        case .editCollectible:
            return "EditCollectibleViewController"
        }
    }
    
    public var viewController: UIViewController {
        switch self {
        case .chat:
            return ChatViewController()
        default:
            return UIViewController()
        }
    }
    
    public var titleNavigation: String {
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
        case .editTruck:
            return "EditTruck"
        case .editProduct:
            return "EditProduct"
        case .editPlanMaster:
            return "EditPlanMaster"
        case .selectEmployee(_):
            return "SelectEmployee"
        case .sortShop(_, _):
            return "SortShop"
        case .selectShop(_, _):
            return "SelectShop"
        case .assetList:
            return "AssetList"
        case .editAsset:
            return "EditAsset"
        case .assetDetail:
            return "AssetDetail"
        case .assetWithdraw:
            return "AssetWithdraw"
        case .chat:
            return "Chat"
        default:
            return ""
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
        case PopupSheet(completion: (() -> Void)?)
        
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
        var viewController: UIViewController = UIViewController()
        
        switch to {
        case .shipmentDetail(let item):
            if let className = storyboard.instantiateInitialViewController() as? ShipmentDetailViewController {
                className.viewModel.input.setShipment(item: item)
                viewController = className
            }
        case .selectEmployee(let delegate):
            if let className = storyboard.instantiateInitialViewController() as? SelectEmployeeViewController {
                className.viewModel.input.setDelegate(delegate: delegate)
                viewController = className
            }
        case .sortShop(let items, let delegate):
            if let className = storyboard.instantiateInitialViewController() as? SortShopViewController {
                className.viewModel.input.setListSort(items: items)
                className.viewModel.input.setDelegate(delegate: delegate)
                viewController = className
            }
        case .selectShop(let items, let delegate):
            if let className = storyboard.instantiateInitialViewController() as? SelectShopViewController {
                className.viewModel.input.setListSelectedShop(items: items)
                className.viewModel.input.setDelegate(delegate: delegate)
                viewController = className
            }
        case .editPlanMaster(let isEdit):
            if let className = storyboard.instantiateInitialViewController() as? EditPlanMasterViewController {
                className.viewModel.input.setEdit(isEdit: isEdit)
                viewController = className
            }
        case .orderCart(let orderId):
            if let className = storyboard.instantiateInitialViewController() as? OrderCartViewController {
                className.viewModel.input.setOrderId(orderId: orderId)
                viewController = className
            }
        case .typeUserDetail(let item):
            if let className = storyboard.instantiateInitialViewController() as? TypeUserDetailViewController {
                className.viewModel.input.setItemTypeUserData(item: item)
                viewController = className
            }
        case .typeUserProductAll(let item):
            if let className = storyboard.instantiateInitialViewController() as? TypeUserProductAllViewController {
                className.viewModel.input.setItemTypeUserData(item: item)
                viewController = className
            }
        case .typeUserProductDetail(let itemTypeUser, let itemProduct, let itemProductSpecial, let typeAction, let delegate):
            if let className = storyboard.instantiateInitialViewController() as? TypeUserProductDetailViewController {
                className.viewModel.input.setData(itemTypeUser: itemTypeUser, itemProduct: itemProduct, itemProductSpecial: itemProductSpecial, typeAction: typeAction, delegate: delegate)
                viewController = className
            }
        case .productDetail(let productId):
            if let className = storyboard.instantiateInitialViewController() as? ProductDetailViewController {
                className.viewModel.input.setProductId(productId: productId)
                viewController = className
            }
        case .assetDetail(let items):
            if let className = storyboard.instantiateInitialViewController() as? AssetDetailViewController {
                className.viewModel.input.setAssetDetail(items: items)
                viewController = className
            }
        case .modalAssetStock(let astId, let delegate, let modalAssetType):
            if let className = storyboard.instantiateInitialViewController() as? ModalAssetStockViewController {
//                className.viewModel.input.setAssetStock(astId: astId, delegate: delegat)
                className.viewModel.input.setAssetData(astId: astId, delegate: delegate, modalAssetType: modalAssetType)
                viewController = className
            }
        case .assetWithdraw(let items):
            if let className = storyboard.instantiateInitialViewController() as? AssetWithdrawViewController {
                className.viewModel.input.setAssetDetail(items: items)
                viewController = className
            }
        default:
            viewController = storyboard.instantiateInitialViewController() ?? to.viewController
        }
        
        viewController.navigationItem.title = to.titleNavigation
        viewController.hideKeyboardWhenTappedAround()
        
        self.presentVC(viewController: viewController, presentation: presentation, isHiddenNavigationBar: isHiddenNavigationBar)
    }
    
    private func presentVC(viewController: UIViewController, presentation: Presentation, isHiddenNavigationBar: Bool = false) {
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
        case .PopupSheet(completion: let completion):
            viewController.view.backgroundColor = UIColor.blackAlpha(alpha: 0.2)
            viewController.modalPresentationStyle = .overFullScreen
            viewController.modalTransitionStyle = .crossDissolve
            self.navigationController.present(viewController, animated: true, completion: completion)
        }
        self.currentPresentation = presentation
    }
    
    func setRootViewController(rootView: NavigationOpeningSender) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let window = appDelegate.window else {
            return
        }
    }
    
}
