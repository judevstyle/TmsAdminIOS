//
//  AssetListViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation
import UIKit
import Combine

protocol AssetListProtocolInput {
    func getAssets()
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
    // MARK: - UserCase
    private var getAssetsUseCase: GetAssetsUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        assetListViewController: AssetListViewController,
        getAssetsUseCase: GetAssetsUseCase = GetAssetsUseCaseImpl()
    ) {
        self.assetListViewController = assetListViewController
        self.getAssetsUseCase = getAssetsUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetAssetListSuccess: (() -> Void)?
    var didGetAssetListError: (() -> Void)?
    
    fileprivate var listAssetList: [AssetsItems]? = []
    
    func getAssets() {
        listAssetList?.removeAll()
        assetListViewController.startLoding()
        
        self.getAssetsUseCase.execute().sink { completion in
            debugPrint("getAssets \(completion)")
            self.assetListViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp {
                self.listAssetList = items
            }
            self.didGetAssetListSuccess?()
        }.store(in: &self.anyCancellable)
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
        cell.items = self.listAssetList?[indexPath.item]
        return cell
    }
}
