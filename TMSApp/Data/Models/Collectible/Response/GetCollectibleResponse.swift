//
//  GetCollectibleResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/30/21.
//

import Foundation

public struct GetCollectibleResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: CollectibleData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct CollectibleData: Codable, Hashable  {
    
    public var items: [CollectibleItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct CollectibleItems: Codable, Hashable  {
    
    public var clbId: Int?
    public var compId: Int?
    public var clbTitle: String?
    public var clbDescript: String?
    public var qty: Int?
    public var clbImg: String?
    public var rewardPoint: Int?
    public var campaignStartDate: String?
    public var campaignEndDate: String?
    public var totalReward: Int?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try clbId               <- decoder["clb_id"]
        try compId              <- decoder["comp_id"]
        try clbTitle            <- decoder["clb_title"]
        try clbDescript         <- decoder["clb_descript"]
        try qty                 <- decoder["qty"]
        try clbImg              <- decoder["clb_img"]
        try rewardPoint         <- decoder["reward_point"]
        try campaignStartDate   <- decoder["campaign_start_date"]
        try campaignEndDate     <- decoder["campaign_end_date"]
        try totalReward         <- decoder["total_reward"]
    }
}
