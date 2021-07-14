//
//  CustomerRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import Foundation
import Combine
import Moya

protocol CustomerRepository {
    func getCustomer(request: GetCustomerRequest) -> AnyPublisher<GetCustomerResponse, Error>
    func getCustomerSenderMatching(request: GetCustomerSenderMatchingRequest) -> AnyPublisher<GetCustomerSenderMatchingResponse, Error>
}

final class CustomerRepositoryImpl: TMSApp.CustomerRepository {
    private let provider: MoyaProvider<CustomerAPI> = MoyaProvider<CustomerAPI>()
    
    func getCustomer(request: GetCustomerRequest) -> AnyPublisher<GetCustomerResponse, Error> {
        return self.provider
            .cb
            .request(.getCustomer(request: request))
            .map(GetCustomerResponse.self)
    }
    
    func getCustomerSenderMatching(request: GetCustomerSenderMatchingRequest) -> AnyPublisher<GetCustomerSenderMatchingResponse, Error> {
        return self.provider
            .cb
            .request(.getCustomerSenderMatching(request: request))
            .map(GetCustomerSenderMatchingResponse.self)
    }
}
