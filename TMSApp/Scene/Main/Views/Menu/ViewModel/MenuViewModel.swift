//
//  MenuViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/17/21.
//

import Foundation
import RxSwift
import UIKit

protocol MenuProtocolInput {
    func getMenu()
}

protocol MenuProtocolOutput: class {
    var didGetMenuSuccess: (() -> Void)? { get set }
    var didGetMenuError: (() -> Void)? { get set }
    
    func getNumberOfMenu() -> Int
    func getItemMenu(index: Int) -> GetMenuResponse?
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func getItemViewCellHeight() -> CGFloat
    func getSizeItemViewCell() -> CGSize
}

protocol MenuProtocol: MenuProtocolInput, MenuProtocolOutput {
    var input: MenuProtocolInput { get }
    var output: MenuProtocolOutput { get }
}

class MenuViewModel: MenuProtocol, MenuProtocolOutput {
    var input: MenuProtocolInput { return self }
    var output: MenuProtocolOutput { return self }
    
    // MARK: - Properties
//    private var getProductUseCase: GetProductUseCase
    private var menuViewController: MenuViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
//        getProductUseCase: GetProductUseCase = GetProductUseCaseImpl(),
        menuViewController: MenuViewController
    ) {
//        self.getProductUseCase = getProductUseCase
        self.menuViewController = menuViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetMenuSuccess: (() -> Void)?
    var didGetMenuError: (() -> Void)?
    
    fileprivate var listMenu: [GetMenuResponse]? = []
    
    func getMenu() {
        listMenu?.removeAll()
        menuViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            
            weakSelf.listMenu?.append(GetMenuResponse(title: "ข้อมูลส่วนตัว", image: "01"))
            weakSelf.listMenu?.append(GetMenuResponse(title: "พนักงาน", image: "02", scene: .employee))
            weakSelf.listMenu?.append(GetMenuResponse(title: "ประเภทสินค้า", image: "03", scene: .typeUser))
            weakSelf.listMenu?.append(GetMenuResponse(title: "สินค้า", image: "04", scene: .product))
            
            weakSelf.listMenu?.append(GetMenuResponse(title: "ลูกค้า", image: "05", scene: .customer))
            weakSelf.listMenu?.append(GetMenuResponse(title: "รายงาน", image: "06"))
            weakSelf.listMenu?.append(GetMenuResponse(title: "รถส่งของ", image: "07", scene: .truck))
            weakSelf.listMenu?.append(GetMenuResponse(title: "แผนงาน", image: "08", scene: .planMaster))
            
            weakSelf.listMenu?.append(GetMenuResponse(title: "Shipment", image: "09"))
            weakSelf.listMenu?.append(GetMenuResponse(title: "Asset", image: "10", scene: .assetList))
            weakSelf.listMenu?.append(GetMenuResponse(title: "ของแลก", image: "11", scene: .collectible))
            
            weakSelf.didGetMenuSuccess?()
            weakSelf.menuViewController.stopLoding()
        }
    }
    
    func getNumberOfMenu() -> Int {
        guard let count = listMenu?.count, count != 0 else { return 0 }
        return count
    }
    
    func getItemMenu(index: Int) -> GetMenuResponse? {
        guard let itemMenu = listMenu?[index] else { return nil }
        return itemMenu
    }
    
    func getItemViewCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as! MenuCollectionViewCell
        cell.setData(item: getItemMenu(index: indexPath.item))
        return cell
    }
    
    func getItemViewCellHeight() -> CGFloat {
        return 13
    }
    
    func getSizeItemViewCell() -> CGSize {
        let width = UIScreen.main.bounds.width / 4
        return CGSize(width: width, height: width)
    }
    
}
