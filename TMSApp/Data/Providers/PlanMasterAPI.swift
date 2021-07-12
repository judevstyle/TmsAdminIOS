//
//  PlanMasterAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/11/21.
//

import Foundation
import Moya
import UIKit

public enum PlanMasterAPI {
    case getPlanMaster(request: GetPlanMasterRequest)
    case getPlanMasterDetail(planId: Int)
}

extension PlanMasterAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getPlanMaster(_), .getPlanMasterDetail(_):
            return DomainNameConfig.TMSPlanMaster.url
        }
    }
    
    public var path: String {
        switch self {
        case .getPlanMaster(_):
            return ""
        case .getPlanMasterDetail(let planId):
            return "/\(planId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getPlanMaster(_), .getPlanMasterDetail(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getPlanMaster(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case .getPlanMasterDetail(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getPlanMaster(_):
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
