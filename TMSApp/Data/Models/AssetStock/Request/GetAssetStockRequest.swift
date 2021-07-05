//
//  GetAssetStockRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation

public struct GetAssetStockRequest: Codable, Hashable {
    
    public var astId: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case astId = "ast_id"
    }
}


