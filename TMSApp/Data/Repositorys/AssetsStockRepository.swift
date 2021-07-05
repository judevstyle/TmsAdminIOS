//
//  AssetsStockRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Combine
import Moya

protocol AssetStockRepository {
    func getAssetsStock(request: GetAssetStockRequest) -> AnyPublisher<GetAssetStockResponse, Error>
    func createAssetsStock(request: PostAssetStockRequest) -> AnyPublisher<PostAssetStockResponse, Error>
}

final class AssetStockRepositoryImpl: TMSApp.AssetStockRepository {
    private let provider: MoyaProvider<AssetStockAPI> = MoyaProvider<AssetStockAPI>()
    
    func getAssetsStock(request: GetAssetStockRequest) -> AnyPublisher<GetAssetStockResponse, Error> {
        return self.provider
            .cb
            .request(.getAssetStock(request: request))
            .map(GetAssetStockResponse.self)
    }
    
    func createAssetsStock(request: PostAssetStockRequest) -> AnyPublisher<PostAssetStockResponse, Error> {
        return self.provider
            .cb
            .request(.createAssetStock(request: request))
            .map(PostAssetStockResponse.self)
    }
}
