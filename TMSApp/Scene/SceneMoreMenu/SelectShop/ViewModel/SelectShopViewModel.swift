//
//  SelectShopViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import UIKit

public protocol SelectShopViewModelDelegate {
    func updateItems(items: [GetShopResponse]?)
}

protocol SelectShopProtocolInput {
    func getSelectShop()
    func didSelectItem(_ tableView: UITableView, indexPath: IndexPath)
    func setDelegate(delegate: SelectShopViewModelDelegate)
    func setListSelectedShop(items: [GetShopResponse]?)
}

protocol SelectShopProtocolOutput: class {
    var didGetSelectShopSuccess: (() -> Void)? { get set }
    var didGetSelectShopError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol SelectShopProtocol: SelectShopProtocolInput, SelectShopProtocolOutput {
    var input: SelectShopProtocolInput { get }
    var output: SelectShopProtocolOutput { get }
}

class SelectShopViewModel: SelectShopProtocol, SelectShopProtocolOutput {
    var input: SelectShopProtocolInput { return self }
    var output: SelectShopProtocolOutput { return self }
    
    // MARK: - Properties
    private var selectShopViewController: SelectShopViewController
    
    
    
    init(
        selectShopViewController: SelectShopViewController
    ) {
        self.selectShopViewController = selectShopViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetSelectShopSuccess: (() -> Void)?
    var didGetSelectShopError: (() -> Void)?
    
    fileprivate var listSelectShop: [GetShopResponse]? = []
    fileprivate var listAllShop: [GetShopResponse]? = []
    fileprivate var listAllCompareShop: [GetShopResponse]? = []
    
    public var delegate: SelectShopViewModelDelegate?
    
    func setDelegate(delegate: SelectShopViewModelDelegate) {
        self.delegate = delegate
    }
    
    func setListSelectedShop(items: [GetShopResponse]?) {
        self.listSelectShop = items
    }
    
    func getSelectShop() {
        listAllShop?.removeAll()
        selectShopViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for index in 0..<10 {
                weakSelf.listAllShop?.append(GetShopResponse(title: "testt", id: index))
            }
            weakSelf.selectShopViewController.stopLoding()
            weakSelf.compareSelectedShop()
        }
    }
    
    private func compareSelectedShop() {
        guard let listAllShop = self.listAllShop, let listSelectShop = self.listSelectShop else { return }
        self.listAllCompareShop?.removeAll()
        for (index, item) in listAllShop.enumerated() {
            var isSelect: Bool = false
            self.listSelectShop?.forEach({ select in
                if select.id == item.id {
                    isSelect = true
                }
            })
            if isSelect == false {
                self.listAllCompareShop?.append(item)
            }
        }
        
        //        print(self.listAllCompareShop?.count)
        //        print(listSelectShop.count)
        didGetSelectShopSuccess?()
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        if self.listAllCompareShop?.count == 0 {
            return 50
        } else {
            return 101
        }
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        if self.listAllCompareShop?.count == 0 {
            return 1
        } else {
            return self.listAllCompareShop?.count ?? 1
        }
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if self.listAllCompareShop?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.identifier, for: indexPath) as! EmptyTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShopTableViewCell.identifier, for: indexPath) as! ShopTableViewCell
            cell.selectionStyle = .none
            cell.titleText.text = "Title \(self.listAllCompareShop![indexPath.row].id)"
            return cell
        }
    }
    
    func didSelectItem(_ tableView: UITableView, indexPath: IndexPath) {
        if var item = self.listAllCompareShop?[indexPath.row] {
            self.listSelectShop?.append(item)
            self.compareSelectedShop()
            self.delegate?.updateItems(items: self.listSelectShop)
        }
    }
    
}
