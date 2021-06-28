//
//  GetOrderUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation
import Combine

protocol GetOrderUseCase {
    func execute() -> AnyPublisher<GetOrderResponse?, Error>
}

struct GetOrderUseCaseImpl: GetOrderUseCase {
    
    private let orderRepository: OrderRepository
    
    init(orderRepository: OrderRepository = OrderRepositoryImpl()) {
        self.orderRepository = orderRepository
    }
    
    func execute() -> AnyPublisher<GetOrderResponse?, Error> {
        var request = GetOrderRequest()
        request.status = "R"
        request.page = 1
        return orderRepository
            .getOrder(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
