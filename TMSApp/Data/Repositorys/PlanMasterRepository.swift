//
//  PlanMasterRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/11/21.
//

import Foundation
import Combine
import Moya

protocol PlanMasterRepository {
    func getPlanMaster(request: GetPlanMasterRequest) -> AnyPublisher<GetPlanMasterResponse, Error>
    func getPlanMasterDetail(planId: Int) -> AnyPublisher<GetPlanMasterDetailResponse, Error>
    func createPlanMaster(request: PostPlanMasterRequest) -> AnyPublisher<PostPlanMasterResponse, Error>
}

final class PlanMasterRepositoryImpl: TMSApp.PlanMasterRepository {
    private let provider: MoyaProvider<PlanMasterAPI> = MoyaProvider<PlanMasterAPI>()
    
    func getPlanMaster(request: GetPlanMasterRequest) -> AnyPublisher<GetPlanMasterResponse, Error> {
        return self.provider
            .cb
            .request(.getPlanMaster(request: request))
            .map(GetPlanMasterResponse.self)
    }
    
    func getPlanMasterDetail(planId: Int) -> AnyPublisher<GetPlanMasterDetailResponse, Error> {
        return self.provider
            .cb
            .request(.getPlanMasterDetail(planId: planId))
            .map(GetPlanMasterDetailResponse.self)
    }
    
    func createPlanMaster(request: PostPlanMasterRequest) -> AnyPublisher<PostPlanMasterResponse, Error> {
        return self.provider
            .cb
            .request(.createPlanMaster(request: request))
            .map(PostPlanMasterResponse.self)
    }
}
