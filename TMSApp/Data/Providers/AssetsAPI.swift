//
//  AssetAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 29/6/2564 BE.
//

import Foundation
import Moya
import UIKit

public enum AssetsAPI {
    case getAssets(request: GetAssetsRequest)
}

extension AssetsAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getAssets(_):
            return DomainNameConfig.TMSAssets.url
        }
    }
    
    public var path: String {
        switch self {
        case .getAssets(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAssets(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getAssets(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getAssets(_):
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
