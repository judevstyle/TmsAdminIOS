//
//  FeedbackAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/2/21.
//

import Foundation
import Moya
import UIKit

public enum FeedbackAPI {
    case getFeedbackAll(request: GetFeedbackAllRequest)
    case getFeedbackOne(request: GetFeedbackOneRequest)
}

extension FeedbackAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getFeedbackAll(_), .getFeedbackOne(_):
            return DomainNameConfig.TMSFeedback.url
        }
    }
    
    public var path: String {
        switch self {
        case .getFeedbackAll(_):
            return ""
        case .getFeedbackOne(let request):
            return "/\(request.feedbackId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getFeedbackAll(_), .getFeedbackOne(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getFeedbackAll(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case .getFeedbackOne(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getFeedbackAll(_):
            authenToken = UserDefaultsKey.AccessToken.string ?? ""
        default:
            authenToken = UserDefaultsKey.AccessToken.string ?? ""
        }
        
        if authenToken.isEmpty {
            return ["Content-Type": "application/json"]
        }
        
        return ["Authorization": "Bearer \(authenToken)",
            "Content-Type": "application/json"]
    }
}
