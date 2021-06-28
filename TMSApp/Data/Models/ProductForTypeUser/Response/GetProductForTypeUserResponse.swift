//
//  GetProductForTypeUserResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
public struct GetProductForTypeUserResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: ProductForTypeUserData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct ProductForTypeUserData: Codable, Hashable  {
    
    public var items: [Product]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}
