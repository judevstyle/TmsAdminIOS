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
    case createPlanMaster(request: PostPlanMasterRequest)
}

extension PlanMasterAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getPlanMaster(_), .getPlanMasterDetail(_), .createPlanMaster(_):
            return DomainNameConfig.TMSPlanMaster.url
        }
    }
    
    public var path: String {
        switch self {
        case .getPlanMaster(_), .createPlanMaster(_):
            return ""
        case .getPlanMasterDetail(let planId):
            return "/\(planId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getPlanMaster(_), .getPlanMasterDetail(_):
            return .get
        case .createPlanMaster(_):
            return .post
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
        case let .createPlanMaster(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getPlanMaster(_):
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
