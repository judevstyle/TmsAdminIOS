//
//  AssetWithdrawViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import UIKit
import RxSwift

protocol AssetWithdrawProtocolInput {
    func getAssetWithdraw()
}

protocol AssetWithdrawProtocolOutput: class {
    var didGetAssetWithdrawSuccess: (() -> Void)? { get set }
    var didGetAssetWithdrawError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol AssetWithdrawProtocol: AssetWithdrawProtocolInput, AssetWithdrawProtocolOutput {
    var input: AssetWithdrawProtocolInput { get }
    var output: AssetWithdrawProtocolOutput { get }
}

class AssetWithdrawViewModel: AssetWithdrawProtocol, AssetWithdrawProtocolOutput {
    var input: AssetWithdrawProtocolInput { return self }
    var output: AssetWithdrawProtocolOutput { return self }
    
    // MARK: - Properties
    private var assetWithdrawViewController: AssetWithdrawViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        assetWithdrawViewController: AssetWithdrawViewController
    ) {
        self.assetWithdrawViewController = assetWithdrawViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetAssetWithdrawSuccess: (() -> Void)?
    var didGetAssetWithdrawError: (() -> Void)?
    
    fileprivate var listAssetWithdraw: [GetAppealResponse]? = []
    
    func getAssetWithdraw() {
        listAssetWithdraw?.removeAll()
        assetWithdrawViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<7 {
                weakSelf.listAssetWithdraw?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetAssetWithdrawSuccess?()
            weakSelf.assetWithdrawViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listAssetWithdraw?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetStockTableViewCell.identifier, for: indexPath) as! AssetStockTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}

