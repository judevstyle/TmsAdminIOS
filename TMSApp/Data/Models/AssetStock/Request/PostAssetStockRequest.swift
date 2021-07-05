//
//  PostAssetStockRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation

public struct PostAssetStockRequest: Codable, Hashable {
    
    public var astId: Int?
    public var quantity: Int?
    public var note: String?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case astId = "ast_id"
        case quantity = "quantity"
        case note = "note"
    }
}
