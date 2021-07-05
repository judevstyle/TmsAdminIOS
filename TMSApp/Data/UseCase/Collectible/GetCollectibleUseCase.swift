//
//  GetCollectibleUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/30/21.
//

import Foundation
import Combine

protocol GetCollectibleUseCase {
    func execute() -> AnyPublisher<CollectibleData?, Error>
}

struct GetCollectibleUseCaseImpl: GetCollectibleUseCase {
    
    private let repository: CollectibleRepository
    
    init(repository: CollectibleRepository = CollectibleRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<CollectibleData?, Error> {
        return repository
            .getCollectible()
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
