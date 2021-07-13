//
//  ShipmentStockRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation
import Combine
import Moya

protocol ShipmentStockRepository {
    func getShipmentStock(request: GetShipmentStockRequest) -> AnyPublisher<GetShipmentStockResponse, Error>
}

final class ShipmentStockRepositoryImpl: TMSApp.ShipmentStockRepository {
    private let provider: MoyaProvider<ShipmentStockAPI> = MoyaProvider<ShipmentStockAPI>()
    
    func getShipmentStock(request: GetShipmentStockRequest) -> AnyPublisher<GetShipmentStockResponse, Error> {
        return self.provider
            .cb
            .request(.getShipmentStock(request: request))
            .map(GetShipmentStockResponse.self)
    }
}
