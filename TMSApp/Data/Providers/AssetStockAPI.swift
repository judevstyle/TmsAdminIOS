//
//  AssetStockAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Moya
import UIKit

public enum AssetStockAPI {
    case getAssetStock(request: GetAssetStockRequest)
    case createAssetStock(request: PostAssetStockRequest)
}

extension AssetStockAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getAssetStock(_), .createAssetStock(_):
            return DomainNameConfig.TMSAssetStock.url
        }
    }
    
    public var path: String {
        switch self {
        case .getAssetStock(_), .createAssetStock(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAssetStock(_):
            return .get
        case .createAssetStock(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getAssetStock(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .createAssetStock(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getAssetStock(_):
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
