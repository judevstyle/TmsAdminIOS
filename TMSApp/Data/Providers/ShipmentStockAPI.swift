//
//  ShipmentStockAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation
import Moya
import UIKit

public enum ShipmentStockAPI {
    case getShipmentStock(request: GetShipmentStockRequest)
    case postShipmentStock(request: PostShipmentStockRequest)
}

extension ShipmentStockAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getShipmentStock(_), .postShipmentStock(_):
            return DomainNameConfig.TMSShipmentStock.url
        }
    }
    
    public var path: String {
        switch self {
        case .getShipmentStock(_), .postShipmentStock(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getShipmentStock(_):
            return .get
        case .postShipmentStock(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getShipmentStock(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .postShipmentStock(request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getShipmentStock(_):
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
