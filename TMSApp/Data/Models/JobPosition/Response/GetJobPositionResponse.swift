//
//  GetJobPositionResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/8/21.
//

import Foundation

public struct GetJobPositionResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: [JobPositionItems]?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}

public struct JobPositionItems: Codable, Hashable  {
    
    public var jobPositionId: Int?
    public var compId: Int?
    public var jobPositionName: String?
    public var company: CompanyItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try jobPositionId   <- decoder["job_position_id"]
        try compId          <- decoder["comp_id"]
        try jobPositionName <- decoder["job_position_name"]
        try company         <- decoder["company"]
    }
    
}


