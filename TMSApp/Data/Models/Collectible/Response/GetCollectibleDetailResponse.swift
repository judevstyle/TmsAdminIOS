//
//  GetCollectibleDetailResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/5/21.
//

import Foundation

public struct GetCollectibleDetailResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: CollectibleItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}
