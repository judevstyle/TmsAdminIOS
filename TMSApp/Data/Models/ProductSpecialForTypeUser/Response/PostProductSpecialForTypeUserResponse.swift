//
//  PostProductSpecialForTypeUserResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct PostProductSpecialForTypeUserResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
//    public var data: ProductSpecialForTypeUserData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
//        try data          <- decoder["data"]
    }
}
