//
//  PostPlanMasterUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//
import Foundation
import Combine

protocol PostPlanMasterUseCase {
    func execute(request: PostPlanMasterRequest) -> AnyPublisher<PostPlanMasterResponse?, Error>
}

struct PostPlanMasterUseCaseImpl: PostPlanMasterUseCase {
    
    private let repository: PlanMasterRepository
    
    init(repository: PlanMasterRepository = PlanMasterRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostPlanMasterRequest) -> AnyPublisher<PostPlanMasterResponse?, Error> {
        return repository
            .createPlanMaster(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
