//
//  DeleteProductSpecialForTypeUserUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine

protocol DeleteProductSpecialForTypeUserUseCase {
    func execute(productSpcIid: Int) -> AnyPublisher<DeleteProductSpecialForTypeUserResponse?, Error>
}

struct DeleteProductSpecialForTypeUserUseCaseImpl: DeleteProductSpecialForTypeUserUseCase {
    
    private let repository: ProductSpecialForTypeUserRepository
    
    init(repository: ProductSpecialForTypeUserRepository = ProductSpecialForTypeUserRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(productSpcIid: Int) -> AnyPublisher<DeleteProductSpecialForTypeUserResponse?, Error> {
        return repository
            .deleteProductSpecialForTypeUser(productSpcIid: productSpcIid)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
