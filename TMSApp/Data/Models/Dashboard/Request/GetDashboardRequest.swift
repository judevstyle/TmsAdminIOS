//
//  GetDashboardRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import UIKit

public struct GetDashboardRequest: Codable, Hashable {
    
    public var comp_id: Int?
    
    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case comp_id = "comp_id"
    }
}
