//
//  PutShipmentUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/15/21.
//

import Foundation

import Foundation
import Combine

protocol PutShipmentUseCase {
    func execute(shipmentId: Int, request: PutShipmentRequest) -> AnyPublisher<PutShipmentResponse, Error>
}

struct PutShipmentUseCaseImpl: PutShipmentUseCase {
    
    private let shipmentRepository: ShipmentRepository
    
    init(shipmentRepository: ShipmentRepository = ShipmentRepositoryImpl()) {
        self.shipmentRepository = shipmentRepository
    }
    
    func execute(shipmentId: Int, request: PutShipmentRequest) -> AnyPublisher<PutShipmentResponse, Error> {
        return shipmentRepository
            .updateShipment(shipmentId: shipmentId, request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
