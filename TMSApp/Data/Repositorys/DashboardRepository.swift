//
//  DashboardRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import Combine
import Moya

protocol DashboardRepository {
    func getDashboard(request: GetDashboardRequest) -> AnyPublisher<GetDashboardResponse, Error>
}

final class DashboardRepositoryImpl: TMSApp.DashboardRepository {
    private let dashboardAPI: MoyaProvider<DashboardAPI> = MoyaProvider<DashboardAPI>()
    
    func getDashboard(request: GetDashboardRequest) -> AnyPublisher<GetDashboardResponse, Error> {
        return self.dashboardAPI
            .cb
            .request(.getDashboard(request: request))
            .map(GetDashboardResponse.self)
    }
}
