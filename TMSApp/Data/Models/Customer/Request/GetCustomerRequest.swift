//
//  GetCustomerRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import Foundation

public struct GetCustomerRequest: Codable, Hashable {
    
    public var compId: Int?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case compId = "comp_id"
    }
}
