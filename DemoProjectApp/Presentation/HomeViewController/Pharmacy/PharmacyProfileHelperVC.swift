//
//  PharmacyProfileHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 07/10/22.
//

import UIKit

class PharmacyProfileHelperVC {

    var topCellsToRound = 0
    var bottomCellsToRound = 0
    var incrementBy = 3
    
    var topCellToRoundIndices: [Int] = []
    var bottomCellToRoundIndices: [Int] = []
    
    weak var delegate: PharmacyProfileProtocol?
    
    var reviews: [Reviews] = []
    var ratings: [Ratings] = []
    var products: [PharmacyProduct] = []
    var overAllRating: String = ""
    var progressRatings: [Float] = [0.0,0.0,0.0,0.0,0.0]
    var reviewId: Int = 0
    var ratingId: Int = 0
    var productId: Int = 0
    var pharmacyId: Int = 0
    var totalRatings: Int = 0
    
    init(reviewId: Int, ratingId: Int, productId: Int, pharmacyId: Int) {
        self.reviewId = reviewId
        self.ratingId = ratingId
        self.productId = productId
        self.pharmacyId = pharmacyId
        
        fetchReviews()
        fetchRatings()
        fetchProducts()
        
        overAllRating = getOverAllRating()
        calculateProgressRatings()
    }
    
    func fetchReviews() {
        reviews = DBManager.sharedInstance.getRowsFromReviewTable(forId: reviewId, forCategoryId: RatingAndReviewCategory.pharmacy.rawValue)
    }
    
    func fetchRatings() {
        ratings = DBManager.sharedInstance.getRowsFromRatingTable(forId: ratingId, forCategoryId: RatingAndReviewCategory.pharmacy.rawValue)
    }
    
    func fetchProducts() {
        products = DBManager.sharedInstance.getRowsFromProductTable(forPharmacyId: pharmacyId, forProductId: nil)
    }
    
    func restoreToDefaults(incrementBy: Int) {
        topCellsToRound = 0
        self.incrementBy = incrementBy
        bottomCellsToRound = self.incrementBy - 1
        
        topCellToRoundIndices = []
        bottomCellToRoundIndices = []
    }
    
    func isPresent(value: Int ,in array: [Int]) -> Bool{
        for val in array {
            if(value == val){
                return true
            }
        }
        
        return false
    }
    
    func getOverAllRating() -> String {
        print("Ratings count : ",ratings.count)
        if(ratings.count > 0){
            let rating = ratings[0]
            
            let totalFiveStars = rating.numberOfFiveStars * 5
            let totalFourStars = rating.numberOfFourStars * 4
            let totalThreeStars = rating.numberOfThreeStars * 3
            let totalTwoStars = rating.numberOfTwoStars * 2
            let totalOneStars = rating.numberOfOneStars * 1
            
            let totalStars = rating.numberOfFiveStars + rating.numberOfFourStars + rating.numberOfThreeStars + rating.numberOfTwoStars + rating.numberOfOneStars
            
            totalRatings = totalStars
            
            let numerator = totalFiveStars + totalFourStars + totalThreeStars + totalTwoStars + totalOneStars
            
            print("numerator : ", numerator)
            print("denominator : ", totalStars)
            print(Double(numerator)/Double(totalStars))
            
            return String(format: "%.1f", Double(numerator)/Double(totalStars))
        }
        return "0.0"
    }
    
    func calculateProgressRatings() {
        if(ratings.count > 0){
            let rating = ratings[0]
            
            let totalStars = rating.numberOfFiveStars + rating.numberOfFourStars + rating.numberOfThreeStars + rating.numberOfTwoStars + rating.numberOfOneStars
            
            progressRatings[4] = Float(rating.numberOfFiveStars)/Float(totalStars)
            progressRatings[3] = Float(rating.numberOfFourStars)/Float(totalStars)
            progressRatings[2] = Float(rating.numberOfThreeStars)/Float(totalStars)
            progressRatings[1] = Float(rating.numberOfTwoStars)/Float(totalStars)
            progressRatings[0] = Float(rating.numberOfOneStars)/Float(totalStars)
        }
    }
    
    func updateTheCountTable(for userSelectedStarRating: Int) {
        var starFieldToUpdate: Int = 0
        switch(userSelectedStarRating) {
        case 1:
            starFieldToUpdate = ratings[0].numberOfOneStars
        case 2:
            starFieldToUpdate = ratings[0].numberOfTwoStars
        case 3:
            starFieldToUpdate = ratings[0].numberOfThreeStars
        case 4:
            starFieldToUpdate = ratings[0].numberOfFourStars
        case 5:
            starFieldToUpdate = ratings[0].numberOfFiveStars
        default:
            return
        }
        
        starFieldToUpdate+=1
        DBManager.sharedInstance.updateStarCount(
            toValue: starFieldToUpdate,
            forColumn: RatingStar(rawValue: userSelectedStarRating) ?? .noRating,
            ratingId: ratingId,
            category: RatingAndReviewCategory.pharmacy)
    }
    
    func updateDB(forRow: Int, updateColumn: PharmacyUpdate, toValue: Int){
        DBManager.sharedInstance.updatePharmacyDetails(forRow: forRow, updateColumn: updateColumn, toValue: toValue)
    }
}
