//
//  GetShipmentCustomerUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation
import Combine

protocol GetShipmentCustomerUseCase {
    func execute(shipmentId: Int) -> AnyPublisher<GetShipmentCustomerResponse?, Error>
}

struct GetShipmentCustomerUseCaseImpl: GetShipmentCustomerUseCase {
    
    private let shipmentRepository: ShipmentRepository
    
    init(shipmentRepository: ShipmentRepository = ShipmentRepositoryImpl()) {
        self.shipmentRepository = shipmentRepository
    }
    
    func execute(shipmentId: Int) -> AnyPublisher<GetShipmentCustomerResponse?, Error> {
        return shipmentRepository
            .GetShipmentCustomer(shipmentId: shipmentId)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
