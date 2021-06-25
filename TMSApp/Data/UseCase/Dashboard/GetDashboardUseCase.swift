//
//  GetDashboardUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import Combine

protocol GetDashboardUseCase {
    func execute() -> AnyPublisher<DashboardData?, Error>
}

struct GetDashboardUseCaseImpl: GetDashboardUseCase {
    
    private let dashboardRepository: DashboardRepository
    
    init(dashboardRepository: DashboardRepository = DashboardRepositoryImpl()) {
        self.dashboardRepository = dashboardRepository
    }
    
    func execute() -> AnyPublisher<DashboardData?, Error> {
        var request = GetDashboardRequest()
        request.comp_id = 1
        return dashboardRepository
            .getDashboard(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
        
    }
}
