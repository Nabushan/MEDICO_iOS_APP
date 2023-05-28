//
//  PharmacyUpdate.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 12/10/22.
//

import Foundation

enum PharmacyUpdate: Int, RawRepresentable {
    case rating = 0
    case numberOfRating
    
    var dbName: String {
        switch(self){
        case .rating: return "ratingOutOfFive"
        case .numberOfRating: return "totalNumberOfRatings"
        }
    }
}

enum PharmacySortOption: Int, RawRepresentable {
    case nameInAscending
    case nameInDescending
    case ratingInAscending
    case ratingInDescending
}
