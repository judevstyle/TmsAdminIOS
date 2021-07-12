//
//  PostAuthEmployeeResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation

public struct PostAuthEmployeeResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: AuthEmployeeData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct AuthEmployeeData: Codable, Hashable  {
    
    public var accessToken: String?
    public var expire: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try accessToken     <- decoder["access_token"]
        try expire          <- decoder["expire"]
    }
}
