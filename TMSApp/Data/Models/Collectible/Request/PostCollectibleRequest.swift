//
//  PostCollectibleRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/30/21.
//

import Foundation

public struct PostCollectibleRequest: Codable, Hashable {
    
    public var compId: Int?
    public var clbTitle: String?
    public var clbDescript: String?
    public var qty: String?
    public var clbImg: CollectibleImgRequest?
    public var rewardPoint: Int?
    public var campaignStartDate: String?
    public var campaignEndDate: String?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
        case clbTitle = "clb_title"
        case clbDescript = "clb_descript"
        case qty = "qty"
        case clbImg = "clb_img"
        case rewardPoint = "reward_point"
        case campaignStartDate = "campaign_start_date"
        case campaignEndDate = "campaign_end_date"
    }
}

public struct CollectibleImgRequest: Codable, Hashable {
    
    public var url: String?
    public var del: Int = 0
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case del = "del"
    }
}
