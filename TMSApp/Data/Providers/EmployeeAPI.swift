//
//  EmployeeAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation
import Moya
import UIKit

public enum EmployeeAPI {
    case getEmployee(request: GetEmployeeRequest)
    case createEmployee(request: PostEmployeeRequest)
}

extension EmployeeAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getEmployee(_), .createEmployee(_):
            return DomainNameConfig.TMSEmployee.url
        }
    }
    
    public var path: String {
        switch self {
        case .getEmployee(_), .createEmployee(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getEmployee(_):
            return .get
        case .createEmployee(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getEmployee(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .createEmployee(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getEmployee(_):
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
