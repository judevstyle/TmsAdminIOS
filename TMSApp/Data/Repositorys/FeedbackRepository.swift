//
//  FeedbackRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/2/21.
//

import Foundation
import Combine
import Moya

protocol FeedbackRepository {
    func getFeedbackAll(request: GetFeedbackAllRequest) -> AnyPublisher<GetFeedbackAllResponse, Error>
    func getFeedbackOne(request: GetFeedbackOneRequest) -> AnyPublisher<GetFeedbackOneResponse, Error>
}

final class FeedbackRepositoryImpl: TMSApp.FeedbackRepository {
    private let provider: MoyaProvider<FeedbackAPI> = MoyaProvider<FeedbackAPI>()
    
    func getFeedbackAll(request: GetFeedbackAllRequest) -> AnyPublisher<GetFeedbackAllResponse, Error> {
        return self.provider
            .cb
            .request(.getFeedbackAll(request: request))
            .map(GetFeedbackAllResponse.self)
    }
    
    func getFeedbackOne(request: GetFeedbackOneRequest) -> AnyPublisher<GetFeedbackOneResponse, Error> {
        return self.provider
            .cb
            .request(.getFeedbackOne(request: request))
            .map(GetFeedbackOneResponse.self)
    }
}
