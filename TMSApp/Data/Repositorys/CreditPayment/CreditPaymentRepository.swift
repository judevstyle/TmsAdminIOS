//
//  CreditPaymentRepository.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import Foundation
import Combine
import Moya

protocol CreditPaymentRepository {
    func getCreditPaymentFindAll(request: GetCreditPaymentFindAllRequest) -> AnyPublisher<GetCreditPaymentFindAllResponse, Error>
}

final class CreditPaymentRepositoryImpl: TMSApp.CreditPaymentRepository {
    private let provider: MoyaProvider<CreditPaymentAPI> = MoyaProvider<CreditPaymentAPI>()
    
    func getCreditPaymentFindAll(request: GetCreditPaymentFindAllRequest) -> AnyPublisher<GetCreditPaymentFindAllResponse, Error> {
        return self.provider
            .cb
            .request(.getCreditPaymentFindAll(request: request))
            .map(GetCreditPaymentFindAllResponse.self)
    }
}
