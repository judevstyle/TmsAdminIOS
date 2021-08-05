//
//  GetOrderUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation
import Combine

protocol GetOrderUseCase {
    func execute(request: GetOrderRequest) -> AnyPublisher<GetOrderResponse?, Error>
}

struct GetOrderUseCaseImpl: GetOrderUseCase {
    
    private let orderRepository: OrderRepository
    
    init(orderRepository: OrderRepository = OrderRepositoryImpl()) {
        self.orderRepository = orderRepository
    }
    
    func execute(request: GetOrderRequest) -> AnyPublisher<GetOrderResponse?, Error> {
        return orderRepository
            .getOrder(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
