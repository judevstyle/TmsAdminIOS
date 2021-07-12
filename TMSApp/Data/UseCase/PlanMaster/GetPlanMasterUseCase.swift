//
//  GetPlanMasterUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/12/21.
//

import Foundation
import Combine

protocol GetPlanMasterUseCase {
    func execute() -> AnyPublisher<PlanMasterData?, Error>
}

struct GetPlanMasterUseCaseImpl: GetPlanMasterUseCase {
    
    private let repository: PlanMasterRepository
    
    init(repository: PlanMasterRepository = PlanMasterRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<PlanMasterData?, Error> {
        var request: GetPlanMasterRequest = GetPlanMasterRequest()
        request.compId = 1
        return repository
            .getPlanMaster(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
