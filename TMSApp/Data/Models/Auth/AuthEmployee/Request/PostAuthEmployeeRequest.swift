//
//  PostAuthEmployeeRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation

public struct PostAuthEmployeeRequest: Codable, Hashable {
    
    public var username: String?
    public var password: String?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
    }
}
