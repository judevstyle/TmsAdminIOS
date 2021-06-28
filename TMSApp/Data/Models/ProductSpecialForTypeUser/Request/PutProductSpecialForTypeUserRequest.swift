//
//  PutProductSpecialForTypeUserRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct PutProductSpecialForTypeUserRequest: Codable, Hashable {
    
    public var products: ProductSpecialForTypeUserRequest?
    public var typeUserId: Int?
    public var itemPrice: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
        case typeUserId = "type_user_id"
        case itemPrice = "item_price"
    }
}
