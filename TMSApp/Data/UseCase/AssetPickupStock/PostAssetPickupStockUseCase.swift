//
//  PostAssetPickupStockUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Combine

protocol PostAssetPickupStockUseCase {
    func execute(request: PostAssetPickupStockRequest) -> AnyPublisher<PostAssetPickupStockResponse?, Error>
}

struct PostAssetPickupStockUseCaseImpl: PostAssetPickupStockUseCase {
    
    private let repository: AssetPickupStockRepository
    
    init(repository: AssetPickupStockRepository = AssetPickupStockRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostAssetPickupStockRequest) -> AnyPublisher<PostAssetPickupStockResponse?, Error> {
        return repository
            .createAssetPickupStock(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
