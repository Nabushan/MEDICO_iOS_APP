//
//  PharmacyWriteAReviewHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 11/10/22.
//

import Foundation

class PharmacyWriteAReviewHelperVC {
    
    
    weak var delegate: PharmacyWriteAReviewProtocol?
    
    init() {
        
    }
    
    func addReviewToReviewDB(_ review: Reviews) {
        DBManager.sharedInstance.addReview(review)
    }
    
    func updateReview(for reviewerName: String,to newReview: Reviews, forPharmacyId: Int) {
        DBManager.sharedInstance.updateReview(for: reviewerName, to: newReview, forPharmacyId: forPharmacyId)
    }
}
