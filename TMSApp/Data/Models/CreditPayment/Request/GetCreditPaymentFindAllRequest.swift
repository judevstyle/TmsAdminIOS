//
//  GetCreditPaymentFindAllRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import Foundation

public struct GetCreditPaymentFindAllRequest: Codable, Hashable {
    
    public var orderId: Int?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
    }
}
