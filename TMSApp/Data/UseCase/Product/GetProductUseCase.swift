//
//  GetProductUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 28/6/2564 BE.
//

import Foundation
import Combine

protocol GetProductUseCase {
    func execute() -> AnyPublisher<ProductData?, Error>
}

struct GetProductUseCaseImpl: GetProductUseCase {
    
    private let repository: ProductRepository
    
    init(repository: ProductRepository = ProductRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<ProductData?, Error> {
        var request = GetProductRequest()
        request.compId = 1
        return self.repository
            .getProduct(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
