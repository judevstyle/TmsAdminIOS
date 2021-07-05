//
//  GetAssetStockUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Combine

protocol GetAssetStockUseCase {
    func execute(astId: Int?) -> AnyPublisher<AssetStockData?, Error>
}

struct GetAssetStockUseCaseImpl: GetAssetStockUseCase {
    
    private let repository: AssetStockRepository
    
    init(repository: AssetStockRepository = AssetStockRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(astId: Int?) -> AnyPublisher<AssetStockData?, Error> {
        var request = GetAssetStockRequest()
        request.astId = astId
        return repository
            .getAssetsStock(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
