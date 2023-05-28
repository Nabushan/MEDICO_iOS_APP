//
//  BookAppointmentHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/10/22.
//

import Foundation

class BookAppointmentHelperVC {
    
    var hours: [[String]] = []
    var tabHours: [[String]] = []
    var docId = -1
    var docName = ""
    
    let slotData = DoctorSlotTimingsData()
    
    init() {
        
    }
    
    func loadData(packageType: ConsultationPackageType, doctorId: Int, doctorName: String, forDay: DoctorWeekSlotsAvailability) {
        
        var id = -1
        
        switch(packageType) {
        case .hospitalVisit:
            id = getDoctorHospitalVisitTimingIndex(doctorId: doctorId, doctorName: doctorName)
        case .videoConsultation:
            id = getDoctorVideoConsultationTimingIndex(doctorId: doctorId, doctorName: doctorName)
        }
        
        print("Package Type : ", packageType.consultationType)
        print("Id : ", id)
        print("Doctor Name : ", doctorName)
        
        hours = slotData.getPhoneSlotTimings(forDay: forDay, forId: id, forSelectedState: packageType)
        tabHours = slotData.getIPadSlotTimings(forDay: forDay, forId: id, forSelectedState: packageType)
    }
    
    func updateConsutation(date: String, time: String, for consultation: ConsultationUpdater) {
        DBManager.sharedInstance.updateConsultation(date: date, time: time, for: consultation, forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
    
    func getDoctorHospitalVisitTimingIndex(doctorId: Int, doctorName: String) -> Int {
        return DBManager.sharedInstance.getDoctorHospitalTimingsFromDoctorTable(forDoctorName: doctorName, doctorId)
    }
    
    func getDoctorVideoConsultationTimingIndex(doctorId: Int, doctorName: String) -> Int {
        return DBManager.sharedInstance.getDoctorVideoConsultTimingsFromDoctorTable(forDoctorName: doctorName, doctorId)
    }
}
