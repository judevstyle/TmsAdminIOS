//
//  GetProductSpecialForTypeUserUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine

protocol GetProductSpecialForTypeUserUseCase {
    func execute(typeUserId: Int) -> AnyPublisher<ProductSpecialForTypeUserData?, Error>
}

struct GetProductSpecialForTypeUserUseCaseImpl: GetProductSpecialForTypeUserUseCase {
    
    private let repository: ProductSpecialForTypeUserRepository
    
    init(repository: ProductSpecialForTypeUserRepository = ProductSpecialForTypeUserRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(typeUserId: Int) -> AnyPublisher<ProductSpecialForTypeUserData?, Error> {
        var request = GetProductSpecialForTypeUserRequest()
        request.typeUserId = typeUserId
        return repository
            .getProductSpecialForTypeUser(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
        
    }
}
