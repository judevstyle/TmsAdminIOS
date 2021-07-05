//
//  GetAssetPickupStockResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation

public struct GetAssetPickupStockResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: AssetPickupStockData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct AssetPickupStockData: Codable, Hashable  {
    
    public var items: [AssetPickupStockItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct AssetPickupStockItems: Codable, Hashable  {
    
    public var astPkId: Int?
    public var astId: Int?
    public var quantity: Int?
    public var note: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try astPkId    <- decoder["ast_pk_id"]
        try astId       <- decoder["ast_id"]
        try quantity    <- decoder["quantity"]
        try note        <- decoder["note"]
    }
}
