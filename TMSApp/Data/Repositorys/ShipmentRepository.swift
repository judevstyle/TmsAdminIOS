//
//  ShipmentRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import Combine
import Moya

protocol ShipmentRepository {
    func getShipment(request: GetShipmentRequest) -> AnyPublisher<GetShipmentResponse, Error>
    func getShipmentWorking(request: GetShipmentWorkingRequest) -> AnyPublisher<GetShipmentWorkingResponse, Error>
    func getShipmentCustomer(shipmentId: Int) -> AnyPublisher<GetShipmentCustomerResponse, Error>
    func updateShipment(shipmentId: Int, request: PutShipmentRequest) -> AnyPublisher<PutShipmentResponse, Error>
}

final class ShipmentRepositoryImpl: TMSApp.ShipmentRepository {
    private let shipmentAPI: MoyaProvider<ShipmentAPI> = MoyaProvider<ShipmentAPI>()
    
    func getShipment(request: GetShipmentRequest) -> AnyPublisher<GetShipmentResponse, Error> {
        return self.shipmentAPI
            .cb
            .request(.getShipment(request: request))
            .map(GetShipmentResponse.self)
    }
    
    func getShipmentWorking(request: GetShipmentWorkingRequest) -> AnyPublisher<GetShipmentWorkingResponse, Error> {
        return self.shipmentAPI
            .cb
            .request(.getShipmentWorking(request: request))
            .map(GetShipmentWorkingResponse.self)
    }
    
    func getShipmentCustomer(shipmentId: Int) -> AnyPublisher<GetShipmentCustomerResponse, Error> {
        return self.shipmentAPI
            .cb
            .request(.getShipmentCustomer(shipmentId: shipmentId))
            .map(GetShipmentCustomerResponse.self)
    }
    
    func updateShipment(shipmentId: Int, request: PutShipmentRequest) -> AnyPublisher<PutShipmentResponse, Error> {
        return self.shipmentAPI
            .cb
            .request(.updateShipment(shipmentId: shipmentId, request: request))
            .map(PutShipmentResponse.self)
    }
}
