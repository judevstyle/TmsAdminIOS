//
//  GetFeedbackOneRequest.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/2/21.
//

import Foundation

public struct GetFeedbackOneRequest: Codable, Hashable {
    
    public var feedbackId: Int?

    public init() {}
    
    enum CodingKeys: String, CodingKey {
        case feedbackId = "feedbackId"
    }
}
