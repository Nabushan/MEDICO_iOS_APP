//
//  PharmacyAvailableProductsHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/12/22.
//

import Foundation

class PharmacyAvailableProductsHelper {
    
    weak var delegate: PharmacyAvailableProductsProrocol?
    let pharmacyProducts: [PharmacyProduct]
    var searchProducts: [PharmacyProduct] = []
    
    init(_ pharmacyProducts: [PharmacyProduct]) {
        self.pharmacyProducts = pharmacyProducts
    }
    
    func getSearchResults(forText: String) {
        searchProducts = []
        
        for cart in pharmacyProducts {
            let productName = cart.name
            
            if(forText.count > cart.name.count) {
                continue
            }
            
            let range = productName.index(forText.startIndex, offsetBy: 0)..<productName.index(forText.endIndex, offsetBy: 0)
            
            if(forText == productName[range]) {
                searchProducts.append(cart)
            }
        }
    }
}
