//
//  GetOrderRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/16/21.
//

import Foundation

public struct GetOrderRequest: Codable {
    public var title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}
