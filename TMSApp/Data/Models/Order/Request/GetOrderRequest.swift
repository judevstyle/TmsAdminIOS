//
//  GetOrderRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation

public struct GetOrderRequest: Codable, Hashable {
    
    public var status: String = "R"
    public var page: Int = 1
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case page = "page"
    }
}
