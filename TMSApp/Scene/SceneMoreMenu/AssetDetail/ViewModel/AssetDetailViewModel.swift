//
//  AssetDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import UIKit

protocol AssetDetailProtocolInput {
    func getAssetDetail()
}

protocol AssetDetailProtocolOutput: class {
    var didGetAssetDetailSuccess: (() -> Void)? { get set }
    var didGetAssetDetailError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol AssetDetailProtocol: AssetDetailProtocolInput, AssetDetailProtocolOutput {
    var input: AssetDetailProtocolInput { get }
    var output: AssetDetailProtocolOutput { get }
}

class AssetDetailViewModel: AssetDetailProtocol, AssetDetailProtocolOutput {
    var input: AssetDetailProtocolInput { return self }
    var output: AssetDetailProtocolOutput { return self }
    
    // MARK: - Properties
    private var assetDetailViewController: AssetDetailViewController
    
    
    
    init(
        assetDetailViewController: AssetDetailViewController
    ) {
        self.assetDetailViewController = assetDetailViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetAssetDetailSuccess: (() -> Void)?
    var didGetAssetDetailError: (() -> Void)?
    
    fileprivate var listAssetDetail: [GetAppealResponse]? = []
    
    func getAssetDetail() {
        listAssetDetail?.removeAll()
        assetDetailViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<7 {
                weakSelf.listAssetDetail?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetAssetDetailSuccess?()
            weakSelf.assetDetailViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listAssetDetail?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetStockTableViewCell.identifier, for: indexPath) as! AssetStockTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
