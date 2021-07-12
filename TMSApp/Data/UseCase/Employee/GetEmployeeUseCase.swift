//
//  GetEmployeeUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation
import Combine

protocol GetEmployeeUseCase {
    func execute() -> AnyPublisher<[EmployeeItems]?, Error>
}

struct GetEmployeeUseCaseImpl: GetEmployeeUseCase {
    
    private let repository: EmployeeRepository
    
    init(repository: EmployeeRepository = EmployeeRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[EmployeeItems]?, Error> {
        var request: GetEmployeeRequest = GetEmployeeRequest()
        request.compId = 1
        return repository
            .getEmployee(request: request)
            .map { $0.data?.items }
            .eraseToAnyPublisher()
    }
}
