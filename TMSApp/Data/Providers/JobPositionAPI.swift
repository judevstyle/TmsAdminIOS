//
//  JobPositionAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/8/21.
//

import Foundation
import Moya
import UIKit

public enum JobPositionAPI {
    case getJobPosition(request: GetJobPositionRequest)
}

extension JobPositionAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getJobPosition(_):
            return DomainNameConfig.TMSJobPosition.url
        }
    }
    
    public var path: String {
        switch self {
        case .getJobPosition(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getJobPosition(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getJobPosition(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getJobPosition(_):
            authenToken = ""
        default:
            authenToken = ""
        }
        
        if authenToken.isEmpty {
            return ["Content-Type": "application/json"]
        }
        
        return ["Authorization": authenToken,
            "Content-Type": "application/json"]
    }
}
