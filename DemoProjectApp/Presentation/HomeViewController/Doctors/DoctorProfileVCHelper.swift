//
//  DoctorPrifileVCHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/09/22.
//

import Foundation

class DoctorProfileVCHelper {
    
    
    weak var delegate: DoctorProfileVCProtocol?
    
    let doctor: Doctor
    
    var videoConsultTimings: DoctorTiming?
    var hospitalVisitTimings: DoctorTiming?
    var requirments: SeeAllReview?
    
    init(doctor: Doctor) {
        self.doctor = doctor
        
        videoConsultTimings = loadVideoConsultTimings()
        print("Video Consult Timings : ")
//        print(videoConsultTimings)
        
        hospitalVisitTimings = loadHospitalVisitTimings()
        print("Hospital Visit Timings : ")
//        print(hospitalVisitTimings)
        
        loadRequirment()
    }
    
    private func loadVideoConsultTimings() -> DoctorTiming {
        guard let timing = DBManager.sharedInstance.getRowsFromTimingsTable(forTable: .availableVideoCallTimings, index: doctor.videoConsultTimings) else {
            return DoctorTiming(id: 0,
                                monday: "Not Available",
                                tuesday: "Not Available",
                                wednesday: "Not Available",
                                thursday: "Not Available",
                                friday: "Not Available",
                                saturday: "Not Available",
                                sunday: "Not Available")
        }
        
        return timing
    }
    
    private func loadHospitalVisitTimings() -> DoctorTiming {
        guard let timing = DBManager.sharedInstance.getRowsFromTimingsTable(forTable: .availableHospitalTimings, index: doctor.hospitalTiming) else {
            return DoctorTiming(id: 0,
                                monday: "Not Available",
                                tuesday: "Not Available",
                                wednesday: "Not Available",
                                thursday: "Not Available",
                                friday: "Not Available",
                                saturday: "Not Available",
                                sunday: "Not Available")
        }
        
        return timing
    }
    
    func loadRequirment() {
        
        var reviews: [Reviews] = DBManager.sharedInstance.getDoctorReviews(forId: doctor.id)
        var ratings: Ratings = DBManager.sharedInstance.getDoctorRatings(forId: doctor.id)
        var totalRating = 0
        
        var progressBarRatings: [Float] = []
        
        let oneStar = ratings.numberOfOneStars
        let twoStar = ratings.numberOfTwoStars
        let threeStar = ratings.numberOfThreeStars
        let fourStar = ratings.numberOfFourStars
        let fiveStar = ratings.numberOfFiveStars
        
        let totalRatingSum = oneStar + twoStar + threeStar + fourStar + fiveStar
        
        progressBarRatings.append(Float(oneStar)/Float(totalRatingSum))
        progressBarRatings.append(Float(twoStar)/Float(totalRatingSum))
        progressBarRatings.append(Float(threeStar)/Float(totalRatingSum))
        progressBarRatings.append(Float(fourStar)/Float(totalRatingSum))
        progressBarRatings.append(Float(fiveStar)/Float(totalRatingSum))
        
        let totalOneStar = oneStar * 1
        let totalTwoStar = twoStar * 2
        let totalThreeStar = threeStar * 3
        let totalFourStar = fourStar * 4
        let totalFiveStar = fiveStar * 5
        
        totalRating = totalOneStar + totalTwoStar + totalThreeStar + totalFourStar + totalFiveStar
        
        let ratingVal = String(format: "%.1f", (Float(totalRating)/Float(totalRatingSum)))
        
        requirments = SeeAllReview(reviews: reviews,
                                   ratings: [ratings],
                                   userSelectedStarRating: 0,
                                   overAllRating: ratingVal,
                                   progressRatings: progressBarRatings,
                                   totalNumberOfRatings: Int(totalRatingSum),
                                   reviewId: doctor.id)
    }
}
