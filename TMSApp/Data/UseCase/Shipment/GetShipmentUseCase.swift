//
//  GetShipmentUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation
import Combine

protocol GetShipmentUseCase {
    func execute() -> AnyPublisher<GetShipmentResponse?, Error>
}

struct GetShipmentUseCaseImpl: GetShipmentUseCase {
    
    private let shipmentRepository: ShipmentRepository
    
    init(shipmentRepository: ShipmentRepository = ShipmentRepositoryImpl()) {
        self.shipmentRepository = shipmentRepository
    }
    
    func execute() -> AnyPublisher<GetShipmentResponse?, Error> {
        var request = GetShipmentRequest()
        request.compId = 1
        request.status = 1
        return shipmentRepository
            .getShipment(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
