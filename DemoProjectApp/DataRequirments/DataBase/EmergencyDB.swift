//
//  EmergencyDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 05/10/22.
//

import Foundation
import SQLite3

class EmergencyDB {
    
    func createTable() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS EMERGENCYCONTACTS (FIRSTNAME TEXT, LASTNAME TEXT, NUMBER TEXT, IDENTIFIER TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Emergency Contact table")
            return true
        }

        print("Unable to create Emergency Contact table")
        return false
    }
    
    func addEmergenyContact(_ contact: EmergencyContact){
        let query = "INSERT INTO EMERGENCYCONTACTS VALUES ('\(contact.firstName)', '\(contact.lastName)', '\(contact.number)', '\(contact.identifier)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Emergency Contact Successfull")
            }
            else{
                print("Insertion into Emergency Contact Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropEmergencyContactTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE EMERGENCYCONTACTS"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Emergency Contact table")
            }
            else{
                print("Failed to dropp Emergency Contact table")
            }
        }
    }
    
    func emptyEmergencyContactTable() {
        let query = "DELETE FROM EMERGENCYCONTACTS;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Emergency Contact table")
            }
            else{
                print("Failed to delete all sample records from Emergency Contact table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func removeContact(forFirstName: String, forLastName: String, forNumber: String) {
        let query = "DELETE FROM EMERGENCYCONTACTS WHERE FIRSTNAME = '\(forFirstName)' AND LASTNAME = '\(forLastName)' AND NUMBER = '\(forNumber)';"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted \(forFirstName) \(forLastName) sample record from Emergency Contact table")
            }
            else{
                print("Failed to delete \(forFirstName) \(forLastName) sample record from Emergency Contact table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromEmergencyContactTable() -> [EmergencyContact] {
        var array: [EmergencyContact] = []
        
        let query = "SELECT * FROM EMERGENCYCONTACTS;"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let firstName = String(cString: sqlite3_column_text(selectionQueryPointer, 0))
                
                let lastName = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let number = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let identifier = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let contact = EmergencyContact(
                    firstName: firstName,
                    lastName: lastName,
                    number: number,
                    identifier: identifier,
                    profileImage: nil)
                
                array.append(contact)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func getEmergencyContactNumbers() -> [String] {
        var array: [String] = []
        
        let query = "SELECT NUMBER FROM EMERGENCYCONTACTS;"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let number = String(cString: sqlite3_column_text(selectionQueryPointer, 0))
                
                array.append(number)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
}
