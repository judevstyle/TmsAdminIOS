//
//  GetShipmentWorkingUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import Combine

protocol GetShipmentWorkingUseCase {
    func execute() -> AnyPublisher<GetShipmentWorkingResponse?, Error>
}

struct GetShipmentWorkingUseCaseImpl: GetShipmentWorkingUseCase {
    
    private let shipmentRepository: ShipmentRepository
    
    init(shipmentRepository: ShipmentRepository = ShipmentRepositoryImpl()) {
        self.shipmentRepository = shipmentRepository
    }
    
    func execute() -> AnyPublisher<GetShipmentWorkingResponse?, Error> {
        var request = GetShipmentWorkingRequest()
        request.compId = 1
        return shipmentRepository
            .getShipmentWorking(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
