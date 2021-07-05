//
//  AssetPickupStockRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Combine
import Moya

protocol AssetPickupStockRepository {
    func getAssetPickupStock(request: GetAssetPickupStockRequest) -> AnyPublisher<GetAssetPickupStockResponse, Error>
    func createAssetPickupStock(request: PostAssetPickupStockRequest) -> AnyPublisher<PostAssetPickupStockResponse, Error>
}

final class AssetPickupStockRepositoryImpl: TMSApp.AssetPickupStockRepository {
    private let provider: MoyaProvider<AssetPickupStockAPI> = MoyaProvider<AssetPickupStockAPI>()
    
    func getAssetPickupStock(request: GetAssetPickupStockRequest) -> AnyPublisher<GetAssetPickupStockResponse, Error> {
        return self.provider
            .cb
            .request(.getAssetPickup(request: request))
            .map(GetAssetPickupStockResponse.self)
    }
    
    func createAssetPickupStock(request: PostAssetPickupStockRequest) -> AnyPublisher<PostAssetPickupStockResponse, Error> {
        return self.provider
            .cb
            .request(.createAssetPickup(request: request))
            .map(PostAssetPickupStockResponse.self)
    }
}
