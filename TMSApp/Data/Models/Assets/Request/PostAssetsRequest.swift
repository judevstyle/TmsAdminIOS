//
//  PostAssetsRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation

public struct PostAssetsRequest: Codable, Hashable {
    
    public var compId: Int?
    public var assetName: String?
    public var assetImg: AssetsImgRequest?
    public var assetDesc: String?
    public var assetUnit: String?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
        case assetName = "asset_name"
        case assetImg = "asset_img"
        case assetDesc = "asset_desc"
        case assetUnit = "asset_unit"
    }
}

public struct  AssetsImgRequest: Codable, Hashable {
    
    public var url: String?
    public var del: Int = 0
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case del = "del"
    }
}
