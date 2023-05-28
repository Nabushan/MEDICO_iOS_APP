//
//  PharmacyDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 10/10/22.
//

import Foundation
import SQLite3

class PharmacyDB {
    func createTable() -> Bool {
        
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS PHARMACIES (id INTEGER, pharmacyName TEXT, address TEXT,locationLink TEXT, kmValue TEXT, ratingOutOfFive INTEGER, totalNumberOfRatings INTEGER, productId INTEGER, ratingId INTEGER, reviewId INTEGER, pharmacyImage TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Pharmacy tables")
            return true
        }

        print("Unable to create Pharmacy table")
        return false
    }
    
    func addPharmacy(_ pharmacy: Pharmacy) {
        let query = "INSERT INTO PHARMACIES VALUES ('\(pharmacy.id)','\(pharmacy.name)','\(pharmacy.address)','\(pharmacy.directionToStoreLink)','\(pharmacy.kmValue)','\(pharmacy.ratingOutOfFive)','\(pharmacy.totalNumberOfRatings)','\(pharmacy.productBatchId)','\(pharmacy.ratingId)','\(pharmacy.reviewId)','\(pharmacy.pharmacyImage)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Pharmacy Table Successfull")
            }
            else{
                print("Insertion into Pharmacy Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropPharmacyTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE PHARMACIES"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Pharmacy table")
            }
            else{
                print("Failed to dropp Pharmacy table")
            }
        }
    }
    
    func emptyPharmacyTable() {
        let query = "DELETE FROM PHARMACIES;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Pharmacy table")
            }
            else{
                print("Failed to delete all sample records from Pharmacy table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromPharmacyTable() -> [Pharmacy] {
        var array: [Pharmacy] = []
        
        let query = "SELECT * FROM PHARMACIES;"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let address = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let locationLink = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let kmValue = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let ratingOutOfFive = Int(sqlite3_column_int(selectionQueryPointer, 5))
                
                let totalNumberOfRatings = Int(sqlite3_column_int(selectionQueryPointer, 6))
                
                let productId = Int(sqlite3_column_int(selectionQueryPointer, 7))
                
                let ratingId = Int(sqlite3_column_int(selectionQueryPointer, 8))
                
                let reviewId = Int(sqlite3_column_int(selectionQueryPointer, 9))
                
                let pharmacyImage = String(cString: sqlite3_column_text(selectionQueryPointer, 10))
                
                let pharmacy = Pharmacy(
                    id: id,
                    name: name,
                    productBatchId: productId,
                    address: address,
                    directionToStoreLink: locationLink,
                    kmValue: kmValue,
                    ratingOutOfFive: ratingOutOfFive,
                    totalNumberOfRatings: totalNumberOfRatings,
                    ratingId: ratingId,
                    reviewId: reviewId,
                    pharmacyImage: pharmacyImage)
                
                array.append(pharmacy)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func updatePharmacyDetails(forRow: Int, updateColumn: PharmacyUpdate, toValue: Int) {
        
        let query = "UPDATE PHARMACIES SET \(updateColumn.dbName) = '\(toValue)' WHERE id = '\(forRow)';"

        print(query)
        
        var updationQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updationQueryPointer) == SQLITE_DONE){
                print("Successfully Updated the Pharmacy \(updateColumn.dbName) sample")
            }
            else{
                print("Updation Failed for Pharmacy \(updateColumn.dbName)")
            }
        }
    }
}
