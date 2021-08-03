//
//  GetFeedbackAllUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/2/21.
//

import Foundation
import Combine

protocol GetFeedbackAllUseCase {
    func execute() -> AnyPublisher<FeedbackData?, Error>
}

struct GetFeedbackAllUseCaseImpl: GetFeedbackAllUseCase {
    
    private let repository: FeedbackRepository
    
    init(repository: FeedbackRepository = FeedbackRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<FeedbackData?, Error> {
        return repository
            .getFeedbackAll(request: GetFeedbackAllRequest())
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
