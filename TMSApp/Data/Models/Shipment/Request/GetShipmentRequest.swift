//
//  GetShipmentRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import Foundation

public struct GetShipmentRequest: Codable, Hashable {
    
    public var compId: Int?
    public var status: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
        case status = "status"
    }
}
