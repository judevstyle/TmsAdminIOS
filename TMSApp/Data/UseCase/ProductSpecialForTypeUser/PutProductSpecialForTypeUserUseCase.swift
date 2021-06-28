//
//  PutProductSpecialForTypeUserUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine

protocol PutProductSpecialForTypeUserUseCase {
    func execute(request: PutProductSpecialForTypeUserRequest, productSpcIid: Int) -> AnyPublisher<PutProductSpecialForTypeUserResponse?, Error>
}

struct PutProductSpecialForTypeUserUseCaseImpl: PutProductSpecialForTypeUserUseCase {
    
    private let repository: ProductSpecialForTypeUserRepository
    
    init(repository: ProductSpecialForTypeUserRepository = ProductSpecialForTypeUserRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PutProductSpecialForTypeUserRequest, productSpcIid: Int) -> AnyPublisher<PutProductSpecialForTypeUserResponse?, Error> {
        return repository
            .updateProductSpecialForTypeUser(request: request, productSpcIid: productSpcIid)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
