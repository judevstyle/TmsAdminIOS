//
//  GetTypeUserRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation

public struct GetTypeUserRequest: Codable, Hashable {
    
    public var compId: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
    }
}
