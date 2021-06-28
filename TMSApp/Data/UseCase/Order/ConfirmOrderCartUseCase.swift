//
//  ConfirmOrderCartUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine

protocol ConfirmOrderCartUseCase {
    func execute(orderId: String) -> AnyPublisher<GetOrderCartResponse?, Error>
}

struct ConfirmOrderCartUseCaseImpl: ConfirmOrderCartUseCase {
    
    private let orderRepository: OrderRepository
    
    init(orderRepository: OrderRepository = OrderRepositoryImpl()) {
        self.orderRepository = orderRepository
    }
    
    func execute(orderId: String) -> AnyPublisher<GetOrderCartResponse?, Error> {
        return orderRepository
            .confirmOrderCart(orderId: orderId)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
