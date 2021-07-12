//
//  CollectibleDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import Foundation
import UIKit

protocol CollectibleDetailProtocolInput {
    func setCollectibleDetail(items: CollectibleItems?)
    func getCollectibleDetail()
}

protocol CollectibleDetailProtocolOutput: class {
    var didGetCollectibleDetailSuccess: (() -> Void)? { get set }
    var didGetCollectibleDetailError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func getCollectibleDetail() -> CollectibleItems?
}

protocol CollectibleDetailProtocol: CollectibleDetailProtocolInput, CollectibleDetailProtocolOutput {
    var input: CollectibleDetailProtocolInput { get }
    var output: CollectibleDetailProtocolOutput { get }
}

class CollectibleDetailViewModel: CollectibleDetailProtocol, CollectibleDetailProtocolOutput {
    var input: CollectibleDetailProtocolInput { return self }
    var output: CollectibleDetailProtocolOutput { return self }
    
    // MARK: - Properties
    private var CollectibleDetailViewController: CollectibleDetailViewController
    
    
    
    init(
        CollectibleDetailViewController: CollectibleDetailViewController
    ) {
        self.CollectibleDetailViewController = CollectibleDetailViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetCollectibleDetailSuccess: (() -> Void)?
    var didGetCollectibleDetailError: (() -> Void)?
    
    fileprivate var itemsCollectibleDetail: CollectibleItems?
    fileprivate var listCollectible: [CollectibleItems]? = []
    
    func setCollectibleDetail(items: CollectibleItems?) {
        self.itemsCollectibleDetail = items
    }
    
    func getCollectibleDetail() {
        listCollectible?.removeAll()
//        CollectibleDetailViewController.startLoding()
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listCollectible?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectibleUserUseTableViewCell.identifier, for: indexPath) as! CollectibleUserUseTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func getCollectibleDetail() -> CollectibleItems? {
        return self.itemsCollectibleDetail
    }
}
