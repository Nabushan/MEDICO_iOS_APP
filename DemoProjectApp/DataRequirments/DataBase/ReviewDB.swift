//
//  ReviewDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 10/10/22.
//

import Foundation
import SQLite3

class ReviewsDB {
    func createTable() -> Bool {
        
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS REVIEWS (Id INTEGER, ReviewerName TEXT, DateOfReview TEXT, NumberOfStarsGiven INTEGER, Title TEXT, Body TEXT, Category INTEGER);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Review tables")
            return true
        }

        print("Unable to create Review table")
        return false
    }
    
    func addReview(_ review: Reviews){
        let query = "INSERT INTO REVIEWS VALUES ('\(review.id)','\(review.reviewerName)','\(review.dateOfReview)','\(review.numberOfRatingStars)','\(review.title)','\(review.body)','\(review.category.rawValue)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Review Table Successfull")
            }
            else{
                print("Insertion into Review Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropReviewTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE REVIEWS"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Review table")
            }
            else{
                print("Failed to dropp Review table")
            }
        }
    }
    
    func emptyReviewTable() {
        let query = "DELETE FROM REVIEWS;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Review table")
            }
            else{
                print("Failed to delete all sample records from Review table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromReviewTable(forId: Int, forCategoryId: Int) -> [Reviews] {
        var array: [Reviews] = []
        
        let query = "SELECT * FROM REVIEWS WHERE Id = '\(forId)' AND Category = '\(forCategoryId)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let reviewerName = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let dateOfReview = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let numberOfStarsGiven = Int(sqlite3_column_int(selectionQueryPointer, 3))
                
                let title = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let body = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let category = Int(sqlite3_column_int(selectionQueryPointer, 6))
                
                let review = Reviews(
                    id: id,
                    title: title,
                    body: body,
                    numberOfRatingStars: numberOfStarsGiven,
                    dateOfReview: dateOfReview,
                    reviewerName: reviewerName,
                    category: RatingAndReviewCategory(rawValue: category) ?? .pharmacy)
                
                array.append(review)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func updateReview(for reviewerName: String,to newReview: Reviews, forPharmacyId: Int) {
        var updatePointer: OpaquePointer?
        
        print(newReview)
        
        let query = "UPDATE REVIEWS SET DateOfReview = '\(newReview.dateOfReview)', NumberOfStarsGiven = '\(newReview.numberOfRatingStars)', Title = '\(newReview.title)', Body = '\(newReview.body)' WHERE ReviewerName = '\(reviewerName)' AND Id = '\(forPharmacyId)'"
        
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &updatePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updatePointer) == SQLITE_DONE) {
                print("Previous Review Updated successfully.")
            }
            else{
                print("Review state updation failed.")
            }
        }
    }
}
