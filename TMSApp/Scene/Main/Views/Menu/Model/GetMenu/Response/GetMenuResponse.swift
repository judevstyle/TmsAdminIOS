//
//  GetMenuResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/17/21.
//

import Foundation
import Foundation

public struct GetMenuResponse: Codable {
    
    public var title: String?
    public var image: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "image"
    }
}
