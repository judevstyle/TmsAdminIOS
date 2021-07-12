//
//  GetTruckResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/9/21.
//

import Foundation

public struct GetTruckResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: TruckData?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct TruckData: Codable, Hashable  {
    
    public var items: [TruckItems]?
    public var meta: MetaObject?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try items    <- decoder["items"]
        try meta     <- decoder["meta"]
    }
}


public struct TruckItems: Codable, Hashable  {
    
    public var truck_id: String?
    public var comp_id: Int?
    public var truck_comp_seq: Int?
    public var truck_title: String?
    public var truck_desc: String?
    public var truck_img: String?
    public var registration_number: String?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try truck_id                <- decoder["truck_id"]
        try comp_id                 <- decoder["comp_id"]
        try truck_comp_seq          <- decoder["truck_comp_seq"]
        try truck_title             <- decoder["truck_title"]
        try truck_desc              <- decoder["truck_desc"]
        try truck_img               <- decoder["truck_img"]
        try registration_number     <- decoder["registration_number"]
    }
}
