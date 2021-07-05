//
//  EditCollectibleViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/4/21.
//

import Foundation
import UIKit
import Combine

protocol EditCollectibleProtocolInput {
    func createCollectible(clbTitle: String, clbDescript: String, qty: String, clbImg: String,
                           rewardPoint: String, campaignStartDate: String, campaignEndDate: String)
}

protocol EditCollectibleProtocolOutput: class {
}

protocol EditCollectibleProtocol: EditCollectibleProtocolInput, EditCollectibleProtocolOutput {
    var input: EditCollectibleProtocolInput { get }
    var output: EditCollectibleProtocolOutput { get }
}

class EditCollectibleViewModel: EditCollectibleProtocol, EditCollectibleProtocolOutput {
    var input: EditCollectibleProtocolInput { return self }
    var output: EditCollectibleProtocolOutput { return self }
    
    // MARK: - Properties
    private var editCollectibleViewController: EditCollectibleViewController
    // MARK: - UserCase
    private var postCollectibleUseCase: PostCollectibleUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        editCollectibleViewController: EditCollectibleViewController,
        postCollectibleUseCase: PostCollectibleUseCase = PostCollectibleUseCaseImpl()
    ) {
        self.editCollectibleViewController = editCollectibleViewController
        self.postCollectibleUseCase = postCollectibleUseCase
    }
    
    func createCollectible(clbTitle: String, clbDescript: String, qty: String, clbImg: String,
                           rewardPoint: String, campaignStartDate: String, campaignEndDate: String) {
        var request = PostCollectibleRequest()
        request.compId = 1
        request.clbTitle = clbTitle
        request.clbDescript = clbDescript
        request.qty = qty
        var requestImage = CollectibleImgRequest()
        requestImage.url = clbImg
        requestImage.del = 0
        request.clbImg = requestImage
        
        
        request.rewardPoint = Int(rewardPoint) ?? 0
        request.campaignStartDate = campaignStartDate
        request.campaignEndDate = campaignEndDate
        
        editCollectibleViewController.startLoding()
        self.postCollectibleUseCase.execute(request: request).sink { completion in
            debugPrint("postCollectible \(completion)")
            self.editCollectibleViewController.stopLoding()
        } receiveValue: { resp in
            debugPrint(resp)
            if let items = resp {
                if items.success == true {
                    self.editCollectibleViewController.navigationController?.popViewController(animated: true)
                }
            }
        }.store(in: &self.anyCancellable)
    }
}
