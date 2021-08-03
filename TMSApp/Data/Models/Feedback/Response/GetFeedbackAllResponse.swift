//
//  GetFeedbackAllResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/2/21.
//

import Foundation

public struct GetFeedbackAllResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: FeedbackData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct FeedbackData: Codable, Hashable  {
    
    public var items: [FeedbackItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct FeedbackItems: Codable, Hashable  {
    
    public var feedId: Int?
    public var orderId: Int?
    public var rate: String?
    public var comment: String?
    public var status: String?
    public var statusRemark: String?
    public var feedbackAttachs: String?
    
    public var order: OrderItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try feedId          <- decoder["feed_id"]
        try orderId         <- decoder["order_id"]
        try rate            <- decoder["rate"]
        try comment         <- decoder["comment"]
        try status          <- decoder["status"]
        try statusRemark    <- decoder["status_remark"]
        try feedbackAttachs <- decoder["feedbackAttachs"]
        try order           <- decoder["order"]
    }
}
