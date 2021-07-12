//
//  JobPositionRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/8/21.
//

import Foundation
import Combine
import Moya

protocol JobPositionRepository {
    func getJobPosition(request: GetJobPositionRequest) -> AnyPublisher<GetJobPositionResponse, Error>
}

final class JobPositionRepositoryImpl: TMSApp.JobPositionRepository {
    private let provider: MoyaProvider<JobPositionAPI> = MoyaProvider<JobPositionAPI>()
    
    func getJobPosition(request: GetJobPositionRequest) -> AnyPublisher<GetJobPositionResponse, Error> {
        return self.provider
            .cb
            .request(.getJobPosition(request: request))
            .map(GetJobPositionResponse.self)
    }
}
