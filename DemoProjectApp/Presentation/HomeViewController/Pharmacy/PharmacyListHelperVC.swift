//
//  PharmacyListHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 11/10/22.
//

import Foundation

class PharmacyListHelperVC {
    
    weak var delegate: PharmacyListProtocol?
    
    var pharmacies: [Pharmacy] = []
    var searchResults: [Pharmacy] = []
    var reviews: [Reviews] = []
    var chosenSortBy: PharmacySortOption = .nameInAscending
    
    init() {
        
        pharmacies = fetchPharmacyDetails()
    }
    
    func fetchPharmacyDetails() -> [Pharmacy] {
        return DBManager.sharedInstance.getRowsFromPharmacyTable()
    }
    
    func loadSearchResults(forText: String){
        searchResults = []
        for pharmacy in pharmacies {
            if(pharmacy.name.lowercased().contains(forText.lowercased()) || forText == ""){
                searchResults.append(pharmacy)
            }
        }
        
        sortSearchResults(by: chosenSortBy)
    }
    
    func sortSearchResults(by option: PharmacySortOption){
        switch(option){
        case .nameInAscending:
            if(delegate?.isSearchActive == true){
                searchResults = searchResults.sorted { $0.name < $1.name }
            }
            else{
                pharmacies = pharmacies.sorted { $0.name < $1.name }
            }
        case .nameInDescending:
            if(delegate?.isSearchActive == true){
                searchResults = searchResults.sorted { $0.name > $1.name }
            }
            else{
                pharmacies = pharmacies.sorted { $0.name > $1.name }
            }
        case .ratingInAscending:
            if(delegate?.isSearchActive == true){
                searchResults = searchResults.sorted { $0.ratingOutOfFive < $1.ratingOutOfFive }
            }
            else{
                pharmacies = pharmacies.sorted { $0.ratingOutOfFive < $1.ratingOutOfFive }
            }
        case .ratingInDescending:
            if(delegate?.isSearchActive == true){
                searchResults = searchResults.sorted { $0.ratingOutOfFive > $1.ratingOutOfFive }
            }
            else{
                pharmacies = pharmacies.sorted { $0.ratingOutOfFive > $1.ratingOutOfFive }
            }
        }
    }
    
    func getPharmacyReviews(reviewId: Int) {
        reviews = DBManager.sharedInstance.getRowsFromReviewTable(forId: reviewId, forCategoryId: RatingAndReviewCategory.pharmacy.rawValue)
    }
}
