//
//  PostAuthEmployeeUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation
import Combine

protocol PostAuthEmployeeUseCase {
    func execute(request: PostAuthEmployeeRequest) -> AnyPublisher<PostAuthEmployeeResponse?, Error>
    func executeLogout() -> AnyPublisher<PostAuthEmployeeResponse?, Error>
}

struct PostAuthEmployeeUseCaseImpl: PostAuthEmployeeUseCase {
    
    private let repository: AuthEmployeeRepository
    
    init(repository: AuthEmployeeRepository = AuthEmployeeRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostAuthEmployeeRequest) -> AnyPublisher<PostAuthEmployeeResponse?, Error> {
        return repository
            .authenticate(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
    
    func executeLogout() -> AnyPublisher<PostAuthEmployeeResponse?, Error> {
        return repository
            .logout()
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
