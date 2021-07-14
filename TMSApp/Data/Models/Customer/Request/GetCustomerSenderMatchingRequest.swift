//
//  GetCustomerSenderMatchingRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation

public struct GetCustomerSenderMatchingRequest: Codable, Hashable {
    
    public var shipmentId: Int?
    public var displayName: String?
    public var limit: Int = 50
    public var page: Int = 1

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case shipmentId = "shipment_id"
        case displayName = "display_name"
        case limit = "limit"
        case page = "page"
    }
}
