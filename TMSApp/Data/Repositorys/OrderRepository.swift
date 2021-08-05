//
//  OrderRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation
import Combine
import Moya

protocol OrderRepository {
    func getOrder(request: GetOrderRequest) -> AnyPublisher<GetOrderResponse, Error>
    func getOrderCart(orderId: Int?) -> AnyPublisher<GetOrderCartResponse, Error>
    func confirmOrderCart(orderId: Int?) -> AnyPublisher<GetOrderCartResponse, Error>
}

final class OrderRepositoryImpl: TMSApp.OrderRepository {
    private let orderAPI: MoyaProvider<OrderAPI> = MoyaProvider<OrderAPI>()

    func getOrder(request: GetOrderRequest) -> AnyPublisher<GetOrderResponse, Error> {
        return self.orderAPI
            .cb
            .request(.getOrder(request: request))
            .map(GetOrderResponse.self)
    }
    
    func getOrderCart(orderId: Int?) -> AnyPublisher<GetOrderCartResponse, Error> {
        return self.orderAPI
            .cb
            .request(.getOrderCart(orderId: orderId))
            .map(GetOrderCartResponse.self)
    }
    
    func confirmOrderCart(orderId: Int?) -> AnyPublisher<GetOrderCartResponse, Error> {
        return self.orderAPI
            .cb
            .request(.confirmOrderCart(orderId: orderId))
            .map(GetOrderCartResponse.self)
    }
    
}
