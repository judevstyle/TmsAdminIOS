//
//  SelectCustomerManager.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/14/21.
//

import Foundation

public class SelectCustomerManager {
    
    public static let shared: SelectCustomerManager = SelectCustomerManager()
    

    fileprivate var listSelectCustomerStore: [ShipmentCustomerItems] = []
    
    fileprivate var listDeleteCustomerStore: [ShipmentCustomerItems] = []
    
    public init() { }
    
    public func getSelectCustomer() -> [ShipmentCustomerItems] {
        return self.listSelectCustomerStore
    }
    
    public func setSelectCustomer(items: [ShipmentCustomerItems]) {
        self.listSelectCustomerStore = items
    }
    
    public func getListDeleteCustomer() -> [ShipmentCustomerItems] {
        return self.listDeleteCustomerStore
    }
    
    public func setListDeleteCustomer(items: [ShipmentCustomerItems]) {
        self.listDeleteCustomerStore = items
    }
}
