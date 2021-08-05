//
//  ProductSpecialForTypeUserAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 27/6/2564 BE.
//

import Foundation
import Moya
import UIKit

public enum ProductSpecialForTypeUserAPI {
    case getProductSpecialForTypeUser(request: GetProductSpecialForTypeUserRequest)
    case createProductSpecialForTypeUser(request: PostProductSpecialForTypeUserRequest)
    case updateProductSpecialForTypeUser(request: PutProductSpecialForTypeUserRequest, productSpcIid: Int)
    case deleteProductSpecialForTypeUser(productSpcIid: Int)
}

extension ProductSpecialForTypeUserAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getProductSpecialForTypeUser(_),
             .createProductSpecialForTypeUser(_),
             .updateProductSpecialForTypeUser(_,_),
             .deleteProductSpecialForTypeUser(_):
            return DomainNameConfig.TMSProductSpecialForTypeUser.url
        }
    }
    
    public var path: String {
        switch self {
        case .getProductSpecialForTypeUser(_), .createProductSpecialForTypeUser(_):
            return ""
        case .updateProductSpecialForTypeUser(_, let productSpcIid), .deleteProductSpecialForTypeUser(let productSpcIid):
            return "/\(productSpcIid)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getProductSpecialForTypeUser(_):
            return .get
        case .createProductSpecialForTypeUser(_):
            return .post
        case .updateProductSpecialForTypeUser(_, _):
            return .put
        case .deleteProductSpecialForTypeUser(_):
            return .delete
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getProductSpecialForTypeUser(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .createProductSpecialForTypeUser(request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case let .updateProductSpecialForTypeUser(request, _):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        case .deleteProductSpecialForTypeUser(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getProductSpecialForTypeUser(_):
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
