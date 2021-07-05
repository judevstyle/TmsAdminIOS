//
//  PostAssetsUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Combine

protocol PostAssetsUseCase {
    func execute(request: PostAssetsRequest) -> AnyPublisher<PostAssetsResponse?, Error>
}

struct PostAssetsUseCaseImpl: PostAssetsUseCase {
    
    private let repository: AssetsRepository
    
    init(repository: AssetsRepository = AssetsRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: PostAssetsRequest) -> AnyPublisher<PostAssetsResponse?, Error> {
        return repository
            .createAssets(request: request)
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
