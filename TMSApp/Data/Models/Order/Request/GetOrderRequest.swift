//
//  GetOrderRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation

public struct GetOrderRequest: Codable, Hashable {
    
    public var orderId: Int?
    public var cusId: Int?
    public var shipmentId: Int?
    public var status: String = "R"
    public var orderShipingStatus: Int?
    public var creditStatus: Int?
    public var page: Int = 1
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case cusId = "cus_id"
        case shipmentId = "shipment_id"
        case status = "status"
        case orderShipingStatus = "order_shiping_status"
        case creditStatus = "credit_status"
        case page = "page"
    }
}
