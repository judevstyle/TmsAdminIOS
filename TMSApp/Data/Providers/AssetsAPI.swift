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
    case createAssets(request: PostAssetsRequest)
}

extension AssetsAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getAssets(_), .createAssets(_):
            return DomainNameConfig.TMSAssets.url
        }
    }
    
    public var path: String {
        switch self {
        case .getAssets(_), .createAssets(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAssets(_):
            return .get
        case .createAssets(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getAssets(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .createAssets(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getAssets(_):
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
