//
//  GetShipmentStockRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation

public struct GetShipmentStockRequest: Codable, Hashable {
    
    public var shipmentId: Int?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case shipmentId = "shipment_id"
    }
}
