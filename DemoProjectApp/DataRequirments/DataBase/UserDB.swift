//
//  File.swift
//  Medico
//
//  Created by nabushan-pt5611 on 21/01/23.
//

import Foundation
import SQLite3

class UserDB {
    func createUserTables() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS users (id INTEGER, name TEXT, password TEXT, mailId TEXT, DateOfBirth TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created User table")
            return true
        }

        print("Unable to create User table")
        return false
    }
    
    func addUserDetails(_ user: User) {
        let query = "INSERT INTO users VALUES ('\(user.id)', '\(user.name)', '\(user.password)', '\(user.mailId)', '\(user.dateOfBirth)');"

        var insertQueryPointer: OpaquePointer?
        
        print(query)

        let value = sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)
        
        print(value)
        
        if(value) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into User Table Successfull")
            }
            else{
                print("Insertion into User Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func updateUserDetails(_ user: User, forId: Int) {
        let query = "UPDATE users SET name = '\(user.name)', password = '\(user.password)', mailId = '\(user.mailId)', DateOfBirth = '\(user.dateOfBirth)' WHERE id = '\(forId)';"

        var updateQueryPointer: OpaquePointer?
        
        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updateQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updateQueryPointer) == SQLITE_DONE){
                print("Updation into User Table Successfull")
            }
            else{
                print("Updation into User Table Failed")
            }
        }

        sqlite3_finalize(updateQueryPointer)
    }
    
    func getAllUserDetails() -> [User] {
        var array: [User] = []
        
        let query = "SELECT * FROM users;"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let password = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let mailId = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let dateOfBirth = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let user = User(id: id,
                                name: name,
                                password: password,
                                mailId: mailId,
                                dateOfBirth: dateOfBirth)
                
                array.append(user)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func getUserDetailForId(_ id: Int) -> User {
        var user: User = User(id: -1, name: "", password: "", mailId: "", dateOfBirth: "")
        
        let query = "SELECT * FROM users WHERE id = '\(id)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let password = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let mailId = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let dateOfBirth = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                user = User(id: id,
                                name: name,
                                password: password,
                                mailId: mailId,
                                dateOfBirth: dateOfBirth)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return user
    }
}
