//
//  ShipmentStockManager.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/18/21.
//

import Foundation

public class ShipmentStockManager {
    
    public static let shared: ShipmentStockManager = ShipmentStockManager()
    
    fileprivate var listSelectShipmentStock: [PostShipmentStockRequest] = []
    
    public init() { }
    
    public func getListSelectShipmentStock() -> [PostShipmentStockRequest] {
        return self.listSelectShipmentStock
    }
    
    public func setListSelectShipmentStock(items: [PostShipmentStockRequest]) {
        self.listSelectShipmentStock = items
    }
}
