//
//  CollectibleDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import Foundation
import UIKit
import RxSwift

protocol CollectibleDetailProtocolInput {
    func getCollectibleDetail()
}

protocol CollectibleDetailProtocolOutput: class {
    var didGetCollectibleDetailSuccess: (() -> Void)? { get set }
    var didGetCollectibleDetailError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
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
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        CollectibleDetailViewController: CollectibleDetailViewController
    ) {
        self.CollectibleDetailViewController = CollectibleDetailViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetCollectibleDetailSuccess: (() -> Void)?
    var didGetCollectibleDetailError: (() -> Void)?
    
    fileprivate var listCollectibleDetail: [GetAppealResponse]? = []
    
    func getCollectibleDetail() {
        listCollectibleDetail?.removeAll()
        CollectibleDetailViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<7 {
                weakSelf.listCollectibleDetail?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetCollectibleDetailSuccess?()
            weakSelf.CollectibleDetailViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listCollectibleDetail?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectibleUserUseTableViewCell.identifier, for: indexPath) as! CollectibleUserUseTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
