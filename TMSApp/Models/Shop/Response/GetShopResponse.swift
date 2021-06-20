//
//  GetShopResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/19/21.
//

import Foundation

public struct GetShopResponse: Codable, Hashable {
    
    public var title: String?
    public var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case id = "id"
    }
}
