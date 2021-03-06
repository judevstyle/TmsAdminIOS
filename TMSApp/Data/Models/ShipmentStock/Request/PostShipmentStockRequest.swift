//
//  PostShipmentStockRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/18/21.
//

import Foundation

public struct PostShipmentStockRequest: Codable, Hashable {
    
    public var shipmentId: Int?
    public var data: [ShipmentStockData]?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case shipmentId = "shipment_id"
        case data = "data"
    }
}

public struct ShipmentStockData: Codable, Hashable {
    
    public var productId: Int?
    public var qty: Int?
    public var mark: Int?
    public var status: String?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case qty = "qty"
        case mark = "mark"
        case status = "status"
    }
}
