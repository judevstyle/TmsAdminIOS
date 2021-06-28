//
//  GetProductSpecialForTypeUserResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct GetProductSpecialForTypeUserResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: ProductSpecialForTypeUserData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct ProductSpecialForTypeUserData: Codable, Hashable  {
    
    public var items: [ProductSpecialForTypeUserItems]?
    public var meta: MetaObject?
//    public var links: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct ProductSpecialForTypeUserItems: Codable, Hashable  {
    
    public var productSpcId: Int?
    public var typeUserId: Int?
    public var itemPrice: Int?
    public var product: Product?
    public var typeUser: TypeUser?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try productSpcId  <- decoder["product_spc_id"]
        try typeUserId    <- decoder["type_user_id"]
        try itemPrice     <- decoder["item_price"]
        try product       <- decoder["product"]
        try typeUser      <- decoder["typeUser"]
    }
}
