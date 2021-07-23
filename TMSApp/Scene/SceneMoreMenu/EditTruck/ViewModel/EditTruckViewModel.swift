//
//  EditTruckViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/10/21.
//

import Foundation
import UIKit
import Combine

protocol EditTruckProtocolInput {
    func createTruck(truckTitle: String,
                     truckDesc:String,
                     registrationNumber: String,
                     productImg: String
    )
}

protocol EditTruckProtocolOutput: class {
    var didGetTruckSuccess: (() -> Void)? { get set }
    var didGetTruckError: (() -> Void)? { get set }
}

protocol EditTruckProtocol: EditTruckProtocolInput, EditTruckProtocolOutput {
    var input: EditTruckProtocolInput { get }
    var output: EditTruckProtocolOutput { get }
}

class EditTruckViewModel: EditTruckProtocol, EditTruckProtocolOutput {
    var input: EditTruckProtocolInput { return self }
    var output: EditTruckProtocolOutput { return self }
    
    // MARK: - Properties
    private var editTruckViewController: EditTruckViewController
    // MARK: - UserCase
    private var postTruckUseCase: PostTruckUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        editTruckViewController: EditTruckViewController,
        postTruckUseCase: PostTruckUseCase = PostTruckUseCaseImpl()
    ) {
        self.editTruckViewController = editTruckViewController
        self.postTruckUseCase = postTruckUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetTruckSuccess: (() -> Void)?
    var didGetTruckError: (() -> Void)?
    
    func createTruck(truckTitle: String, truckDesc: String, registrationNumber: String, productImg: String) {
        var request = PostTruckRequest()
        request.compId = 1
        request.truckTitle = truckTitle
        request.truckDesc = truckDesc
        request.registrationNumber = registrationNumber
        
        //Image
        var requestImage = TruckImgRequest()
        requestImage.url = productImg
        requestImage.del = 0
        request.truckImg = requestImage
        
        
        editTruckViewController.startLoding()
        self.postTruckUseCase.execute(request: request).sink { completion in
            debugPrint("postTruck \(completion)")
            self.editTruckViewController.stopLoding()
            
            switch completion {
            case .finished:
                ToastManager.shared.toastCallAPI(title: "PostTruck finished")
                break
            case .failure(_):
                ToastManager.shared.toastCallAPI(title: "PostTruck failure")
                break
            }
            
        } receiveValue: { resp in
            if let items = resp {
                if items.success == true {
                    self.editTruckViewController.navigationController?.popViewController(animated: true)
                }
            }
        }.store(in: &self.anyCancellable)
        
    }
}
