//
//  CollectibleViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/20/21.
//

import Foundation
import UIKit
import Combine

protocol CollectibleProtocolInput {
    func getCollectible()
}

protocol CollectibleProtocolOutput: class {
    var didGetCollectibleSuccess: (() -> Void)? { get set }
    var didGetCollectibleError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getItemCollectible(_ tableView: UITableView, indexPath: IndexPath) -> CollectibleItems?
}

protocol CollectibleProtocol: CollectibleProtocolInput, CollectibleProtocolOutput {
    var input: CollectibleProtocolInput { get }
    var output: CollectibleProtocolOutput { get }
}

class CollectibleViewModel: CollectibleProtocol, CollectibleProtocolOutput {
    var input: CollectibleProtocolInput { return self }
    var output: CollectibleProtocolOutput { return self }
    
    // MARK: - Properties
    private var collectibleViewController: CollectibleViewController
    // MARK: - UserCase
    private var getCollectibleUseCase: GetCollectibleUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        collectibleViewController: CollectibleViewController,
        getCollectibleUseCase: GetCollectibleUseCase = GetCollectibleUseCaseImpl()
    ) {
        self.collectibleViewController = collectibleViewController
        self.getCollectibleUseCase = getCollectibleUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetCollectibleSuccess: (() -> Void)?
    var didGetCollectibleError: (() -> Void)?
    
    fileprivate var listCollectible: [CollectibleItems]? = []
    
    func getCollectible() {
        listCollectible?.removeAll()
        collectibleViewController.startLoding()
        self.getCollectibleUseCase.execute().sink { completion in
            debugPrint("getCollectible \(completion)")
            self.collectibleViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listCollectible = items
            }
            self.didGetCollectibleSuccess?()
        }.store(in: &self.anyCancellable)
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
        cell.items = listCollectible?[indexPath.item]
        return cell
    }
    
    func getItemCollectible(_ tableView: UITableView, indexPath: IndexPath) -> CollectibleItems? {
        return self.listCollectible?[indexPath.item]
    }
}
