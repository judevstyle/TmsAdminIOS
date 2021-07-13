//
//  GetShipmentStockUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation
import Combine

protocol GetShipmentStockUseCase {
    func execute(request: GetShipmentStockRequest) -> AnyPublisher<[ShipmentStockItems]?, Error>
}

struct GetShipmentStockUseCaseImpl: GetShipmentStockUseCase {
    
    private let repository: ShipmentStockRepository
    
    init(repository: ShipmentStockRepository = ShipmentStockRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: GetShipmentStockRequest) -> AnyPublisher<[ShipmentStockItems]?, Error> {
        return repository
            .getShipmentStock(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
