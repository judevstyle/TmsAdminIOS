//
//  AssetsRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 29/6/2564 BE.
//

import Foundation
import Combine
import Moya

protocol AssetsRepository {
    func getAssets(request: GetAssetsRequest) -> AnyPublisher<GetAssetsResponse, Error>
    func createAssets(request: PostAssetsRequest) -> AnyPublisher<PostAssetsResponse, Error>
}

final class AssetsRepositoryImpl: TMSApp.AssetsRepository {
    private let provider: MoyaProvider<AssetsAPI> = MoyaProvider<AssetsAPI>()
    
    func getAssets(request: GetAssetsRequest) -> AnyPublisher<GetAssetsResponse, Error> {
        return self.provider
            .cb
            .request(.getAssets(request: request))
            .map(GetAssetsResponse.self)
    }
    
    func createAssets(request: PostAssetsRequest) -> AnyPublisher<PostAssetsResponse, Error> {
        return self.provider
            .cb
            .request(.createAssets(request: request))
            .map(PostAssetsResponse.self)
    }
}
