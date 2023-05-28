//
//  PharmacyProductHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 19/12/22.
//

import Foundation

class PharmacyProductHelper {
    weak var delegate: AddToCartProtocol?
    
    init() {
        
    }
    
    func addProductToCart(_ product: PharmacyProduct, quantity: Int, pharmacyId: Int) -> Bool {
        if(quantity != 0){
            let cart = Cart(productName: product.name,
                            productImage: product.imageLink,
                            productCost: product.cost,
                            productQuantity: quantity,
                            pharmacyId: pharmacyId,
                            productId: product.productId,
                            date: nil,
                            productRating: product.productRating,
                            productStatus: .productUnPurchased,
                            forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
            
            DBManager.sharedInstance.addToCart(cart)
            return true
        }
        return false
    }
}
