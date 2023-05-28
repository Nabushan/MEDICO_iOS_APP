//
//  ProductStatus.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 23/12/22.
//

import Foundation

enum ProductStatus: Int, RawRepresentable {
    case productUnPurchased = 0
    case productPurchased
    
    var stateDescription: String {
        switch(self) {
        case .productPurchased: return "Product Purchased"
        case .productUnPurchased: return "Product UnPurchased"
        }
    }
    
    var dbName: String {
        return "productStatus"
    }
}
