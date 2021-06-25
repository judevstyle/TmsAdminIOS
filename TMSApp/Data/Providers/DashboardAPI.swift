//
//  DashboardAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import Moya
import UIKit

public enum DashboardAPI {
    case getDashboard(request: GetDashboardRequest)
}

extension DashboardAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getDashboard(_):
            return DomainNameConfig.TMSDashboard.url
        }
    }
    
    public var path: String {
        switch self {
        case .getDashboard(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getDashboard(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getDashboard(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getDashboard(_):
            authenToken = ""
        }
        
        if authenToken.isEmpty {
            return ["Content-Type": "application/json"]
        }
        
        return ["Authorization": authenToken,
            "Content-Type": "application/json"]
    }
}
