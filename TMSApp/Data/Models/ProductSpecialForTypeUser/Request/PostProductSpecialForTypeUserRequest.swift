//
//  PostProductSpecialForTypeUserRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct PostProductSpecialForTypeUserRequest: Codable, Hashable {
    
    public var products: [ProductSpecialForTypeUserRequest]?
    public var typeUserId: Int?
    public var itemPrice: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
        case typeUserId = "type_user_id"
        case itemPrice = "item_price"
    }
}

public struct ProductSpecialForTypeUserRequest: Codable, Hashable {
    
    public var product_id: Int?
    public var del: Int = 0
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case product_id = "product_id"
        case del = "del"
    }
}
