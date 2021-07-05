//
//  EditAssetViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import UIKit
import Combine

protocol EditAssetProtocolInput {
    func createAsset(assetName: String,
                     assetDesc: String,
                     assetUnit: String,
                     assetImg: String
    )
}

protocol EditAssetProtocolOutput: class {
}

protocol EditAssetProtocol: EditAssetProtocolInput, EditAssetProtocolOutput {
    var input: EditAssetProtocolInput { get }
    var output: EditAssetProtocolOutput { get }
}

class EditAssetViewModel: EditAssetProtocol, EditAssetProtocolOutput {
    var input: EditAssetProtocolInput { return self }
    var output: EditAssetProtocolOutput { return self }
    
    // MARK: - Properties
    private var editAssetViewController: EditAssetViewController
    // MARK: - UserCase
    private var postAssetsUseCase: PostAssetsUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        editAssetViewController: EditAssetViewController,
        postAssetsUseCase: PostAssetsUseCase = PostAssetsUseCaseImpl()
    ) {
        self.editAssetViewController = editAssetViewController
        self.postAssetsUseCase = postAssetsUseCase
    }
    
    // MARK - Data-binding OutPut
    //    var didGetProductTypeSuccess: (() -> Void)?
    //    var didGetProductTypeError: (() -> Void)?
    
    func createAsset(assetName: String, assetDesc: String, assetUnit: String, assetImg: String) {
        var request = PostAssetsRequest()
        request.compId = 1
        request.assetName = assetName
        request.assetDesc = assetDesc
        request.assetUnit = assetUnit
        var requestImage = AssetsImgRequest()
        requestImage.url = assetImg
        requestImage.del = 0
        request.assetImg = requestImage
        
        debugPrint(request.toJSON())
        
        editAssetViewController.startLoding()
        self.postAssetsUseCase.execute(request: request).sink { completion in
            debugPrint("postAssets \(completion)")
            self.editAssetViewController.stopLoding()
        } receiveValue: { resp in
            debugPrint(resp)
            if let items = resp {
                if items.success == true {
                    self.editAssetViewController.navigationController?.popViewController(animated: true)
                }
            }
        }.store(in: &self.anyCancellable)
    }
    
    //    func createAsset(productCode: String, productName: String, productDesc: String, productDimension: String, productPrice: Double, productPoint: Int, productCountPerPoint: Int, productImg: String, productTypeName: String) {
    //        print("createProduct")
    //
    //
    //        var request = PostProductRequest()
    //        request.compId = 1
    //
    //        if let productType = listProductType?.first(where: { $0.productTypeName == productTypeName }) {
    //            request.productTypeId = productType.productTypeId
    //        }
    //
    //        request.productSku = "SKU"
    //        request.productCode = productCode
    //        request.productName = productName
    //        request.productDesc = productDesc
    //        request.productDimension = productDimension
    //        request.productPrice = productPrice
    //        request.productPoint = productPoint
    //        request.productCountPerPoint = productCountPerPoint
    //        var requestImage = ProductImgRequest()
    //        requestImage.url = productImg
    //        requestImage.del = 0
    //        request.productImg = requestImage
    //
    //        EditAssetViewController.startLoding()
    //        self.postProductUseCase.execute(request: request).sink { completion in
    //            debugPrint("postProduct \(completion)")
    //            self.EditAssetViewController.stopLoding()
    //        } receiveValue: { resp in
    //            if let items = resp {
    //                if items.success == true {
    //                    self.EditAssetViewController.navigationController?.popViewController(animated: true)
    //                }
    //            }
    //        }.store(in: &self.anyCancellable)
    //    }
}
