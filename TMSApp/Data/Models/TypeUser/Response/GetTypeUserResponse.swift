//
//  GetTypeUserResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct GetTypeUserResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: [TypeUserData]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct TypeUserData: Codable, Hashable  {
    
    public var typeUserId: Int?
    public var compId: Int?
    public var typeName: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try typeUserId  <- decoder["type_user_id"]
        try compId       <- decoder["comp_id"]
        try typeName     <- decoder["type_name"]
    }
}

