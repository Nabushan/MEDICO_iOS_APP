//
//  RatingStar.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 11/10/22.
//

import Foundation

enum RatingStar: Int, RawRepresentable {
    case noRating = 0
    case oneStar
    case twoStar
    case threeStar
    case fourStar
    case fiveStar
    
    var dbName: String {
        switch(self){
        case .noRating: return ""
        case .fiveStar: return "NumberOfFiveStars"
        case .fourStar: return "NumberOfFourStars"
        case .threeStar: return "NumberOfThreeStars"
        case .twoStar: return "NumberOfTwoStars"
        case .oneStar: return "NumberOfOneStars"
        }
    }
}
