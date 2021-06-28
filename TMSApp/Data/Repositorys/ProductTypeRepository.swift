//
//  ProductTypeRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine
import Moya

protocol ProductTypeRepository {
    func getProductType() -> AnyPublisher<GetProductTypeResponse, Error>
}

final class ProductTypeRepositoryImpl: TMSApp.ProductTypeRepository {
    private let provider: MoyaProvider<ProductTypeAPI> = MoyaProvider<ProductTypeAPI>()
    
    func getProductType() -> AnyPublisher<GetProductTypeResponse, Error> {
        return self.provider
            .cb
            .request(.getProductType)
            .map(GetProductTypeResponse.self)
    }
}
