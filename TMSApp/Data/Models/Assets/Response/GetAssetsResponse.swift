//
//  GetAssetsResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 29/6/2564 BE.
//

import Foundation

public struct GetAssetsResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: AssetsData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct AssetsData: Codable, Hashable  {
    
    public var items: [AssetsItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct AssetsItems: Codable, Hashable  {
    
    public var astId: Int?
    public var compId: Int?
    public var assetName: String?
    public var assetImg: String?
    public var assetDesc: String?
    public var assetUnit: String?
    public var stockTotal: Int?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try astId      <- decoder["ast_id"]
        try compId     <- decoder["comp_id"]
        try assetName  <- decoder["asset_name"]
        try assetImg   <- decoder["asset_img"]
        try assetDesc  <- decoder["asset_desc"]
        try assetUnit  <- decoder["asset_unit"]
        try stockTotal <- decoder["stock_total"]
    }
}
