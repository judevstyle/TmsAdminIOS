//
//  GetCreditPaymentUseCase.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import Foundation
import Combine

protocol GetCreditPaymentUseCase {
    func execute(request: GetCreditPaymentFindAllRequest) -> AnyPublisher<[CreditPaymentItems]?, Error>
}

struct GetCreditPaymentUseCaseImpl: GetCreditPaymentUseCase {
    
    private let repository: CreditPaymentRepository
    
    init(repository: CreditPaymentRepository = CreditPaymentRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(request: GetCreditPaymentFindAllRequest) -> AnyPublisher<[CreditPaymentItems]?, Error> {
        return repository
            .getCreditPaymentFindAll(request: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
