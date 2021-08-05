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
    case getOrder(request: GetOrderRequest)
    case getOrderCart(orderId: Int?)
    case confirmOrderCart(orderId: Int?)
}

extension OrderAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getOrder(_), .getOrderCart(_), .confirmOrderCart(_):
            return DomainNameConfig.TMSOrder.url
        }
    }
    
    public var path: String {
        switch self {
        case .getOrder(_):
            return ""
        case .getOrderCart(let orderId):
            return "/\(orderId ?? 0)"
        case .confirmOrderCart(let orderId):
            return "confirmOrder/\(orderId ?? 0)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getOrder(_), .getOrderCart(_):
            return .get
        case .confirmOrderCart(_):
            return .put
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getOrder(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case .getOrderCart(_), .confirmOrderCart(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getOrder(_):
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
