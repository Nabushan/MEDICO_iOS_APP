//
//  ShopHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 14/12/22.
//

import Foundation

class CartHelperVC {
    
    weak var delegate: CartProtocol?
    var productsAddedToCartYetToBePurchased: [Cart] = []
    var productsAddedToCartPurchased: [[Cart]] = []
    
    var yetToPurchaseSearchProducts: [Cart] = []
    var purchasedSearchProducts: [[Cart]] = []
    
    var cartIndicesToRemove: [Int] = []
    
    var selectedState: ProductStatus
    
    var productInfo: PharmacyProduct?
    
    var dates: Set<String> = []
    var sortedDates: [String] = []
    var purchasedProductSearchDates: [String] = []
    
    init() {
        selectedState = ProductStatus(rawValue: delegate?.searchController.searchBar.selectedScopeButtonIndex ?? 0) ?? .productPurchased
        getProductsAddedToCart()
        print("Creating new list for cart indices.")
        cartIndicesToRemove = []
        
        yetToPurchaseSearchProducts = productsAddedToCartYetToBePurchased
        purchasedSearchProducts = productsAddedToCartPurchased
        purchasedProductSearchDates = sortedDates
    }
    
    func getProductsAddedToCart() {
        productsAddedToCartYetToBePurchased = []
        productsAddedToCartPurchased = []
        
        productsAddedToCartYetToBePurchased = DBManager.sharedInstance.getProductOf(state: .productUnPurchased, forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        getDates()
        for date in sortedDates {
            let cartForGivenDate = DBManager.sharedInstance.getRowsFromCartTable(forDate: date, forUserId: UserDefaults.standard.integer(forKey: "User - Id"), forState: .productPurchased)
            
            productsAddedToCartPurchased.append(cartForGivenDate)
        }
        
        productsAddedToCartPurchased = productsAddedToCartPurchased.reversed()
        sortedDates = sortedDates.reversed()
        
        print(productsAddedToCartYetToBePurchased)
        print(productsAddedToCartPurchased)
    }
    
    func getDates() {
        dates = DBManager.sharedInstance.getStoredDates(forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        sortedDates = dates.sorted()
    }
    
    func updateMedicineQuantity(forMedName: String, forMedCost: String, toValue: Int, state: ProductStatus) {
        DBManager.sharedInstance.updateProductQuantity(forProductName: forMedName, productCost: Double(forMedCost) ?? 0.0, toQuantity: toValue, forUserId: UserDefaults.standard.integer(forKey: "User - Id"), state: state)
    }
    
    func deleteItemFromCart(atIndex: IndexPath) {
        var cart: Cart
        
        if(delegate?.searchController.isActive ?? false) {
            switch(selectedState) {
            case .productPurchased:
                cart = purchasedSearchProducts[atIndex.section][atIndex.row]
                purchasedSearchProducts[atIndex.section].remove(at: atIndex.row)
                
                if(purchasedSearchProducts[atIndex.section].count == 0){
                    purchasedSearchProducts.remove(at: atIndex.section)
                    purchasedProductSearchDates.remove(at: atIndex.section)
                }
            case .productUnPurchased:
                cart = yetToPurchaseSearchProducts[atIndex.row]
                yetToPurchaseSearchProducts.remove(at: atIndex.row)
            }
        }
        else{
            switch(selectedState) {
            case .productPurchased:
                cart = productsAddedToCartPurchased[atIndex.section][atIndex.row]
                productsAddedToCartPurchased[atIndex.section].remove(at: atIndex.row)
                
                if(productsAddedToCartPurchased[atIndex.section].count == 0){
                    productsAddedToCartPurchased.remove(at: atIndex.section)
                    sortedDates.remove(at: atIndex.section)
                }
            case .productUnPurchased:
                cart = productsAddedToCartYetToBePurchased[atIndex.row]
                productsAddedToCartYetToBePurchased.remove(at: atIndex.row)
            }
        }
        
        DBManager.sharedInstance.removeProductFromTable(cart.productName, Double(cart.productCost) ?? 0.0, date: cart.date ?? "", forUserId: UserDefaults.standard.integer(forKey: "User - Id"), state: cart.productStatus)
        
        if(delegate?.searchController.isActive ?? false) {
            getProductsAddedToCart()
        }
    }
    
    func getTotalCost() -> Double {
        var cost = 0.0
        
        for product in productsAddedToCartYetToBePurchased {
            cost+=(Double(product.productCost) ?? 0.0) * Double(product.productQuantity)
        }
        
        return cost
    }
    
    func getDifferentialCost(forValue: Double) -> Double {
        let valToReduce = floor(forValue)
        
        return forValue - valToReduce
    }
    
    func getSearchResults(forText: String) {
        switch(selectedState) {
        case .productUnPurchased:
            yetToPurchaseSearchProducts = []
            
            for cart in productsAddedToCartYetToBePurchased {
                let productName = cart.productName
                
                if(forText.count > cart.productName.count) {
                    continue
                }
                
                if(productName.lowercased().contains(forText.lowercased()) || forText == ""){
                    yetToPurchaseSearchProducts.append(cart)
                }
            }
        case .productPurchased:
            purchasedProductSearchDates = []
            purchasedSearchProducts = []
            
            var indexToRemove: [Int] = []
            
            for index in 0..<productsAddedToCartPurchased.count {
                var temp: [Cart] = []
                for product in productsAddedToCartPurchased[index] {
                    let productName = product.productName
                    
                    if(forText.count > product.productName.count) {
                        continue
                    }
                    
                    if(productName.lowercased().contains(forText.lowercased()) || forText == ""){
                        temp.append(product)
                    }
                    
                    purchasedProductSearchDates.append(product.date ?? "")
                }
                purchasedSearchProducts.append(temp)
                if(temp.count == 0){
                    indexToRemove.append(index)
                }
            }
            
            for index in stride(from: indexToRemove.count-1, through: 0, by: -1) {
                purchasedProductSearchDates.remove(at: indexToRemove[index])
                purchasedSearchProducts.remove(at: indexToRemove[index])
            }
        }
    }
    
    func getCountOfPurchasedProducts() -> Int {
        var count = 0
        
        for product in productsAddedToCartPurchased {
            count+=product.count
        }
        
        return count
    }
    
    func getCountOfSearchedPurchasedProducts() -> Int {
        var count = 0
        
        for product in purchasedSearchProducts {
            count+=product.count
        }
        
        return count
    }
    
    func didCompleteCheckOut() {
        for product in productsAddedToCartYetToBePurchased {
            DBManager.sharedInstance.updateProduct(toState: .productPurchased, forUserId: UserDefaults.standard.integer(forKey: "User - Id"), forProduct: product)
        }
    
        getProductsAddedToCart()
    }
    
    func getProductDetails(forProductId: Int, forPharmacyId: Int) {
        productInfo = DBManager.sharedInstance.getRowsFromProductTable(forPharmacyId: forPharmacyId, forProductId: forProductId)[0]
    }
}
