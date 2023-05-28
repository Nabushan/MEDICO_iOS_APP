//
//  ShippingAdressDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import Foundation
import SQLite3

class ShippingAddressDB {
    func createTable() -> Bool {

        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS shippingAddresses (id INTEGER,name TEXT, contactNumber TEXT, doorNumber TEXT, addressLine1 TEXT, addressLine2 TEXT, pincode TEXT, forUserId INTEGER);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Shipping Address DB table")
            return true
        }

        print("Unable to create Shipping Address DB table")
        return false
    }
    
    func addToShippingAddress(_ shippingAddress: ShippingAddress) {
        let query = "INSERT INTO shippingAddresses VALUES ('\(shippingAddress.id)', '\(shippingAddress.name)', '\(shippingAddress.contactNumber)', '\(shippingAddress.doorNumber)', '\(shippingAddress.addressLine1)', '\(shippingAddress.addressLine2)', '\(shippingAddress.pincode)', '\(shippingAddress.forUserId)');"
            
        print(query)
        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Shipping Address DB is Successfull")
            }
            else{
                print("Insertion into Shipping Address DB Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropShippingAddressTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE shippingAddresses"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Shipping Address DB table")
            }
            else{
                print("Failed to dropp Shipping Address DB table")
            }
        }
    }
    
    func emptyShippingAddressTable() {
        let query = "DELETE FROM shippingAddresses;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Shipping Address DB table")
            }
            else{
                print("Failed to delete all sample records from Shipping Address DB table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromShippingAddressTable() -> [ShippingAddress] {
        var array: [ShippingAddress] = []
        
        let query = "SELECT * FROM shippingAddresses WHERE forUserId = '\(UserDefaults.standard.integer(forKey: "User - Id"))';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let contactNumber = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let doorNumber = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let addressLine1 = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let addressLine2 = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let pinCode = String(cString: sqlite3_column_text(selectionQueryPointer, 6))
                
                let userId = Int(sqlite3_column_int(selectionQueryPointer, 7))
                
                let address = ShippingAddress(id: id,
                                              name: name,
                                              contactNumber: contactNumber,
                                              doorNumber: doorNumber,
                                              addressLine1: addressLine1,
                                              addressLine2: addressLine2,
                                              pincode: pinCode,
                                              forUserId: userId)
                
                array.append(address)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func removeAddressFromShippingAddressTable(_ shippingAddress: ShippingAddress) {
        let query = "DELETE FROM shippingAddresses WHERE name = '\(shippingAddress.name)' AND contactNumber = '\(shippingAddress.contactNumber)' AND doorNumber = '\(shippingAddress.doorNumber)' AND addressLine1 = '\(shippingAddress.addressLine1)' AND addressLine2 = '\(shippingAddress.addressLine2)' AND pincode = '\(shippingAddress.pincode)' AND forUserId = '\(shippingAddress.forUserId)';"

        var deletionQueryPointer: OpaquePointer?
        
        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Shipping Address DB table")
            }
            else{
                print("Failed to delete all sample records from Shipping Address DB table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func updateShippingAddress(forId: Int, _ shippingAddress: ShippingAddress) {
        let query = "UPDATE shippingAddresses SET name = '\(shippingAddress.name)', contactNumber = '\(shippingAddress.contactNumber)', doorNumber = '\(shippingAddress.doorNumber)', addressLine1 = '\(shippingAddress.addressLine1)', addressLine2 = '\(shippingAddress.addressLine2)', pincode = '\(shippingAddress.pincode)' WHERE id = '\(forId)' AND forUserId = '\(shippingAddress.forUserId)';"

        var updationQueryPointer: OpaquePointer?
        
        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(updationQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully Updated sample record from Shipping Address DB table")
            }
            else{
                print("Failed to Update the sample record from Shipping Address DB table")
            }
        }

        sqlite3_finalize(updationQueryPointer)
    }
}
