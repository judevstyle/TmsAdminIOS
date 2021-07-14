//
//  GetCustomerSenderMatchingUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation
import Combine

protocol GetCustomerSenderMatchingUseCase {
    func execute(request: GetCustomerSenderMatchingRequest) -> AnyPublisher<CustomerData?, Error>
}

struct GetCustomerSenderMatchingUseCaseImpl: GetCustomerSenderMatchingUseCase {
    
    private let repository: CustomerRepository
    
    init(repository: CustomerRepository = CustomerRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: GetCustomerSenderMatchingRequest) -> AnyPublisher<CustomerData?, Error> {
        return repository
            .getCustomerSenderMatching(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
