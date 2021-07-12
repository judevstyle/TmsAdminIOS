//
//  GetTruckUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/9/21.
//

import Foundation
import Combine

protocol GetTruckUseCase {
    func execute() -> AnyPublisher<TruckData?, Error>
}

struct GetTruckUseCaseImpl: GetTruckUseCase {
    
    private let repository: TruckRepository
    
    init(repository: TruckRepository = TruckRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<TruckData?, Error> {
        var request: GetTruckRequest = GetTruckRequest()
        request.compId = 1
        return repository
            .getTruck(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
