//
//  GetFeedbackOneUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/2/21.
//

import Foundation
import Combine

protocol GetFeedbackOneUseCase {
    func execute(request: GetFeedbackOneRequest) -> AnyPublisher<GetFeedbackOneResponse?, Error>
}

struct GetFeedbackOneUseCaseImpl: GetFeedbackOneUseCase {
    
    private let repository: FeedbackRepository
    
    init(repository: FeedbackRepository = FeedbackRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: GetFeedbackOneRequest) -> AnyPublisher<GetFeedbackOneResponse?, Error> {
        return repository
            .getFeedbackOne(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
