//
//  GetProductForTypeUserUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine

protocol GetProductForTypeUserUseCase {
    func execute(typeUserId: Int?, productTypeId: Int?) -> AnyPublisher<ProductForTypeUserData?, Error>
}

struct GetProductForTypeUserUseCaseImpl: GetProductForTypeUserUseCase {
    
    private let repository: ProductForTypeUserRepository
    
    init(repository: ProductForTypeUserRepository = ProductForTypeUserRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(typeUserId: Int?, productTypeId: Int?) -> AnyPublisher<ProductForTypeUserData?, Error> {
        var request = GetProductForTypeUserRequest()
        request.typeUserId = typeUserId
        request.compId = 1
        request.productTypeId = productTypeId
        return repository
            .getProductForTypeUser(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
