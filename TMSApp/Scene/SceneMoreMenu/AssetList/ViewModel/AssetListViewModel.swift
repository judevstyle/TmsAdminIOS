//
//  AssetListViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import UIKit
import RxSwift

protocol AssetListProtocolInput {
    func getAssetList()
}

protocol AssetListProtocolOutput: class {
    var didGetAssetListSuccess: (() -> Void)? { get set }
    var didGetAssetListError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol AssetListProtocol: AssetListProtocolInput, AssetListProtocolOutput {
    var input: AssetListProtocolInput { get }
    var output: AssetListProtocolOutput { get }
}

class AssetListViewModel: AssetListProtocol, AssetListProtocolOutput {
    var input: AssetListProtocolInput { return self }
    var output: AssetListProtocolOutput { return self }
    
    // MARK: - Properties
    private var assetListViewController: AssetListViewController
    
    fileprivate let disposeBag = DisposeBag()
    
    init(
        assetListViewController: AssetListViewController
    ) {
        self.assetListViewController = assetListViewController
    }
    
    // MARK - Data-binding OutPut
    var didGetAssetListSuccess: (() -> Void)?
    var didGetAssetListError: (() -> Void)?
    
    fileprivate var listAssetList: [GetAppealResponse]? = []
    
    func getAssetList() {
        listAssetList?.removeAll()
        assetListViewController.startLoding()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let weakSelf = self else { return }
            for _ in 0..<7 {
                weakSelf.listAssetList?.append(GetAppealResponse(title: "test"))
            }

            weakSelf.didGetAssetListSuccess?()
            weakSelf.assetListViewController.stopLoding()
        }
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listAssetList?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetTableViewCell.identifier, for: indexPath) as! AssetTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
