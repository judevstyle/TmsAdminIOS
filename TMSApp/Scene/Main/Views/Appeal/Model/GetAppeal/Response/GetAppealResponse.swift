//
//  GetAppealResponse.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 5/18/21.
//

import Foundation

public struct GetAppealResponse: Codable {
    
    public var title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}
