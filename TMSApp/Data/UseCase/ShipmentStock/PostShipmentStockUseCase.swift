//
//  PostShipmentStockUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/18/21.
//

import Foundation
import Combine

protocol PostShipmentStockUseCase {
    func execute(request: PostShipmentStockRequest) -> AnyPublisher<PostShipmentStockResponse?, Error>
}

struct PostShipmentStockUseCaseImpl: PostShipmentStockUseCase {
    
    private let repository: ShipmentStockRepository
    
    init(repository: ShipmentStockRepository = ShipmentStockRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostShipmentStockRequest) -> AnyPublisher<PostShipmentStockResponse?, Error> {
        return repository
            .postShipmentStock(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
