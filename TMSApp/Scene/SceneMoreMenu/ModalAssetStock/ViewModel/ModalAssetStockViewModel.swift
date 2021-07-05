//
//  ModalAssetStockViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import UIKit
import Combine

public enum ModalAssetType {
    case AssetStock
    case AssetPickupStock
}

public protocol ModalAssetStockViewModelDelegate {
    func didUpdateSuccess()
}

protocol ModalAssetStockProtocolInput {
//    func getAssetDetail()
    func setAssetData(astId: Int?, delegate: ModalAssetStockViewModelDelegate, modalAssetType: ModalAssetType)
    func createAsset(quantity: Int,
                     note: String
    )
}

protocol ModalAssetStockProtocolOutput: class {
}

protocol ModalAssetStockProtocol: ModalAssetStockProtocolInput, ModalAssetStockProtocolOutput {
    var input: ModalAssetStockProtocolInput { get }
    var output: ModalAssetStockProtocolOutput { get }
}

class ModalAssetStockViewModel: ModalAssetStockProtocol, ModalAssetStockProtocolOutput {
    var input: ModalAssetStockProtocolInput { return self }
    var output: ModalAssetStockProtocolOutput { return self }
    
    // MARK: - Properties
    private var modalAssetStockViewController: ModalAssetStockViewController
    // MARK: - UserCase
    private var postAssetStockUseCase: PostAssetStockUseCase
    private var postAssetPickupStockUseCase: PostAssetPickupStockUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    public var delegate: ModalAssetStockViewModelDelegate?
    
    init(
        modalAssetStockViewController: ModalAssetStockViewController,
        postAssetStockUseCase: PostAssetStockUseCase = PostAssetStockUseCaseImpl(),
        postAssetPickupStockUseCase: PostAssetPickupStockUseCase = PostAssetPickupStockUseCaseImpl()
    ) {
        self.modalAssetStockViewController = modalAssetStockViewController
        self.postAssetStockUseCase = postAssetStockUseCase
        self.postAssetPickupStockUseCase = postAssetPickupStockUseCase
    }
    
    // MARK - Data-binding OutPut

    fileprivate var astId: Int?
    fileprivate var modalAssetType: ModalAssetType?
    
    func setAssetData(astId: Int?, delegate: ModalAssetStockViewModelDelegate, modalAssetType: ModalAssetType = .AssetStock) {
        self.astId = astId
        self.delegate = delegate
        self.modalAssetType = modalAssetType
    }
    
    func createAsset(quantity: Int, note: String) {
        guard let astId = self.astId else { return }
        switch modalAssetType {
        case .AssetStock:
            sendAssetStock(astId: astId, quantity: quantity, note: note)
            break
        case .AssetPickupStock:
            sendAssetPickupStock(astId: astId, quantity: quantity, note: note)
            break
        default: break
        }
    }
    
    func sendAssetStock(astId: Int, quantity: Int, note: String) {
        modalAssetStockViewController.startLoding()
        var request = PostAssetStockRequest()
        request.astId = astId
        request.quantity = quantity
        request.note = note
        self.postAssetStockUseCase.execute(request: request).sink { completion in
            debugPrint("postAssetStock \(completion)")
            self.modalAssetStockViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp {
                if items.success == true {
                    self.modalAssetStockViewController.dismiss(animated: true, completion: nil)
                    self.delegate?.didUpdateSuccess()
                }
            }
        }.store(in: &self.anyCancellable)
    }
    
    func sendAssetPickupStock(astId: Int, quantity: Int, note: String) {
        modalAssetStockViewController.startLoding()
        var request = PostAssetPickupStockRequest()
        request.astId = astId
        request.quantity = quantity
        request.note = note
        
        self.postAssetPickupStockUseCase.execute(request: request).sink { completion in
            debugPrint("postAssetPickupStock \(completion)")
            self.modalAssetStockViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp {
                if items.success == true {
                    self.modalAssetStockViewController.dismiss(animated: true, completion: nil)
                    self.delegate?.didUpdateSuccess()
                }
            }
        }.store(in: &self.anyCancellable)
    }

}
