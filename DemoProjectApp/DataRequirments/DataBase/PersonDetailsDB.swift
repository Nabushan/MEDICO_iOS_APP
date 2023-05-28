//
//  PersonDetailsDB.swift
//  Medico
//
//  Created by nabushan-pt5611 on 01/02/23.
//

import Foundation
import SQLite3

class PersonDetailsDB {
    func createPersonDetailsTables() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS personDetails (id INTEGER, name TEXT, dateOfBirth TEXT, gender TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created User table")
            return true
        }

        print("Unable to create User table")
        return false
    }
    
    func emptyPersonDetailsTable() {
        let query = "DELETE FROM personDetails;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Person Details table")
            }
            else{
                print("Failed to delete all sample records from Person Details table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func dropPersonDetailsTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE personDetails"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Available Person Details Table")
            }
            else{
                print("Failed to drop Available Person Details Table")
            }
        }
    }
    
    func addPersonDetails(_ person: Person) {
        let query = "INSERT INTO personDetails VALUES ('\(person.id)', '\(person.name)', '\(person.dateOfBirth)', '\(person.gender)');"

        var insertQueryPointer: OpaquePointer?
        
        print(query)

        let value = sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)
        
        print(value)
        
        if(value) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Person Details Table Successfull")
            }
            else{
                print("Insertion into Person Details Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func updatePersonDetails(_ person: Person, forId: Int) {
        let query = "UPDATE personDetails SET name = '\(person.name)', dateOfBirth = '\(person.dateOfBirth)', gender = '\(person.gender)' WHERE id = '\(forId)';"

        var updateQueryPointer: OpaquePointer?
        
        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updateQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updateQueryPointer) == SQLITE_DONE){
                print("Updation into Person Table Successfull")
            }
            else{
                print("Updation into Person Table Failed")
            }
        }

        sqlite3_finalize(updateQueryPointer)
    }
    
    func getAllPersonDetails() -> [Person] {
        var array: [Person] = []
        
        let query = "SELECT * FROM personDetails;"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let dateOfBirth = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let gender = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let user = Person(id: id,
                                  name: name,
                                  dateOfBirth: dateOfBirth,
                                  gender: gender)
                
                array.append(user)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func getPersonDetailForId(_ id: Int) -> Person {
        var user: Person = Person(id: -1, name: "", dateOfBirth: "", gender: "")
        
        let query = "SELECT * FROM personDetails WHERE id = '\(id)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let dateOfBirth = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let gender = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                user = Person(id: id,
                              name: name,
                              dateOfBirth: dateOfBirth,
                              gender: gender)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return user
    }
    
    func removePersonDetail(forId: Int) {
        let query = "DELETE FROM personDetails WHERE id = '\(forId)';"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted sample records from Person Details table")
            }
            else{
                print("Failed to delete sample records from Person Details table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
}
