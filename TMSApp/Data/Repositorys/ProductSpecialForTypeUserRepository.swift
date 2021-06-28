//
//  ProductSpecialForTypeUserRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine
import Moya

protocol ProductSpecialForTypeUserRepository {
    func getProductSpecialForTypeUser(request: GetProductSpecialForTypeUserRequest) -> AnyPublisher<GetProductSpecialForTypeUserResponse, Error>
    func createProductSpecialForTypeUser(request: PostProductSpecialForTypeUserRequest) -> AnyPublisher<PostProductSpecialForTypeUserResponse, Error>
    func updateProductSpecialForTypeUser(request: PutProductSpecialForTypeUserRequest, productSpcIid: Int) -> AnyPublisher<PutProductSpecialForTypeUserResponse, Error>
    func deleteProductSpecialForTypeUser(productSpcIid: Int) -> AnyPublisher<DeleteProductSpecialForTypeUserResponse, Error>
}

final class ProductSpecialForTypeUserRepositoryImpl: TMSApp.ProductSpecialForTypeUserRepository {
    private let provider: MoyaProvider<ProductSpecialForTypeUserAPI> = MoyaProvider<ProductSpecialForTypeUserAPI>()
    
    func getProductSpecialForTypeUser(request: GetProductSpecialForTypeUserRequest) -> AnyPublisher<GetProductSpecialForTypeUserResponse, Error> {
        return self.provider
            .cb
            .request(.getProductSpecialForTypeUser(request: request))
            .map(GetProductSpecialForTypeUserResponse.self)
    }
    
    func createProductSpecialForTypeUser(request: PostProductSpecialForTypeUserRequest) -> AnyPublisher<PostProductSpecialForTypeUserResponse, Error> {
        return self.provider
            .cb
            .request(.createProductSpecialForTypeUser(request: request))
            .map(PostProductSpecialForTypeUserResponse.self)
    }
    
    func updateProductSpecialForTypeUser(request: PutProductSpecialForTypeUserRequest, productSpcIid: Int) -> AnyPublisher<PutProductSpecialForTypeUserResponse, Error> {
        return self.provider
            .cb
            .request(.updateProductSpecialForTypeUser(request: request, productSpcIid: productSpcIid))
            .map(PutProductSpecialForTypeUserResponse.self)
    }
    
    func deleteProductSpecialForTypeUser(productSpcIid: Int) -> AnyPublisher<DeleteProductSpecialForTypeUserResponse, Error> {
        return self.provider
            .cb
            .request(.deleteProductSpecialForTypeUser(productSpcIid: productSpcIid))
            .map(DeleteProductSpecialForTypeUserResponse.self)
    }
}
