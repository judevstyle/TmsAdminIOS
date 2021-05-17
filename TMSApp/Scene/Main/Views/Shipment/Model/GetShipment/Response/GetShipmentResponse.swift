//
//  GetShipmentResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/15/21.
//

import Foundation

public struct GetShipmentResponse: Codable {
    
    public var title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}
