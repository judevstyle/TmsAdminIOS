//
//  GetTypeUserUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine

protocol GetTypeUserUseCase {
    func execute() -> AnyPublisher<[TypeUserData]?, Error>
}

struct GetTypeUserUseCaseImpl: GetTypeUserUseCase {
    
    private let repository: TypeUserRepository
    
    init(repository: TypeUserRepository = TypeUserRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[TypeUserData]?, Error> {
        var request = GetTypeUserRequest()
        request.compId = 1
        return repository
            .getTypeUser(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
        
    }
}
