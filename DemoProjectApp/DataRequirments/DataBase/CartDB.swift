//
//  CartDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 19/12/22.
//

import Foundation
import SQLite3

class CartDB {
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.dateFormat = "dd-MM-yyyy"
        
        return formatter
    }()
    
    func createTable() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS cart (productName TEXT, productImage TEXT, productCost TEXT, numberOfItems INTEGER, date TEXT, pharmacyId INTEGER, productId INTEGER,productRating NUMBER, productStatus INTEGER, forUserId INTEGER);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created cart table")
            return true
        }

        print("Unable to create cart table")
        return false
    }
    
    func addToCart(_ product: Cart) {
        var existsPointer: OpaquePointer?
        
        let existsQuery = "SELECT EXISTS (SELECT * FROM cart WHERE productName = '\(product.productName)' AND date = '\(formatter.string(from: Date.now))' AND productStatus = '\(product.productStatus.rawValue)' AND forUserId = '\(product.forUserId)') LIMIT 1;"
        
        print("Exists Query \n", existsQuery)
        
        if(sqlite3_prepare_v2(dbQueue, existsQuery, -1, &existsPointer, nil)) == SQLITE_OK {
            
            var boolResult = 0
            
            while(sqlite3_step(existsPointer) == SQLITE_ROW){
                boolResult = Int(sqlite3_column_int(existsPointer, 0))
            }
            
            if(boolResult == 1) {
                print("Product Already exists")
                
                let countQuery = "SELECT numberOfItems FROM cart WHERE productName = '\(product.productName)' AND date = '\(formatter.string(from: Date.now))' AND forUserId = '\(product.forUserId)';"
                
                var count = product.productQuantity
                
                if(sqlite3_prepare_v2(dbQueue, countQuery, -1, &existsPointer, nil)) == SQLITE_OK {
                    var tempCount = 0
                    
                    while(sqlite3_step(existsPointer) == SQLITE_ROW){
                        tempCount = Int(sqlite3_column_int(existsPointer, 0))
                    }
                    
                    count += tempCount
                    
                    if(count > 50) {
                        count = 50
                    }
                    
                    updateProductQuantity(forProductName: product.productName, productCost: Double(product.productCost) ?? -1.0, toQuantity: count, forUserId: product.forUserId, state: product.productStatus)
                    print("Value of quantity updated successfully when asked to add product.")
                }
                else{
                    print("Failed to update the value of Quantity for already existing quantity.")
                }
                
                return
            }
        }
        print("Adding a new product into the cart table")
            
        var query = "INSERT INTO cart VALUES ('\(product.productName)',  '\(product.productImage)', '\(product.productCost)',  '\(product.productQuantity)', '\(formatter.string(from: Date.now))', '\(product.pharmacyId)', '\(product.productId)', '\(product.productRating)','\(product.productStatus.rawValue)', '\(product.forUserId)');"

        if let productDate = product.date {
            query = "INSERT INTO cart VALUES ('\(product.productName)',  '\(product.productImage)', '\(product.productCost)',  '\(product.productQuantity)', '\(productDate)', '\(product.pharmacyId)', '\(product.productId)', '\(product.productRating)','\(product.productStatus.rawValue)', '\(product.forUserId)');"
        }
        
        print(query)
        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Cart DB is Successfull")
            }
            else{
                print("Insertion into Cart DB Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropCartTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE cart"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped cart table")
            }
            else{
                print("Failed to dropp cart table")
            }
        }
    }
    
    func emptyCartTable(forState: ProductStatus, foruserId: Int) {
        let query = "DELETE FROM cart WHERE productStatus = '\(forState.rawValue)' AND forUserId = '\(foruserId)';"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from cart table")
            }
            else{
                print("Failed to delete all sample records from cart table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromCartTable(forDate: String, forUserId: Int, forState: ProductStatus) -> [Cart] {
        var array: [Cart] = []
        
        let query = "SELECT * FROM cart WHERE date = '\(forDate)' AND forUserId = '\(forUserId)' AND productStatus = '\(forState.rawValue)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let productName = String(cString: sqlite3_column_text(selectionQueryPointer, 0))
                
                let productImage = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let productCost = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let productQuantity = Int(sqlite3_column_int(selectionQueryPointer, 3))
                
                let date = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let pharmacyId = Int(sqlite3_column_int(selectionQueryPointer, 5))
                
                let productId = Int(sqlite3_column_int(selectionQueryPointer, 6))
                
                let rating = Double(sqlite3_column_double(selectionQueryPointer, 7))
                
                let productStatus = Int(sqlite3_column_int(selectionQueryPointer, 8))
                
                let userId = Int(sqlite3_column_int(selectionQueryPointer, 9))
                
                let cart = Cart(productName: productName,
                                productImage: productImage,
                                productCost: productCost,
                                productQuantity: productQuantity,
                                pharmacyId: pharmacyId,
                                productId: productId,
                                date: date,
                                productRating: rating,
                                productStatus: ProductStatus(rawValue: productStatus) ?? .productUnPurchased,
                                forUserId: userId)
                
                array.append(cart)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func getCartSearchResults(for searchString: String, forUserId: Int) -> [Cart] {
        var searchResultPointer: OpaquePointer?
        
        var array: [Cart] = []
        let query = "SELECT * FROM cart WHERE productName LIKE '%\(searchString)%' AND forUserId = '\(forUserId)'"
        
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &searchResultPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(searchResultPointer) == SQLITE_ROW){
                let productName = String(cString: sqlite3_column_text(searchResultPointer, 0))
                
                let productImage = String(cString: sqlite3_column_text(searchResultPointer, 1))
                
                let productCost = String(cString: sqlite3_column_text(searchResultPointer, 2))
                
                let productQuantity = Int(sqlite3_column_int(searchResultPointer, 3))
                
                let date = String(cString: sqlite3_column_text(searchResultPointer, 4))
                
                let pharmacyId = Int(sqlite3_column_int(searchResultPointer, 5))
                
                let productId = Int(sqlite3_column_int(searchResultPointer, 6))
                
                let rating = Double(sqlite3_column_double(searchResultPointer, 7))
                
                let productStatus = Int(sqlite3_column_int(searchResultPointer, 8))
                
                let userId = Int(sqlite3_column_int(searchResultPointer, 9))
                
                let cart = Cart(productName: productName,
                                productImage: productImage,
                                productCost: productCost,
                                productQuantity: productQuantity,
                                pharmacyId: pharmacyId,
                                productId: productId,
                                date: date,
                                productRating: rating,
                                productStatus: ProductStatus(rawValue: productStatus) ?? .productUnPurchased,
                                forUserId: userId)
                
                array.append(cart)
            }
        }

        sqlite3_finalize(searchResultPointer)
        return array
    }
    
    func updateProductQuantity(forProductName: String, productCost: Double, toQuantity: Int, forUserId: Int, state: ProductStatus) {
        let query = "UPDATE cart SET numberOfItems = \(toQuantity) WHERE productName = '\(forProductName)' AND productCost = '\(productCost)' AND forUserId = '\(forUserId)' AND productStatus = '\(state.rawValue)';"

        var updationQueryPointer: OpaquePointer?
        
        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(updationQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully updated the product quantity record in cart DB")
            }
            else{
                print("Failed to delete updated the product quantity record in cart DB")
            }
        }

        sqlite3_finalize(updationQueryPointer)
    }
    
    func updateProduct(toState: ProductStatus, forUserId: Int, forProduct cart: Cart) {
        let query = "UPDATE cart SET productStatus = \(toState.rawValue) WHERE forUserId = '\(forUserId)' AND productName = '\(cart.productName)' AND productCost = '\(cart.productCost)';"

        var updationQueryPointer: OpaquePointer?
        
        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(updationQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully updated the product state record in cart DB")
            }
            else{
                print("Failed to delete updated the product state record in cart DB")
            }
        }

        sqlite3_finalize(updationQueryPointer)
    }
    
    func removeProductFromTable(_ productName: String, _ productCost: Double, date: String,forUserId: Int, state: ProductStatus) {
        let query = "DELETE FROM cart WHERE productName = '\(productName)' AND productCost = '\(productCost)' AND forUserId = '\(forUserId)' AND productStatus = '\(state.rawValue)' AND date = '\(date)';"

        var deletionQueryPointer: OpaquePointer?
        
        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from cart table")
            }
            else{
                print("Failed to delete all sample records from cart table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getStoredDates(forUserId: Int) -> Set<String> {
        var selectionPointer: OpaquePointer?
        var dates: Set<String> = []
        
        let query = "SELECT date FROM cart WHERE forUserId = '\(forUserId)' AND productStatus = '\(ProductStatus.productPurchased.rawValue)';"
        
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionPointer) == SQLITE_ROW){
                dates.insert(String(cString: sqlite3_column_text(selectionPointer, 0)))
            }
        }

        sqlite3_finalize(selectionPointer)
        return dates
    }
    
    func getProductOf(state: ProductStatus, forUserId: Int) -> [Cart] {
        var array: [Cart] = []
        
        let query = "SELECT * FROM cart WHERE \(state.dbName) = '\(state.rawValue)' AND forUserId = '\(forUserId)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let productName = String(cString: sqlite3_column_text(selectionQueryPointer, 0))
                
                let productImage = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let productCost = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let productQuantity = Int(sqlite3_column_int(selectionQueryPointer, 3))
                
                let date = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let pharmacyId = Int(sqlite3_column_int(selectionQueryPointer, 5))
                
                let productId = Int(sqlite3_column_int(selectionQueryPointer, 6))
                
                let rating = Double(sqlite3_column_double(selectionQueryPointer, 7))
                
                let productStatus = Int(sqlite3_column_int(selectionQueryPointer, 8))
                
                let userId = Int(sqlite3_column_int(selectionQueryPointer, 9))
                
                let cart = Cart(productName: productName,
                                productImage: productImage,
                                productCost: productCost,
                                productQuantity: productQuantity,
                                pharmacyId: pharmacyId,
                                productId: productId,
                                date: date,
                                productRating: rating,
                                productStatus: ProductStatus(rawValue: productStatus) ?? .productUnPurchased,
                                forUserId: userId)
                
                array.append(cart)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
}
