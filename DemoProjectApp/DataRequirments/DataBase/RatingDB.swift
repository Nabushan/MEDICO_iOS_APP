//
//  RatingDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 10/10/22.
//

import Foundation
import SQLite3

class RatingDB {
    func createTable() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS RATINGS (Id INTEGER, NumberOfFiveStars INTEGER, NumberOfFourStars INTEGER, NumberOfThreeStars INTEGER, NumberOfTwoStars INTEGER, NumberOfOneStars INTEGER, CategoryId INTEGER);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Ratings tables")
            return true
        }

        print("Unable to create Ratings table")
        return false
    }
    
    func addRating(_ rating: Ratings){
        let query = "INSERT INTO RATINGS VALUES ('\(rating.id)','\(rating.numberOfFiveStars)','\(rating.numberOfFourStars)','\(rating.numberOfThreeStars)','\(rating.numberOfTwoStars)','\(rating.numberOfOneStars)','\(rating.category.rawValue)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Ratings Table Successfull")
            }
            else{
                print("Insertion into Ratings Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropRatingTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE RATINGS"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Ratings table")
            }
            else{
                print("Failed to dropp Ratings table")
            }
        }
    }
    
    func emptyRatingTable() {
        let query = "DELETE FROM RATINGS;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from ratings table")
            }
            else{
                print("Failed to delete all sample records from ratings table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromRatingTable(forId: Int, forCategoryId: Int) -> [Ratings] {
        var array: [Ratings] = []
        
        let query = "SELECT * FROM RATINGS WHERE Id = '\(forId)' AND CategoryId = '\(forCategoryId)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let numberOfFiveStars = Int(sqlite3_column_int(selectionQueryPointer, 1))
                
                let numberOfFourStars = Int(sqlite3_column_int(selectionQueryPointer, 2))
                
                let numberOfThreeStars = Int(sqlite3_column_int(selectionQueryPointer, 3))
                
                let numberOfTwoStars = Int(sqlite3_column_int(selectionQueryPointer, 4))
                
                let numberOfOneStars = Int(sqlite3_column_int(selectionQueryPointer, 5))
                
                let categoryType = Int(sqlite3_column_int(selectionQueryPointer, 6))
                
                let rating = Ratings(
                    id: id,
                    numberOfFiveStars: numberOfFiveStars,
                    numberOfFourStars: numberOfFourStars,
                    numberOfThreeStars: numberOfThreeStars,
                    numberOfTwoStars: numberOfTwoStars,
                    numberOfOneStars: numberOfOneStars,
                    category: RatingAndReviewCategory(rawValue: categoryType) ?? .pharmacy)
                
                array.append(rating)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    
    func updateStarCount(toValue: Int, forColumn: RatingStar, ratingId: Int, category: RatingAndReviewCategory) {
        
        let query = "UPDATE RATINGS SET \(forColumn.dbName) = '\(toValue)' WHERE Id = '\(ratingId)' AND CategoryId = '\(category.rawValue)';"

        print(query)
    
        var updationQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updationQueryPointer) == SQLITE_DONE){                print("Successfully Updated the Ratings Table")
            }
            else{
                print("Updation of Ratings Table Failed")
            }
        }
    }
}
