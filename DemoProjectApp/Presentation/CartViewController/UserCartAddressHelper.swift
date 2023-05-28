//
//  UserCartAddressHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import Foundation

class UserCartAddressHelper {
    weak var delegate: ShippingAddressProtocol?
    
    var shippingAddresses: [ShippingAddress] = []
    
    init() {
        loadShippingAddress()
    }
    
    func loadShippingAddress() {
        shippingAddresses = DBManager.sharedInstance.getRowsFromShippingAddressTable()
    }
    
    func removeShippingAddress(index: Int) {
        DBManager.sharedInstance.removeAddressFromShippingAddressTable(shippingAddresses[index])
        shippingAddresses.remove(at: index)
    }
}
