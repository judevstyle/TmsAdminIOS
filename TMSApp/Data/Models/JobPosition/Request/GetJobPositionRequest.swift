//
//  GetJobPositionRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/8/21.
//

import Foundation

public struct GetJobPositionRequest: Codable, Hashable {
    
    public var compId: Int?
    public var limit: Int?
    public var page: Int?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
        case limit = "limit"
        case page = "page"
    }
}
