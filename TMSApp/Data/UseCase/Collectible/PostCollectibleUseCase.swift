//
//  PostCollectibleUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/30/21.
//

import Foundation
import Combine

protocol PostCollectibleUseCase {
    func execute(request: PostCollectibleRequest) -> AnyPublisher<PostCollectibleResponse?, Error>
}

struct PostCollectibleUseCaseImpl: PostCollectibleUseCase {
    
    private let repository: CollectibleRepository
    
    init(repository: CollectibleRepository = CollectibleRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostCollectibleRequest) -> AnyPublisher<PostCollectibleResponse?, Error> {
        return repository
            .createCollectible(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
