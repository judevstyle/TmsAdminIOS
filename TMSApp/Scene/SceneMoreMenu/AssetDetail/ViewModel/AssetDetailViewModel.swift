//
//  AssetDetailViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import UIKit
import Combine

protocol AssetDetailProtocolInput {
    func setAssetDetail(items: AssetsItems?)
    func getAssetStock()
}

protocol AssetDetailProtocolOutput: class {
    var didGetAssetStockSuccess: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func getAssetDetail() -> AssetsItems?
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
    // MARK: - UserCase
    private var getAssetStockUseCase: GetAssetStockUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        assetDetailViewController: AssetDetailViewController,
        getAssetStockUseCase: GetAssetStockUseCase = GetAssetStockUseCaseImpl()
    ) {
        self.assetDetailViewController = assetDetailViewController
        self.getAssetStockUseCase = getAssetStockUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetAssetStockSuccess: (() -> Void)?

    fileprivate var itemsAssetDetail: AssetsItems?
    fileprivate var listAssetStock: [AssetStockItems]? = []
    
    func setAssetDetail(items: AssetsItems?) {
        self.itemsAssetDetail = items
    }
    
    func getAssetStock() {
        self.listAssetStock?.removeAll()
        assetDetailViewController.startLoding()
        guard let astId = self.itemsAssetDetail?.astId else { return }
        self.getAssetStockUseCase.execute(astId: astId).sink { completion in
            debugPrint("getAssetStock \(completion)")
            self.assetDetailViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listAssetStock = items
            }
            self.didGetAssetStockSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getAssetDetail() -> AssetsItems? {
        return self.itemsAssetDetail
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listAssetStock?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AssetStockTableViewCell.identifier, for: indexPath) as! AssetStockTableViewCell
        cell.selectionStyle = .none
        cell.setupValueAssetStock(items: self.listAssetStock?[indexPath.item], itemDetail: self.itemsAssetDetail)
        return cell
    }
}
