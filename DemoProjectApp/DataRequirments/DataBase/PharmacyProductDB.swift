//
//  PharmacyProductDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 13/10/22.
//

import Foundation
import SQLite3

class PharmacyProductDB {
    func createTable() -> Bool {
        
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS PHARMACYPRODUCTS (pharmacyId INTEGER, productId INTEGER, name TEXT, expiryDate TEXT, dosage TEXT,cost TEXT, productDescription TEXT, availableCount INTERER, imageLink TEXT, productRating NUMBER, totalBuyers INTEGER);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Pharmacy Product tables")
            return true
        }

        print("Unable to create Pharmacy Product table")
        return false
    }
    
    func addProduct(_ product: PharmacyProduct) {
        let query = "INSERT INTO PHARMACYPRODUCTS VALUES ('\(product.pharmacyId)','\(product.productId)','\(product.name)','\(product.expiryDate)', '\(product.dosage)', '\(product.cost)','\(product.medDescription)','\(product.availableCount)','\(product.imageLink)', '\(product.productRating)','\(product.totalBuyers)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Pharmacy Product Table Successfull")
            }
            else{
                print("Insertion into Pharmacy Product Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropProductTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE PHARMACYPRODUCTS"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Pharmacy Product table")
            }
            else{
                print("Failed to dropp Pharmacy Product table")
            }
        }
    }
    
    func emptyProductTable() {
        let query = "DELETE FROM PHARMACYPRODUCTS;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Pharmacy Product table")
            }
            else{
                print("Failed to delete all sample records from Pharmacy Product table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromProductTable(forPharmacyId: Int, forProductId: Int?) -> [PharmacyProduct] {
        var array: [PharmacyProduct] = []
        
        var query = "SELECT * FROM PHARMACYPRODUCTS WHERE pharmacyId = '\(forPharmacyId)';"
        
        if let productId = forProductId {
            query = "SELECT * FROM PHARMACYPRODUCTS WHERE pharmacyId = '\(forPharmacyId)' AND productId = '\(productId)';"
        }
 
        print(query)
        var selectionQueryPointer: OpaquePointer?
        
        let value = sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)
        
        print(value)
        if(value) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let pharmacyId = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let productId = Int(sqlite3_column_int(selectionQueryPointer, 1))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let expiryDate = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let dosage = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let cost = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let productDescription = String(cString: sqlite3_column_text(selectionQueryPointer, 6))
                
                let availableCount = Int(sqlite3_column_int(selectionQueryPointer, 7))
                
                let imageLink = String(cString: sqlite3_column_text(selectionQueryPointer, 8))
                
                let rating = Double(sqlite3_column_double(selectionQueryPointer, 9))
                
                let totalBuyers = Int(sqlite3_column_int(selectionQueryPointer, 10))
                
                let product = PharmacyProduct(
                    pharmacyId: pharmacyId,
                    productId: productId,
                    name: name,
                    expiryDate: expiryDate,
                    dosage: dosage,
                    cost: cost,
                    medDescription: productDescription,
                    availableCount: availableCount,
                    imageLink: imageLink,
                    productRating: rating,
                    totalBuyers: totalBuyers)
                
                array.append(product)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
}
