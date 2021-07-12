//
//  EmployeeRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation
import Combine
import Moya

protocol EmployeeRepository {
    func getEmployee(request: GetEmployeeRequest) -> AnyPublisher<GetEmployeeResponse, Error>
    func createEmployee(request: PostEmployeeRequest) -> AnyPublisher<PostEmployeeResponse, Error>
}

final class EmployeeRepositoryImpl: TMSApp.EmployeeRepository {
    private let provider: MoyaProvider<EmployeeAPI> = MoyaProvider<EmployeeAPI>()
    
    func getEmployee(request: GetEmployeeRequest) -> AnyPublisher<GetEmployeeResponse, Error> {
        return self.provider
            .cb
            .request(.getEmployee(request: request))
            .map(GetEmployeeResponse.self)
    }
    
    func createEmployee(request: PostEmployeeRequest) -> AnyPublisher<PostEmployeeResponse, Error> {
        return self.provider
            .cb
            .request(.createEmployee(request: request))
            .map(PostEmployeeResponse.self)
    }
}
