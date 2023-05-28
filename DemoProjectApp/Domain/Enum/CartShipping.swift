//
//  CartShipping.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import Foundation

enum Shipping: Int, RawRepresentable {
    case name = 0
    case contactNumber
    case doorNumber
    case addressLine1
    case addressLine2
    case pincode
    
    var dbName: String {
        switch(self) {
        case .name: return "name"
        case .contactNumber: return "contactNumber"
        case .doorNumber: return "doorNumber"
        case .addressLine1: return "addressLine1"
        case .addressLine2: return "addressLine2"
        case .pincode: return "pincode"
        }
    }
}
