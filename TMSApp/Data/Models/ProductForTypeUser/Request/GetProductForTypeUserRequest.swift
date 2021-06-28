//
//  GetProductForTypeUserRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct GetProductForTypeUserRequest: Codable, Hashable {
    
    public var typeUserId: Int?
    public var compId: Int?
    public var productTypeId: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case typeUserId = "type_user_id"
        case compId = "comp_id"
        case productTypeId = "product_type_id"
    }
}
