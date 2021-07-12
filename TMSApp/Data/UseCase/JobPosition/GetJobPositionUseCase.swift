//
//  GetJobPositionUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/8/21.
//

import Foundation
import Combine

protocol GetJobPositionUseCase {
    func execute() -> AnyPublisher<[JobPositionItems]?, Error>
}

struct GetJobPositionUseCaseImpl: GetJobPositionUseCase {
    
    private let repository: JobPositionRepository
    
    init(repository: JobPositionRepository = JobPositionRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[JobPositionItems]?, Error> {
        var request: GetJobPositionRequest = GetJobPositionRequest()
        request.compId = 1
        return repository
            .getJobPosition(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
