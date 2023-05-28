//
//  AppointmentsListHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/10/22.
//

import Foundation

class AppointmentsListHelperVC {
    
    var upcomingAppointments: [ConsultationGetter] = []
    var completedAppointments: [ConsultationGetter] = []
    var cancelledAppointments: [ConsultationGetter] = []
    var searchResults: [ConsultationGetter] = []
    
    var selectedState: ConsultationState = .upcoming
    var selectedSortingState: ConsultationSortingType = .dateDescending
    var doctor: Doctor?
    
    weak var delegate: AppointmentListProtocol?
    
    init() {
        
        getAppointments()
    }
    
    func getAppointments() {
        upcomingAppointments = DBManager.sharedInstance.getRowsFromConsultationTable(for: .upcoming, forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        completedAppointments = DBManager.sharedInstance.getRowsFromConsultationTable(for: .completed, forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        cancelledAppointments = DBManager.sharedInstance.getRowsFromConsultationTable(for: .cancelled, forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        print(upcomingAppointments)
        print(completedAppointments)
        print(cancelledAppointments)
        
        sort(by: .dateDescending)
    }
    
    func sort(by state: ConsultationSortingType){
        switch(state){
        case .dateAscending:
            upcomingAppointments = upcomingAppointments.sorted { consultation1, consultation2 in
                guard let dateObj1 = delegate?.formatter.date(from: consultation1.consultationDate ?? ""),
                      let dateObj2 = delegate?.formatter.date(from: consultation2.consultationDate ?? ""),
                      var dateString1 = delegate?.formatter.string(from: dateObj1),
                      var dateString2 = delegate?.formatter.string(from: dateObj2) else {
                    return false
                }
                
                dateString1 = getDateInReversedFormat(dateString1)
                dateString2 = getDateInReversedFormat(dateString2)
                
                return dateString1 < dateString2
            }
            
            completedAppointments = completedAppointments.sorted { consultation1, consultation2 in
                guard let dateObj1 = delegate?.formatter.date(from: consultation1.consultationDate ?? ""),
                      let dateObj2 = delegate?.formatter.date(from: consultation2.consultationDate ?? ""),
                      var dateString1 = delegate?.formatter.string(from: dateObj1),
                      var dateString2 = delegate?.formatter.string(from: dateObj2) else {
                    return false
                }
                
                dateString1 = getDateInReversedFormat(dateString1)
                dateString2 = getDateInReversedFormat(dateString2)
                
                return dateString1 < dateString2
            }
            
            cancelledAppointments = cancelledAppointments.sorted { consultation1, consultation2 in
                guard let dateObj1 = delegate?.formatter.date(from: consultation1.consultationDate ?? ""),
                      let dateObj2 = delegate?.formatter.date(from: consultation2.consultationDate ?? ""),
                      var dateString1 = delegate?.formatter.string(from: dateObj1),
                      var dateString2 = delegate?.formatter.string(from: dateObj2) else {
                    return false
                }
                
                dateString1 = getDateInReversedFormat(dateString1)
                dateString2 = getDateInReversedFormat(dateString2)
                
                return dateString1 < dateString2
            }
            
            if let flag = delegate?.isSearchBarActive, flag == true {
                searchResults = searchResults.sorted { consultation1, consultation2 in
                    guard let dateObj1 = delegate?.formatter.date(from: consultation1.consultationDate ?? ""),
                          let dateObj2 = delegate?.formatter.date(from: consultation2.consultationDate ?? ""),
                          var dateString1 = delegate?.formatter.string(from: dateObj1),
                          var dateString2 = delegate?.formatter.string(from: dateObj2) else {
                        return false
                    }
                    
                    dateString1 = getDateInReversedFormat(dateString1)
                    dateString2 = getDateInReversedFormat(dateString2)
                    
                    return dateString1 < dateString2
                }
            }
        case .dateDescending:
            upcomingAppointments = upcomingAppointments.sorted { consultation1, consultation2 in
                
                guard let dateObj1 = delegate?.formatter.date(from: consultation1.consultationDate ?? ""),
                      let dateObj2 = delegate?.formatter.date(from: consultation2.consultationDate ?? ""),
                      var dateString1 = delegate?.formatter.string(from: dateObj1),
                      var dateString2 = delegate?.formatter.string(from: dateObj2) else {
                    return false
                }
                
                dateString1 = getDateInReversedFormat(dateString1)
                dateString2 = getDateInReversedFormat(dateString2)
                
                print(dateString1," ",dateString2)
                
                return dateString1 > dateString2
            }
            
            completedAppointments = completedAppointments.sorted { consultation1, consultation2 in
                guard let dateObj1 = delegate?.formatter.date(from: consultation1.consultationDate ?? ""),
                      let dateObj2 = delegate?.formatter.date(from: consultation2.consultationDate ?? ""),
                      var dateString1 = delegate?.formatter.string(from: dateObj1),
                      var dateString2 = delegate?.formatter.string(from: dateObj2) else {
                    return false
                }
                
                dateString1 = getDateInReversedFormat(dateString1)
                dateString2 = getDateInReversedFormat(dateString2)
                
                return dateString1 > dateString2
            }
            
            cancelledAppointments = cancelledAppointments.sorted { consultation1, consultation2 in
                guard let dateObj1 = delegate?.formatter.date(from: consultation1.consultationDate ?? ""),
                      let dateObj2 = delegate?.formatter.date(from: consultation2.consultationDate ?? ""),
                      var dateString1 = delegate?.formatter.string(from: dateObj1),
                      var dateString2 = delegate?.formatter.string(from: dateObj2) else {
                    return false
                }
                
                dateString1 = getDateInReversedFormat(dateString1)
                dateString2 = getDateInReversedFormat(dateString2)
                
                return dateString1 > dateString2
            }
            
            print(cancelledAppointments)
            
            if let flag = delegate?.isSearchBarActive, flag == true {
                searchResults = searchResults.sorted { consultation1, consultation2 in
                    guard let dateObj1 = delegate?.formatter.date(from: consultation1.consultationDate ?? ""),
                          let dateObj2 = delegate?.formatter.date(from: consultation2.consultationDate ?? ""),
                          var dateString1 = delegate?.formatter.string(from: dateObj1),
                          var dateString2 = delegate?.formatter.string(from: dateObj2) else {
                        return false
                    }
                    
                    dateString1 = getDateInReversedFormat(dateString1)
                    dateString2 = getDateInReversedFormat(dateString2)
                    
                    return dateString1 > dateString2
                }
            }
        }
        
        print(upcomingAppointments)
    }
    
    func loadSearchResults(forText: String) {
        searchResults = []
        
        switch(selectedState){
        case .upcoming:
            for consultation in upcomingAppointments {
                guard let flag = consultation.doctorName?.lowercased().contains(forText.lowercased()) else {
                    return
                }
                if(flag || forText == ""){
                    searchResults.append(consultation)
                }
            }
        case .completed:
            for consultation in completedAppointments {
                guard let flag = consultation.doctorName?.lowercased().contains(forText.lowercased()) else {
                    return
                }
                if(flag || forText == ""){
                    searchResults.append(consultation)
                }
            }
        case .cancelled:
            for consultation in cancelledAppointments {
                guard let flag = consultation.doctorName?.lowercased().contains(forText.lowercased()) else {
                    return
                }
                if(flag || forText == ""){
                    searchResults.append(consultation)
                }
            }
        }
    }
    
    func updateState(to state: ConsultationState, for consultation: ConsultationGetter){
        DBManager.sharedInstance.updateConsultation(state: state, for: consultation, forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
    
    func getDateInReversedFormat(_ date: String) -> String {
        let dates = date.split(separator: "-").reversed()
        var ans = ""
        
        for (index, val) in dates.enumerated(){
            
            ans+=String(val)
            
            if(index != dates.count - 1){
                ans+="-"
            }
        }
        
        return ans
    }
    
    func getDoctorDetail(forId: Int){
        doctor = DBManager.sharedInstance.getDoctorDetailFromTable(forId: forId)
    }
    
    func removeConsultation(_ consultation: ConsultationGetter) {
        DBManager.sharedInstance.removeConsultation(consultation, forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
    
    func removeConsultations(_ consultations: [ConsultationGetter]) {
        for consultation in consultations {
            removeConsultation(consultation)
        }
    }
}
