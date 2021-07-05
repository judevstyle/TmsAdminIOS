//
//  PostAssetStockResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation

public struct PostAssetStockResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: AssetStockItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

