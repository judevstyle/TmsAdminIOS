//
//  GetCustomerResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import Foundation

public struct GetCustomerResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: CustomerData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct CustomerData: Codable, Hashable  {
    
    public var items: [CustomerItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}

public struct CustomerItems: Codable, Hashable  {
    
    public var cusId: Int?
    public var tel: String?
    public var typeUserId: Int?
    public var compId: Int?
    public var displayName: String?
    public var fname: String?
    public var lname: String?
    public var address: String?
    public var lat: Double?
    public var lng: Double?
    public var avatar: String?
    public var typeUser: TypeUser?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try cusId         <- decoder["cus_id"]
        try tel           <- decoder["tel"]
        try typeUserId    <- decoder["type_user_id"]
        try compId        <- decoder["comp_id"]
        try displayName   <- decoder["display_name"]
        try fname         <- decoder["fname"]
        try lname         <- decoder["lname"]
        try address       <- decoder["address"]
        try lat           <- decoder["lat"]
        try lng           <- decoder["lng"]
        try avatar        <- decoder["avatar"]
        try typeUser      <- decoder["typeUser"]
    }
}
