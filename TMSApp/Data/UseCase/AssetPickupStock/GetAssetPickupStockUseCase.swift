//
//  GetAssetPickupStockUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Combine

protocol GetAssetPickupStockUseCase {
    func execute(astId: Int?) -> AnyPublisher<AssetPickupStockData?, Error>
}

struct GetAssetPickupStockUseCaseImpl: GetAssetPickupStockUseCase {
    
    private let repository: AssetPickupStockRepository
    
    init(repository: AssetPickupStockRepository = AssetPickupStockRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(astId: Int?) -> AnyPublisher<AssetPickupStockData?, Error> {
        var request = GetAssetPickupStockRequest()
        request.astId = astId
        return repository
            .getAssetPickupStock(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
