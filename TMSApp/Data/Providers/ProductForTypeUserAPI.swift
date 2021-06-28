//
//  ProductForTypeUserAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Moya
import UIKit

public enum ProductForTypeUserAPI {
    case getProductForTypeUser(request: GetProductForTypeUserRequest)
}

extension ProductForTypeUserAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getProductForTypeUser(_):
            return DomainNameConfig.TMSProductForTypeUser.url
        }
    }
    
    public var path: String {
        switch self {
        case .getProductForTypeUser(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getProductForTypeUser(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getProductForTypeUser(request):
            debugPrint(request.toJSON())
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getProductForTypeUser(_):
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
