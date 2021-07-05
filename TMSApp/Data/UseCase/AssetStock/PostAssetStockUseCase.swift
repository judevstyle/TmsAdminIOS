//
//  PostAssetStockUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Combine

protocol PostAssetStockUseCase {
    func execute(request: PostAssetStockRequest) -> AnyPublisher<PostAssetStockResponse?, Error>
}

struct PostAssetStockUseCaseImpl: PostAssetStockUseCase {
    
    private let repository: AssetStockRepository
    
    init(repository: AssetStockRepository = AssetStockRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostAssetStockRequest) -> AnyPublisher<PostAssetStockResponse?, Error> {
        return repository
            .createAssetsStock(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
