//
//  GetShipmentStockResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation

public struct GetShipmentStockResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: [ShipmentStockItems]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}


public struct ShipmentStockItems: Codable, Hashable  {
    
    public var shipmentStockId: Int?
    public var shipmentId: Int?
    public var productId: Int?
    public var qty: Int?
    public var status: String?
    public var mark: Int?
    public var balanceQty: Int?
    public var product: Product?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try shipmentStockId  <- decoder["shipment_stock_id"]
        try shipmentId       <- decoder["shipment_id"]
        try productId        <- decoder["product_id"]
        try qty              <- decoder["qty"]
        try status           <- decoder["status"]
        try mark             <- decoder["mark"]
        try balanceQty      <- decoder["balance_qty"]
        try product          <- decoder["product"]
    }
}
