//
//  SeeAllReviewsHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/12/22.
//

import Foundation

class SeeAllReviewsHelper {
    
    weak var delegate: SeeAllReviewsProtocol?
    let requirments: SeeAllReview
    let doctor: Doctor?
    
    init(_ requirments: SeeAllReview,_ doctor: Doctor?) {
        self.requirments = requirments
        self.doctor = doctor
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
        
        updateNumberOfRatingStars(toValue: toValue, forColumn: ratingStar, doctorId: requirments.ratings[0].id)
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
        
        updateNumberOfRatingStars(toValue: toValue, forColumn: ratingStar, doctorId: requirments.ratings[0].id)
    }
    
    func addsNewRating(_ newRating: Int) {
        
        var numberOfFiveStars = requirments.ratings[0].numberOfFiveStars
        var numberOfFourStars = requirments.ratings[0].numberOfFourStars
        var numberOfThreeStars = requirments.ratings[0].numberOfThreeStars
        var numberOfTwoStars = requirments.ratings[0].numberOfTwoStars
        var numberOfOneStars = requirments.ratings[0].numberOfOneStars
        
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
        
        guard let doctor = doctor,
              let ratingValue = Double(tempFinalRatingString) else {
            return
        }
        
        updateDoctorRatings(doctor.name, doctor.id, toValue: ratingValue, raters: denominator)
    }
    
    func updateNumberOfRatingStars(toValue: Int, forColumn: RatingStar, doctorId: Int) {
        DBManager.sharedInstance.updateDoctorRatingStarCount(toValue: toValue, forColumn: forColumn, ratingId: doctorId)
    }
    
    func updateDoctorRatings(_ doctorName: String, _ doctorId: Int, toValue: Double, raters: Int) {
        DBManager.sharedInstance.updateDoctorRatings(forDoctorName: doctorName, doctorId: doctorId, toRating: toValue, raters: raters)
    }
}
