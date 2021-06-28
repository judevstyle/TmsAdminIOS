//
//  PostProductSpecialForTypeUserUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine

protocol PostProductSpecialForTypeUserUseCase {
    func execute(request: PostProductSpecialForTypeUserRequest) -> AnyPublisher<PostProductSpecialForTypeUserResponse?, Error>
}

struct PostProductSpecialForTypeUserUseCaseImpl: PostProductSpecialForTypeUserUseCase {
    
    private let repository: ProductSpecialForTypeUserRepository
    
    init(repository: ProductSpecialForTypeUserRepository = ProductSpecialForTypeUserRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostProductSpecialForTypeUserRequest) -> AnyPublisher<PostProductSpecialForTypeUserResponse?, Error> {
        return repository
            .createProductSpecialForTypeUser(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
