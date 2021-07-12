//
//  GetPlanMasterDetailUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/12/21.
//

import Foundation
import Combine

protocol GetPlanMasterDetailUseCase {
    func execute(planId: Int) -> AnyPublisher<GetPlanMasterDetailResponse?, Error>
}

struct GetPlanMasterDetailUseCaseImpl: GetPlanMasterDetailUseCase {
    
    private let repository: PlanMasterRepository
    
    init(repository: PlanMasterRepository = PlanMasterRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(planId: Int) -> AnyPublisher<GetPlanMasterDetailResponse?, Error> {
        return repository
            .getPlanMasterDetail(planId: planId)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
