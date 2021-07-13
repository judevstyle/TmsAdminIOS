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
}

extension ShipmentStockAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getShipmentStock(_):
            return DomainNameConfig.TMSShipmentStock.url
        }
    }
    
    public var path: String {
        switch self {
        case .getShipmentStock(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getShipmentStock(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getShipmentStock(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getShipmentStock(_):
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
