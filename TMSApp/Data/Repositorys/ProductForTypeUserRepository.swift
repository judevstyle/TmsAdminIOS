//
//  ProductForTypeUserRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine
import Moya

protocol ProductForTypeUserRepository {
    func getProductForTypeUser(request: GetProductForTypeUserRequest) -> AnyPublisher<GetProductForTypeUserResponse, Error>
}

final class ProductForTypeUserRepositoryImpl: TMSApp.ProductForTypeUserRepository {
    private let provider: MoyaProvider<ProductForTypeUserAPI> = MoyaProvider<ProductForTypeUserAPI>()
    
    func getProductForTypeUser(request: GetProductForTypeUserRequest) -> AnyPublisher<GetProductForTypeUserResponse, Error> {
        return self.provider
            .cb
            .request(.getProductForTypeUser(request: request))
            .map(GetProductForTypeUserResponse.self)
    }
}
