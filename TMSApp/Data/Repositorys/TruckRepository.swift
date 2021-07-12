//
//  TruckRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/9/21.
//

import Foundation
import Combine
import Moya

protocol TruckRepository {
    func getTruck(request: GetTruckRequest) -> AnyPublisher<GetTruckResponse, Error>
    func createTruck(request: PostTruckRequest) -> AnyPublisher<PostTruckResponse, Error>
}

final class TruckRepositoryImpl: TMSApp.TruckRepository {
    private let provider: MoyaProvider<TruckAPI> = MoyaProvider<TruckAPI>()
    
    func getTruck(request: GetTruckRequest) -> AnyPublisher<GetTruckResponse, Error> {
        return self.provider
            .cb
            .request(.getTruck(request: request))
            .map(GetTruckResponse.self)
    }
    
    func createTruck(request: PostTruckRequest) -> AnyPublisher<PostTruckResponse, Error> {
        return self.provider
            .cb
            .request(.createTruck(request: request))
            .map(PostTruckResponse.self)
    }
}
