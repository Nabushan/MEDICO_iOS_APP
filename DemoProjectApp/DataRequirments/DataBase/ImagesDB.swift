//
//  ImagesDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 03/10/22.
//

import Foundation
import SQLite3

class ImagesDB {
    func createTable() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS images (Category TEXT, Link TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Images tables")
            return true
        }

        print("Unable to create Images table")
        return false
    }
    
    func addImage(category: ImageCategory, link: String){
        let query = "INSERT INTO images VALUES ('\(category.name)','\(link)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Images is Successfull")
            }
            else{
                print("Insertion into Images has failed Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropImagesTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE images"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Images table")
            }
            else{
                print("Failed to drop Images table")
            }
        }
    }
    
    func emptyImagesTable() {
        let query = "DELETE FROM images;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Images table")
            }
            else{
                print("Failed to delete all sample records from Images table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromImagesTable(forCategory: ImageCategory) -> [String] {
        var array: [String] = []
        
        let query = "SELECT * FROM images WHERE Category = '\(forCategory.name)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let link = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                array.append(link)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func getImages(forCategory: ImageCategory) {
        
    }
}
