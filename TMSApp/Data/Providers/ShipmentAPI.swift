//
//  ShipmentAPI.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 25/6/2564 BE.
//

import Foundation
import Moya
import UIKit

public enum ShipmentAPI {
    case getShipment(request: GetShipmentRequest)
    case getShipmentWorking(request: GetShipmentWorkingRequest)
    case getShipmentCustomer(shipmentId: Int)
    case updateShipment(shipmentId: Int, request: PutShipmentRequest)
}

extension ShipmentAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .getShipment(_), .getShipmentWorking(_), .getShipmentCustomer(_), .updateShipment(_, _):
            return DomainNameConfig.TMSShipment.url
        }
    }
    
    public var path: String {
        switch self {
        case .getShipment(_):
            return ""
        case .getShipmentWorking(_):
            return "shipmentWorkingByComp"
        case .getShipmentCustomer(let shipmentId):
            return "shipmentCustomer/\(shipmentId)"
        case .updateShipment(let shipmentId, _):
            return "/\(shipmentId)"
        
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getShipment(_), .getShipmentWorking(_), .getShipmentCustomer(_):
            return .get
        case .updateShipment(_, _):
            return .put
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case let .getShipment(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case let .getShipmentWorking(request):
            return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.queryString)
        case .getShipmentCustomer(_):
            return .requestPlain
        case let .updateShipment(shipmentId, request):
            return .requestCompositeParameters(bodyParameters: request.toJSON(), bodyEncoding: JSONEncoding.default, urlParameters: [:])
        }
    }
    
    public var headers: [String : String]? {
        var authenToken = ""
        switch self {
        case .getShipmentWorking(_):
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
