//
//  GetAssetsUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 29/6/2564 BE.
//

import Foundation
import Combine

protocol GetAssetsUseCase {
    func execute() -> AnyPublisher<[AssetsItems]?, Error>
}

struct GetAssetsUseCaseImpl: GetAssetsUseCase {
    
    private let repository: AssetsRepository
    
    init(repository: AssetsRepository = AssetsRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[AssetsItems]?, Error> {
        var request = GetAssetsRequest()
        request.compId = 1
        return repository
            .getAssets(request: request)
            .map { $0.data?.items }
            .eraseToAnyPublisher()
    }
}
