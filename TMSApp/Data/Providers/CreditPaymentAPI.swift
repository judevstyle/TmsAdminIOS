//
//  CreditPaymentAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 8/5/21.
//

import Foundation
import Moya
import UIKit

public enum CreditPaymentAPI {
    case getCreditPaymentFindAll(request: GetCreditPaymentFindAllRequest)
}

extension CreditPaymentAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getCreditPaymentFindAll(_):
            return DomainNameConfig.TMSCreditPayment.url
        }
    }
    
    public var path: String {
        switch self {
        case .getCreditPaymentFindAll(_):
            return ""
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getCreditPaymentFindAll(_):
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getCreditPaymentFindAll(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getCreditPaymentFindAll(_):
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
