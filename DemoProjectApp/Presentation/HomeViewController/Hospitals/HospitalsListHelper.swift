//
//  HospitalsListHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/12/22.
//

import Foundation

class HospitalsListHelper {
    
    weak var delegate: HospitalsListingProtocol?
    var hospitals: [Hospital] = []
    var tempHospitals: [Hospital] = []
    var searchedHospitals: [Hospital] = []
    var selectedState: HospitalLocation = .all
    var pickerData: [String] = []
    
    init() {
        loadHospitals()
        loadPickerData()
    }
    
    func loadHospitals() {
        hospitals = DBManager.sharedInstance.getRowsFromHospitalTable()
        tempHospitals = hospitals
    }
    
    func loadPickerData() {
        for hospital in HospitalLocation.allCases {
            pickerData.append(hospital.locationName)
        }
    }
    
    func getSearchResults(forText: String) {
        searchedHospitals = []
        
        for hospital in tempHospitals {
            let textToSearch = hospital.name
            
            if(textToSearch.count < forText.count) {
                continue
            }
            
            let range = textToSearch.index(forText.startIndex, offsetBy: 0)..<textToSearch.index(forText.endIndex, offsetBy: 0)
            
            if(textToSearch[range] == forText && (selectedState == .all || selectedState == hospital.place)) {
                searchedHospitals.append(hospital)
            }
        }
    }
    
    func getFilteredResults() {
        tempHospitals = []
        
        for hospital in hospitals {
            if(selectedState == .all || hospital.place == selectedState) {
                tempHospitals.append(hospital)
            }
        }
    }
}
