//
//  AssetWithdrawViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import UIKit
import Combine

protocol AssetWithdrawProtocolInput {
    func setAssetDetail(items: AssetsItems?)
    func getAssetWithdraw()
}

protocol AssetWithdrawProtocolOutput: class {
    var didGetAssetWithdrawSuccess: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    
    func getAssetDetail() -> AssetsItems?
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
    // MARK: - UserCase
    private var getAssetPickupStockUseCase: GetAssetPickupStockUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        assetWithdrawViewController: AssetWithdrawViewController,
        getAssetPickupStockUseCase: GetAssetPickupStockUseCase = GetAssetPickupStockUseCaseImpl()
    ) {
        self.assetWithdrawViewController = assetWithdrawViewController
        self.getAssetPickupStockUseCase = getAssetPickupStockUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetAssetWithdrawSuccess: (() -> Void)?
    
    fileprivate var itemsAssetDetail: AssetsItems?
    fileprivate var listAssetWithdraw: [AssetPickupStockItems]? = []
    
    func setAssetDetail(items: AssetsItems?) {
        self.itemsAssetDetail = items
    }
    
    func getAssetWithdraw() {
        listAssetWithdraw?.removeAll()
        assetWithdrawViewController.startLoding()

        guard let astId = self.itemsAssetDetail?.astId else { return }
        self.getAssetPickupStockUseCase.execute(astId: astId).sink { completion in
            debugPrint("getAssetPickupStock \(completion)")
            self.assetWithdrawViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetAssetPickupStock finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetAssetPickupStock failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listAssetWithdraw = items
            }
            self.didGetAssetWithdrawSuccess?()
        }.store(in: &self.anyCancellable)
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
        cell.setupValueAssetPickupStock(items: listAssetWithdraw?[indexPath.item], itemDetail: self.itemsAssetDetail)
        return cell
    }
    
    func getAssetDetail() -> AssetsItems? {
        return self.itemsAssetDetail
    }
}

