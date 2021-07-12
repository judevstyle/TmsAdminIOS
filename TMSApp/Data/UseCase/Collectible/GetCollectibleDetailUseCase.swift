//
//  GetCollectibleDetailUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/5/21.
//

import Foundation
import Combine

protocol GetCollectibleDetailUseCase {
    func execute(clbId: Int) -> AnyPublisher<CollectibleItems?, Error>
}

struct GetCollectibleDetailUseCaseImpl: GetCollectibleDetailUseCase {
    
    private let repository: CollectibleRepository
    
    init(repository: CollectibleRepository = CollectibleRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(clbId: Int) -> AnyPublisher<CollectibleItems?, Error> {
        return repository
            .getCollectibleDetail(clbId: clbId)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
