//
//  CustomerAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/13/21.
//

import Foundation
import Moya
import UIKit

public enum CustomerAPI {
    case getCustomer(request: GetCustomerRequest)
    case getCustomerSenderMatching(request: GetCustomerSenderMatchingRequest)
}

extension CustomerAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getCustomer(_), .getCustomerSenderMatching(_):
            return DomainNameConfig.TMSCustomer.url
        }
    }
    
    public var path: String {
        switch self {
        case .getCustomer(_):
            return ""
        case .getCustomerSenderMatching(_):
            return "/customerSenderMatching"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getCustomer(_), .getCustomerSenderMatching(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getCustomer(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .getCustomerSenderMatching(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getCustomer(_):
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
