//
//  AuthEmployeeRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation
import Combine
import Moya

protocol AuthEmployeeRepository {
    func authenticate(request: PostAuthEmployeeRequest) -> AnyPublisher<PostAuthEmployeeResponse, Error>
    func logout() -> AnyPublisher<PostAuthEmployeeResponse, Error>
}

final class AuthEmployeeRepositoryImpl: TMSApp.AuthEmployeeRepository {
    private let provider: MoyaProvider<AuthEmployeeAPI> = MoyaProvider<AuthEmployeeAPI>()

    func authenticate(request: PostAuthEmployeeRequest) -> AnyPublisher<PostAuthEmployeeResponse, Error> {
        return self.provider
            .cb
            .request(.authenticate(request: request))
            .map(PostAuthEmployeeResponse.self)
    }
    
    func logout() -> AnyPublisher<PostAuthEmployeeResponse, Error> {
        return self.provider
            .cb
            .request(.logout)
            .map(PostAuthEmployeeResponse.self)
    }
}
