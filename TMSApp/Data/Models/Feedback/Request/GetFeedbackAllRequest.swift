//
//  GetFeedbackAllRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/2/21.
//

import Foundation

public struct GetFeedbackAllRequest: Codable, Hashable {
    
    public var orderId: Int?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
    }
}
