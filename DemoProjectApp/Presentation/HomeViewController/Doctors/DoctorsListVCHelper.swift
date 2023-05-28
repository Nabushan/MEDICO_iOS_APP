//
//  DoctorsListVCHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 29/09/22.
//

import Foundation

class DoctorsListVCHelper {
    
    var doctors: [Doctor] = []
    var tempDoctors: [Doctor] = []
    var doctorsCount: [Int] = []
    
    var doctorCategories: [String] = []
    
    var initialDoctorListCount = 0
    
    var selectedDesignatedState: DoctorSpecialization
    
    weak var delegate: DoctorListVCProtocol?
    
    init(selectedState: DoctorSpecialization) {
        selectedDesignatedState = selectedState
        getDoctorCategories()
        getDoctorDetails()
        getDoctorsCount()
        
        loadDetails(forSearchText: "", designation: selectedDesignatedState)
    }
    
    private func getDoctorCategories() {
        for docCategory in DoctorSpecialization.allCases {
            doctorCategories.append(docCategory.specializationType)
        }
    }
    
    private func getDoctorDetails() {
        doctors = DBManager.sharedInstance.getRowsFromDoctorTable()
    }
    
    func loadDetails(forSearchText: String, designation: DoctorSpecialization) {
        tempDoctors = DBManager.sharedInstance.getDoctorSearchResults(for: forSearchText, designation: designation)
        
        for doctor in tempDoctors {
            print(doctor)
        }
    }
    
    private func getDoctorsCount() {
        for _ in 0..<11{
            doctorsCount.append(0)
        }
        
        doctorsCount[0] = doctors.count
        
        for doctor in doctors {
            doctorsCount[doctor.designation.rawValue]+=1
        }
    }
}
