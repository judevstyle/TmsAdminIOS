//
//  GetPlanMasterDetailResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/12/21.
//

import Foundation

public struct GetPlanMasterDetailResponse: Codable, Hashable  {
    
    public var statusCode: Int?
    public var success: Bool = false
    public var data: PlanMasterItems?
    
    public init() {}
    
    public init(from decoder: Decoder) throws {
        try statusCode    <- decoder["statusCode"]
        try success       <- decoder["success"]
        try data          <- decoder["data"]
    }
}
