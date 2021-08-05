//
//  GetCreditPaymentFindAllResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import Foundation

public struct GetCreditPaymentFindAllResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: [CreditPaymentItems]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct CreditPaymentItems: Codable, Hashable  {
    
    public var cpId: Int?
    public var orderId: Int?
    public var balance: Int?
    public var remark: String?
    public var createDate: Date?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try cpId           <- decoder["cp_id"]
        try orderId         <- decoder["order_id"]
        try balance         <- decoder["balance"]
        try remark          <- decoder["remark"]
        try createDate     <- decoder["create_date"]
    }
}
