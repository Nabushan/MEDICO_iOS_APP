//
//  Rating.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 07/10/22.
//

import Foundation

enum Rating: Int, RawRepresentable {
    case noRating = 0
    case extremelyPoor
    case poor
    case medium
    case good
    case wonderful
    
    var ratingDescription: String {
        let description: String = "This product has been rated to be "
        switch(self){
        case .noRating: return "This has not been rated yet."
        case .extremelyPoor: return description+"extremely poor"
        case .poor: return description+"poor"
        case .medium: return description+"medium"
        case .good: return description+"good"
        case .wonderful: return description+"wonderful"
        }
    }
    
    var doctorRatingDescription: String {
        switch(self) {
        case .noRating: return "Not yet rated"
        case .extremelyPoor: return "Extremely poor"
        case .poor: return "Poor"
        case .medium: return "Medium"
        case .good: return "Good"
        case .wonderful: return "Wonderful"
        }
    }
    
    var ratingCount: Int {
        switch(self){
        case .noRating: return 0
        case .extremelyPoor: return 1
        case .poor: return 2
        case .medium: return 3
        case .good: return 4
        case .wonderful: return 5
        }
    }
}

enum RatingAndReviewCategory: Int, RawRepresentable {
    case pharmacy = 0
    case doctor
    
    var name: String{
        switch(self){
        case .pharmacy: return "Pharmacy"
        case .doctor: return "Doctor"
        }
    }
}
