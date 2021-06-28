//
//  TypeUserRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Combine
import Moya

protocol TypeUserRepository {
    func getTypeUser(request: GetTypeUserRequest) -> AnyPublisher<GetTypeUserResponse, Error>
}

final class TypeUserRepositoryImpl: TMSApp.TypeUserRepository {
    private let typeUserAPI: MoyaProvider<TypeUserAPI> = MoyaProvider<TypeUserAPI>()
    
    func getTypeUser(request: GetTypeUserRequest) -> AnyPublisher<GetTypeUserResponse, Error> {
        return self.typeUserAPI
            .cb
            .request(.getTypeUser(request: request))
            .map(GetTypeUserResponse.self)
    }
}
