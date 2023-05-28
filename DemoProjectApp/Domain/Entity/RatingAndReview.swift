//
//  File.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 10/10/22.
//

import Foundation

struct Ratings {
    let id: Int
    let numberOfFiveStars: Int
    let numberOfFourStars: Int
    let numberOfThreeStars: Int
    let numberOfTwoStars: Int
    let numberOfOneStars: Int
    let category: RatingAndReviewCategory
}

struct Reviews {
    let id: Int
    let title: String
    var body: String
    let numberOfRatingStars: Int
    let dateOfReview: String
    let reviewerName: String
    let category: RatingAndReviewCategory
}
