//
//  WriteAReviewHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 16/12/22.
//

import Foundation

class WriteAReviewHelper {
    
    var doctorName: String = ""
    var doctorId: Int
    var ratings: Ratings?
    var reviews: [Reviews] = []
    
    weak var delegate: WriteAReviewProtocol?
    
    init(doctorId: Int) {
        self.doctorId = doctorId
        
        loadRatings()
        reviews = getDoctorReviews(forId: doctorId)
    }
    
    func loadRatings() {
        ratings = DBManager.sharedInstance.getDoctorRatings(forId: doctorId)
    }
    
    func addReview(_ reviewToBeSent: Reviews, userName: String) {
        for review in reviews {
            if(review.reviewerName == userName) {
                DBManager.sharedInstance.updateDoctorReview(reviewToBeSent, forDoctorId: doctorId)
                return
            }
        }
        
        DBManager.sharedInstance.addDoctorReview(reviewToBeSent)
    }
    
    func getDoctorReviews(forId: Int) -> [Reviews] {
        return DBManager.sharedInstance.getDoctorReviews(forId: forId)
    }
    
    func reduceEarlierRatings(_ previouslySelectedRating: Int, rating: Ratings) {
        
        guard let ratingStar = RatingStar(rawValue: previouslySelectedRating) else {
            return
        }
        
        var toValue = 0
        
        switch(ratingStar){
        case .noRating:
            return
        case .fiveStar:
            toValue = rating.numberOfFiveStars - 1
        case .fourStar:
            toValue = rating.numberOfFourStars - 1
        case .threeStar:
            toValue = rating.numberOfThreeStars - 1
        case .twoStar:
            toValue = rating.numberOfTwoStars - 1
        case .oneStar:
            toValue = rating.numberOfOneStars - 1
        }
        
        updateNumberOfRatingStars(toValue: toValue, forColumn: ratingStar, doctorId: ratings?.id ?? -1)
    }
    
    func updatePresentRatings(_ currentSelectedRating: Int, rating: Ratings) {
        guard let ratingStar = RatingStar(rawValue: currentSelectedRating) else {
            return
        }
        
        var toValue = 0
        
        switch(ratingStar){
        case .noRating:
            return
        case .fiveStar:
            toValue = rating.numberOfFiveStars + 1
        case .fourStar:
            toValue = rating.numberOfFourStars + 1
        case .threeStar:
            toValue = rating.numberOfThreeStars + 1
        case .twoStar:
            toValue = rating.numberOfTwoStars + 1
        case .oneStar:
            toValue = rating.numberOfOneStars + 1
        }
        
        updateNumberOfRatingStars(toValue: toValue, forColumn: ratingStar, doctorId: ratings?.id ?? -1)
    }
    
    func addsNewRating(_ newRating: Int, userName: String) {
        guard let rating = ratings else {
            return
        }
        
        for review in reviews {
            if(review.reviewerName == userName) {
                reduceEarlierRatings(review.numberOfRatingStars, rating: rating)
                break
            }
        }
        updatePresentRatings(newRating, rating: rating)
        loadRatings()
        
        guard let tempRatings = ratings else {
            return
        }
        
        var numberOfFiveStars = tempRatings.numberOfFiveStars
        var numberOfFourStars = tempRatings.numberOfFourStars
        var numberOfThreeStars = tempRatings.numberOfThreeStars
        var numberOfTwoStars = tempRatings.numberOfTwoStars
        var numberOfOneStars = tempRatings.numberOfOneStars
        
        switch(newRating){
        case 1:
            numberOfOneStars+=1
        case 2:
            numberOfTwoStars+=1
        case 3:
            numberOfThreeStars+=1
        case 4:
            numberOfFourStars+=1
        case 5:
            numberOfFiveStars+=1
        default:
            return
        }
        
        let denominator = numberOfOneStars+numberOfTwoStars+numberOfThreeStars+numberOfFourStars+numberOfFiveStars
        
        let totalOneStars = numberOfOneStars*1
        let totalTwoStars = numberOfTwoStars*2
        let totalThreeStars = numberOfThreeStars*3
        let totalFourStars = numberOfFourStars*4
        let totalFiveStars = numberOfFiveStars*5
        
        let numerator = totalOneStars+totalTwoStars+totalThreeStars+totalFourStars+totalFiveStars
        
        let tempFinalRating = Double(numerator)/Double(denominator)
        let tempFinalRatingString = String(format: "%.1f", tempFinalRating)
        
        guard let ratingValue = Double(tempFinalRatingString) else{
            return
        }
        
        updateDoctorRatings(doctorName, doctorId, toValue: ratingValue, raters: denominator)
    }
    
    func updateDoctorRatings(_ doctorName: String, _ doctorId: Int, toValue: Double, raters: Int) {
        DBManager.sharedInstance.updateDoctorRatings(forDoctorName: doctorName, doctorId: doctorId, toRating: toValue, raters: raters)
    }
    
    func updateNumberOfRatingStars(toValue: Int, forColumn: RatingStar, doctorId: Int) {
        DBManager.sharedInstance.updateDoctorRatingStarCount(toValue: toValue, forColumn: forColumn, ratingId: doctorId)
    }
}
