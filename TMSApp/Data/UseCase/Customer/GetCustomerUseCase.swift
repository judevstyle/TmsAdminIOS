//
//  GetCustomerUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import Foundation
import Combine

protocol GetCustomerUseCase {
    func execute() -> AnyPublisher<CustomerData?, Error>
}

struct GetCustomerUseCaseImpl: GetCustomerUseCase {
    
    private let repository: CustomerRepository
    
    init(repository: CustomerRepository = CustomerRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<CustomerData?, Error> {
        var request: GetCustomerRequest = GetCustomerRequest()
        request.compId = 1
        return repository
            .getCustomer(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
