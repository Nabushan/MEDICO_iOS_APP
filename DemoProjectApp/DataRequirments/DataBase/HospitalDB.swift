//
//  HospitalDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/12/22.
//

import Foundation
import SQLite3

class HospitalDB {
    func createTable() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS hospitals (id INTEGER, name TEXT, imageLink TEXT, ratings NUMBER, distance NUMBER, address TEXT, place INTEGER, locationLink TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Hospital table")
            return true
        }

        print("Unable to create Hospital table")
        return false
    }
    
    func addToHospitalTable(_ hospital: Hospital) {
        let query = "INSERT INTO hospitals VALUES ('\(hospital.id)', '\(hospital.name)', '\(hospital.imageLink)', '\(hospital.ratings)', '\(hospital.openHours)', '\(hospital.address)', '\(hospital.place.rawValue)', '\(hospital.directionLink)');"
            
        print(query)
        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Hospital DB is Successfull")
            }
            else{
                print("Insertion into Hospital DB Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropHospitalTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE hospitals"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped hospitals table")
            }
            else{
                print("Failed to dropp hospitals table")
            }
        }
    }
    
    func emptyHospitalTable() {
        let query = "DELETE FROM hospitals;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from hospitals table")
            }
            else{
                print("Failed to delete all sample records from hospitals table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromHospitalTable() -> [Hospital] {
        var array: [Hospital] = []
        
        let query = "SELECT * FROM hospitals;"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let imageLink = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let ratings = Double(sqlite3_column_double(selectionQueryPointer, 3))
                
                let openHours = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let address = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let place = Int(sqlite3_column_int(selectionQueryPointer, 6))
                
                let locationLink = String(cString: sqlite3_column_text(selectionQueryPointer, 7))
                
                let hospital = Hospital(id: id,
                                        name: name,
                                        imageLink: imageLink,
                                        ratings: ratings,
                                        openHours: openHours,
                                        address: address,
                                        place: HospitalLocation(rawValue: place) ?? .all,
                                        directionLink: locationLink)
                
                array.append(hospital)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func getHospitalSearchResults(for searchString: String) -> [Hospital] {
        var searchResultPointer: OpaquePointer?
        
        var array: [Hospital] = []
        let query = "SELECT * FROM cart WHERE hospitals LIKE '%\(searchString)%'"
        
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &searchResultPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(searchResultPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(searchResultPointer, 0))
                
                let name = String(cString: sqlite3_column_text(searchResultPointer, 1))
                
                let imageLink = String(cString: sqlite3_column_text(searchResultPointer, 2))
                
                let ratings = Double(sqlite3_column_double(searchResultPointer, 3))
                
                let openHours = String(cString: sqlite3_column_text(searchResultPointer, 4))
                
                let address = String(cString: sqlite3_column_text(searchResultPointer, 5))
                
                let place = Int(sqlite3_column_int(searchResultPointer, 6))
                
                let locationLink = String(cString: sqlite3_column_text(searchResultPointer, 7))
                
                let hospital = Hospital(id: id,
                                        name: name,
                                        imageLink: imageLink,
                                        ratings: ratings,
                                        openHours: openHours,
                                        address: address,
                                        place: HospitalLocation(rawValue: place) ?? .all,
                                        directionLink: locationLink)
                
                array.append(hospital)
            }
        }

        sqlite3_finalize(searchResultPointer)
        return array
    }
}
