//
//  TruckViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/15/21.
//

import Foundation
import UIKit
import Combine

protocol TruckProtocolInput {
    func getTruck()
}

protocol TruckProtocolOutput: class {
    var didGetTruckSuccess: (() -> Void)? { get set }
    var didGetTruckError: (() -> Void)? { get set }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
}

protocol TruckProtocol: TruckProtocolInput, TruckProtocolOutput {
    var input: TruckProtocolInput { get }
    var output: TruckProtocolOutput { get }
}

class TruckViewModel: TruckProtocol, TruckProtocolOutput {
    var input: TruckProtocolInput { return self }
    var output: TruckProtocolOutput { return self }
    
    // MARK: - Properties
    private var truckViewController: TruckViewController
    // MARK: - UseCase
    private var getTruckUseCase: GetTruckUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    init(
        truckViewController: TruckViewController,
        getTruckUseCase: GetTruckUseCase = GetTruckUseCaseImpl()
    ) {
        self.truckViewController = truckViewController
        self.getTruckUseCase = getTruckUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetTruckSuccess: (() -> Void)?
    var didGetTruckError: (() -> Void)?
    
    fileprivate var listTruck: [TruckItems]? = []
    
    func getTruck() {
        listTruck?.removeAll()
        truckViewController.startLoding()
        
        self.getTruckUseCase.execute().sink { completion in
            debugPrint("getTruck \(completion)")
            self.truckViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "GetTruck finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "GetTruck failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp?.items {
                self.listTruck = items
            }
            self.didGetTruckSuccess?()
        }.store(in: &self.anyCancellable)
    }
    
    func getHeightForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func getNumberOfRowsInSection(_ tableView: UITableView, section: Int) -> Int {
        return self.listTruck?.count ?? 0
    }
    
    func getCellForRowAt(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TruckTableViewCell.identifier, for: indexPath) as! TruckTableViewCell
        cell.selectionStyle = .none
        cell.items = self.listTruck?[indexPath.item]
        return cell
    }
}
