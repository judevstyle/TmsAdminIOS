//
//  SortShopViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import RxSwift
import UIKit


public protocol SortShopViewModelDelegate {
    func updateSortItems(items: [GetShopResponse]?)
}

protocol SortShopProtocolInput {
    func didOpenShop()
    func setListSort(items: [GetShopResponse]?)
    func getListSort()
    func setDelegate(delegate: SortShopViewModelDelegate)
    func swapItem(sourceIndex: Int, destinationIndex: Int)
}

protocol SortShopProtocolOutput: class {
    var didGetSortShopSuccess: (() -> Void)? { get set }
    var didGetSortShopError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getTableViewEditing() -> Bool
}

protocol SortShopProtocol: SortShopProtocolInput, SortShopProtocolOutput {
    var input: SortShopProtocolInput { get }
    var output: SortShopProtocolOutput { get }
}

class SortShopViewModel: SortShopProtocol, SortShopProtocolOutput {
    var input: SortShopProtocolInput { return self }
    var output: SortShopProtocolOutput { return self }
    
    // MARK: - Properties
    private var sortShopViewController: SortShopViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        sortShopViewController: SortShopViewController
    ) {
        self.sortShopViewController = sortShopViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetSortShopSuccess: (() -> Void)?
    var didGetSortShopError: (() -> Void)?
    
    fileprivate var listSortShop: [GetShopResponse]? = []
    
    public var delegate: SortShopViewModelDelegate?
    
    func setDelegate(delegate: SortShopViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setListSort(items: [GetShopResponse]?) {
        self.listSortShop = items
    }
    
    func getListSort() {
        didGetSortShopSuccess?()
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        if self.listSortShop?.count == 0 {
            return 50
        } else {
            return 101
        }
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        if self.listSortShop?.count == 0 {
            return 1
        } else {
            return self.listSortShop?.count ?? 1
        }
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if self.listSortShop?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as! EmptyTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.identifier, for: indexPath) as! ShopTableViewCell
            cell.selectionStyle = .none
            cell.titleText.text = "Title \(self.listSortShop![indexPath.row].id)"
            return cell
        }
    }
    
    func didOpenShop() {
        NavigationManager.instance.pushVC(to: .selectShop(items: self.listSortShop, delegate: self))
    }
    
    func getTableViewEditing() -> Bool {
        if self.listSortShop?.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    func swapItem(sourceIndex: Int, destinationIndex: Int) {
        guard let items = self.listSortShop else { return }
        
        let itemSource = items[sourceIndex]
        self.listSortShop?.remove(at: sourceIndex)
        self.listSortShop?.insert(itemSource, at: destinationIndex)
        
        didGetSortShopSuccess?()
        self.delegate?.updateSortItems(items: self.listSortShop)

        
    }
    
}


extension SortShopViewModel: SelectShopViewModelDelegate {
    func updateItems(items: [GetShopResponse]?) {
        self.listSortShop = items
        didGetSortShopSuccess?()
        self.delegate?.updateSortItems(items: self.listSortShop)
    }
}



public extension Array {
    mutating func swap(ind1: Int, _ ind2: Int){
        var temp: Element
        temp = self[ind1]
        self[ind1] = self[ind2]
        self[ind2] = temp
    }
}
