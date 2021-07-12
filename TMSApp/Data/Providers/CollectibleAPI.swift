//
//  CollectibleAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 6/30/21.
//

import Foundation
import Moya
import UIKit

public enum CollectibleAPI {
    case getCollectible
    case createCollectible(request: PostCollectibleRequest)
    case getCollectibleDetail(clbId: Int)
}

extension CollectibleAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getCollectible, .createCollectible(_), .getCollectibleDetail(_):
            return DomainNameConfig.TMSCollectible.url
        }
    }
    
    public var path: String {
        switch self {
        case .getCollectible, .createCollectible(_):
            return ""
        case .getCollectibleDetail(let clbId):
            return "/\(clbId)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getCollectible, .getCollectibleDetail(_):
            return .get
        case .createCollectible(_):
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getCollectible, .getCollectibleDetail(_):
            return .requestPlain
        case let .createCollectible(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getCollectible:
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
