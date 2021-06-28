//
//  GetOrderCartUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine

protocol GetOrderCartUseCase {
    func execute(orderId: String) -> AnyPublisher<GetOrderCartResponse?, Error>
}

struct GetOrderCartUseCaseImpl: GetOrderCartUseCase {
    
    private let orderRepository: OrderRepository
    
    init(orderRepository: OrderRepository = OrderRepositoryImpl()) {
        self.orderRepository = orderRepository
    }
    
    func execute(orderId: String) -> AnyPublisher<GetOrderCartResponse?, Error> {
        return orderRepository
            .getOrderCart(orderId: orderId)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
