//
//  GetOrderCartResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct GetOrderCartResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: OrderCartData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct OrderCartData: Codable, Hashable  {
    
    public var orderId: Int?
    public var cusId: Int?
    public var shipmentId: Int?
    public var orderNo: String?
    public var status: String?
    public var statusRemark: String?
    public var seqOrderNo: Int?
    public var orderShipingStatus: String?
    public var note: String?
    public var balance: Double = 0
    public var orderD: [OrderCartD]?
    public var customer: CustomerItems?

//     "a_sign": null,
//     "order_shiping_status": "N",
//     "note": "note",
//     "balance": null,
//     "credit": null,
//     "cash": null,
//     "credit_status": null,
//     "send_date_stamp": null,

    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try orderId             <- decoder["order_id"]
        try cusId               <- decoder["cus_id"]
        try shipmentId          <- decoder["shipment_id"]
        try orderNo             <- decoder["order_no"]
        try status              <- decoder["status"]
        try statusRemark        <- decoder["status_remark"]
        try seqOrderNo          <- decoder["seq_order_no"]
        try orderShipingStatus  <- decoder["order_shiping_status"]
        try note                <- decoder["note"]
        try balance             <- decoder["balance"]
        try orderD              <- decoder["orderD"]
        try customer            <- decoder["customer"]
    }
}

public struct OrderCartD: Codable, Hashable  {
    
    public var order_d_id: Int?
    public var order_id: Int?
    public var product_id: Int?
    public var price: Int?
    public var qty: Int?
    public var product: Product?

    public init() {}
    
    public init(from decoder: Decoder) throws {
        try order_d_id   <- decoder["order_d_id"]
        try order_id     <- decoder["order_id"]
        try product_id   <- decoder["product_id"]
        try price        <- decoder["price"]
        try qty          <- decoder["qty"]
        try product      <- decoder["product"]
    }
}
