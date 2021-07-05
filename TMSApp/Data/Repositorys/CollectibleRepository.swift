//
//  CollectibleRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/30/21.
//

import Foundation
import Combine
import Moya

protocol CollectibleRepository {
    func getCollectible() -> AnyPublisher<GetCollectibleResponse, Error>
    func createCollectible(request: PostCollectibleRequest) -> AnyPublisher<PostCollectibleResponse, Error>
}

final class CollectibleRepositoryImpl: TMSApp.CollectibleRepository {
    private let provider: MoyaProvider<CollectibleAPI> = MoyaProvider<CollectibleAPI>()
    
    func getCollectible() -> AnyPublisher<GetCollectibleResponse, Error> {
        return self.provider
            .cb
            .request(.getCollectible)
            .map(GetCollectibleResponse.self)
    }
    
    func createCollectible(request: PostCollectibleRequest) -> AnyPublisher<PostCollectibleResponse, Error> {
        return self.provider
            .cb
            .request(.createCollectible(request: request))
            .map(PostCollectibleResponse.self)
    }
}
