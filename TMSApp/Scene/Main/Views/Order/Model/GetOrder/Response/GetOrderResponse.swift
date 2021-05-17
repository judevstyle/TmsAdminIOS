//
//  GetOrderResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/16/21.
//

import Foundation

public struct GetOrderResponse: Codable {
    
    public var title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}
