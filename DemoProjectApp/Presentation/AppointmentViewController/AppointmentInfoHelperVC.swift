//
//  AppointmentInfoHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/10/22.
//

import Foundation

class AppointmentInfoHelperVC {
    
    var doctorDetails: Doctor
    weak var delegate: AppointmentRequirmentProtocol?
    
    init(doctorId: Int) {
        
        self.doctorDetails = DBManager.sharedInstance.getDoctorDetailFromTable(forId: doctorId)
    }
    
    init() {
        doctorDetails = Doctor(id: -1, name: "", imageName: "", designation: .all, experience: "", qualification: "", location: "", languagesKnown: "", availableForAMinimumOf: -1, vedioConsultationCost: -1, hospitalVisitCost: -1, locationImageName: "", locationAddress: "", videoConsultTimings: -1, hospitalTiming: -1, ratings: 0.0, totalNumberOfRaters: -1)
    }
    
    func updateState(to state: ConsultationState, for consultation: ConsultationGetter){
        DBManager.sharedInstance.updateConsultation(state: state, for: consultation, forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
}
