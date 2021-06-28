//
//  GetProductSpecialForTypeUserRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct GetProductSpecialForTypeUserRequest: Codable, Hashable {
    
    public var typeUserId: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case typeUserId = "type_user_id"
    }
}
