//
//  Doctors.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 29/09/22.
//

import Foundation

struct Doctor {
    let id: Int
    let name: String
    let imageName: String
    let designation: DoctorSpecialization
    let experience: String
    let qualification: String
    let location: String
    let languagesKnown: String
    let availableForAMinimumOf: Int
    let vedioConsultationCost: Int
    let hospitalVisitCost: Int
    let locationImageName: String
    let locationAddress: String
    
    let videoConsultTimings: Int
    let hospitalTiming: Int
    
    let ratings: Double
    let totalNumberOfRaters: Int
}

struct DoctorTiming {
    let id: Int
    let monday: String
    let tuesday: String
    let wednesday: String
    let thursday: String
    let friday: String
    let saturday: String
    let sunday: String
}

struct DoctorReviewAndRating {
    let review: Reviews
    let rating: Ratings
}
