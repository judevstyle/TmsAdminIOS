//
//  OrderAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 26/6/2564 BE.
//

import Foundation
import Moya
import UIKit

public enum OrderAPI {
    case getOrder(request: GetDashboardRequest)
}

extension OrderAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getOrder(_):
            return DomainNameConfig.TMSDashboard.url
        }
    }
    
    public var path: String {
        switch self {
        case .getOrder(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getOrder(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getOrder(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getOrder(_):
            authenToken = ""
        }
        
        if authenToken.isEmpty {
            return ["Content-Type": "application/json"]
        }
        
        return ["Authorization": authenToken,
            "Content-Type": "application/json"]
    }
}
