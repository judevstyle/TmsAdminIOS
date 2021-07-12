//
//  PostEmployeeUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/8/21.
//

import Foundation
import Combine

protocol PostEmployeeUseCase {
    func execute(request: PostEmployeeRequest) -> AnyPublisher<PostEmployeeResponse?, Error>
}

struct PostEmployeeUseCaseImpl: PostEmployeeUseCase {
    
    private let repository: EmployeeRepository
    
    init(repository: EmployeeRepository = EmployeeRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostEmployeeRequest) -> AnyPublisher<PostEmployeeResponse?, Error> {
        return repository
            .createEmployee(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
