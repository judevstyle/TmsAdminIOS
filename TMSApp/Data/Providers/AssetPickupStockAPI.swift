//
//  AssetPickupStockAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/29/21.
//

import Foundation
import Moya
import UIKit

public enum AssetPickupStockAPI {
    case getAssetPickup(request: GetAssetPickupStockRequest)
    case createAssetPickup(request: PostAssetPickupStockRequest)
}

extension AssetPickupStockAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getAssetPickup(_), .createAssetPickup(_):
            return DomainNameConfig.TMSAssetPickupStock.url
        }
    }
    
    public var path: String {
        switch self {
        case .getAssetPickup(_), .createAssetPickup(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getAssetPickup(_):
            return .get
        case .createAssetPickup(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getAssetPickup(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .createAssetPickup(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getAssetPickup(_):
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
