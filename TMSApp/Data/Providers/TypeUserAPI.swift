//
//  TypeUserAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Moya
import UIKit

public enum TypeUserAPI {
    case getTypeUser(request: GetTypeUserRequest)
}

extension TypeUserAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getTypeUser(_):
            return DomainNameConfig.TMSTypeUser.url
        }
    }
    
    public var path: String {
        switch self {
        case .getTypeUser(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getTypeUser(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getTypeUser(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getTypeUser(_):
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
