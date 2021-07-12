//
//  AuthEmployeeAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/7/21.
//

import Foundation
import Moya
import UIKit

public enum AuthEmployeeAPI {
    case authenticate(request: PostAuthEmployeeRequest)
    case logout
}

extension AuthEmployeeAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .authenticate(_), .logout:
            return DomainNameConfig.TMSAuthEmployee.url
        }
    }
    
    public var path: String {
        switch self {
        case .authenticate(_):
            return "/loginEmployee"
        case .logout:
            return "/logoutEmployee"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .authenticate(_), .logout:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .authenticate(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .logout:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .authenticate(_):
            authenToken = ""
        case .logout:
            authenToken = UserDefaultsKey.AccessToken.string ?? ""
        }
        
        if authenToken.isEmpty {
            return ["Content-Type": "application/json"]
        }
        
        return ["Authorization": "Bearer \(authenToken)",
            "Content-Type": "application/json"]
    }
}
