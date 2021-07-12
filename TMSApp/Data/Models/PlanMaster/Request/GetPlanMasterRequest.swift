//
//  GetPlanMasterRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/11/21.
//

import Foundation

public struct GetPlanMasterRequest: Codable, Hashable {
    
    public var compId: Int?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
    }
}
