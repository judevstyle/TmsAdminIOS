//
//  GetOrderResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation
import UIKit

public struct GetOrderResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: OrderData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct OrderData: Codable, Hashable  {
    
    public var items: [OrderItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}


public struct OrderItems: Codable, Hashable  {
    
    public var orderId: Int?
    public var orderNo: String?
    public var orderShipingStatus: String?
    public var status: String?
    public var creditStatus: String?
    public var cusId: Int?
    public var credit: Int?
    public var balance: Double?
    public var cash: Double?
    public var shipmentId: Int?
    public var customerDisplayName: String?
    public var customerTypeUser: String?
    public var customerFname: String?
    public var customerLname: String?
    public var customerAddress: String?
    public var customerAvatar: String?
    public var totalItem: Int?
    public var totalPrice: Double?
    public var customer: CustomerItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try orderId              <- decoder["order_id"]
        try orderNo              <- decoder["order_no"]
        try orderShipingStatus   <- decoder["order_shiping_status"]
        try status               <- decoder["status"]
        try creditStatus         <- decoder["credit_status"]
        try cusId                <- decoder["cus_id"]
        try credit               <- decoder["credit"]
        try balance              <- decoder["balance"]
        try shipmentId           <- decoder["shipment_id"]
        try customerDisplayName  <- decoder["customer_display_name"]
        try customerTypeUser     <- decoder["customer_typeUser"]
        try customerFname        <- decoder["customer_fname"]
        try customerLname        <- decoder["customer_lname"]
        try customerAddress      <- decoder["customer_address"]
        try customerAvatar       <- decoder["customer_avatar"]
        try totalItem            <- decoder["total_item"]
        try totalPrice           <- decoder["total_price"]
        try customer             <- decoder["customer"]
    }
}
