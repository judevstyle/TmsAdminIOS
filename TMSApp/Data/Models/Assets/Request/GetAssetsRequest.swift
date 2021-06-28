//
//  GetAssetsRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 29/6/2564 BE.
//

import Foundation

public struct GetAssetsRequest: Codable, Hashable {
    
    public var compId: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
    }
}


