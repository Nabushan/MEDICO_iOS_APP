//
//  Cart.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 19/12/22.
//

import Foundation

struct Cart {
    let productName: String
    let productImage: String
    let productCost: String
    var productQuantity: Int
    let pharmacyId: Int
    let productId: Int
    let date: String?
    let productRating: Double
    let productStatus: ProductStatus
    let forUserId: Int
}

struct ShippingAddress: Equatable {
    let id: Int
    let name: String
    let contactNumber: String
    let doorNumber: String
    let addressLine1: String
    let addressLine2: String
    let pincode: String
    let forUserId: Int
}
