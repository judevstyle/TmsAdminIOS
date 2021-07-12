//
//  PostTruckUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/10/21.
//

import Foundation
import Combine

protocol PostTruckUseCase {
    func execute(request: PostTruckRequest) -> AnyPublisher<PostTruckResponse?, Error>
}

struct PostTruckUseCaseImpl: PostTruckUseCase {
    
    private let repository: TruckRepository
    
    init(repository: TruckRepository = TruckRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostTruckRequest) -> AnyPublisher<PostTruckResponse?, Error> {
        return repository
            .createTruck(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
