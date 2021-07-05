//
//  GetAssetStockResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation

public struct GetAssetStockResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: AssetStockData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct AssetStockData: Codable, Hashable  {
    
    public var items: [AssetStockItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct AssetStockItems: Codable, Hashable  {
    
    public var astStkId: Int?
    public var astId: Int?
    public var quantity: Int?
    public var note: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try astStkId    <- decoder["ast_stk_id"]
        try astId       <- decoder["ast_id"]
        try quantity    <- decoder["quantity"]
        try note        <- decoder["note"]
    }
}
