//
//  TruckAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/9/21.
//

import Foundation
import Moya
import UIKit

public enum TruckAPI {
    case getTruck(request: GetTruckRequest)
    case createTruck(request: PostTruckRequest)
}

extension TruckAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getTruck(_), .createTruck(_):
            return DomainNameConfig.TMSTruck.url
        }
    }
    
    public var path: String {
        switch self {
        case .getTruck(_), .createTruck(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getTruck(_):
            return .get
        case .createTruck(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getTruck(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .createTruck(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getTruck(_):
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
