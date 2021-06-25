//
//  CollectibleViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import Foundation
import UIKit

protocol CollectibleProtocolInput {
    func getCollectible()
}

protocol CollectibleProtocolOutput: class {
    var didGetCollectibleSuccess: (() -> Void)? { get set }
    var didGetCollectibleError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol CollectibleProtocol: CollectibleProtocolInput, CollectibleProtocolOutput {
    var input: CollectibleProtocolInput { get }
    var output: CollectibleProtocolOutput { get }
}

class CollectibleViewModel: CollectibleProtocol, CollectibleProtocolOutput {
    var input: CollectibleProtocolInput { return self }
    var output: CollectibleProtocolOutput { return self }
    
    // MARK: - Properties
    private var CollectibleViewController: CollectibleViewController
    
    
    
    init(
        CollectibleViewController: CollectibleViewController
    ) {
        self.CollectibleViewController = CollectibleViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetCollectibleSuccess: (() -> Void)?
    var didGetCollectibleError: (() -> Void)?
    
    fileprivate var listCollectible: [GetAppealResponse]? = []
    
    func getCollectible() {
        listCollectible?.removeAll()
        CollectibleViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<7 {
                weakSelf.listCollectible?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetCollectibleSuccess?()
            weakSelf.CollectibleViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listCollectible?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectibleTableViewCell.identifier, for: indexPath) as! CollectibleTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
