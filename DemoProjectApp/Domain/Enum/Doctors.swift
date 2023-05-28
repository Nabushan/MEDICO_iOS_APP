//
//  Doctors.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 29/09/22.
//

import Foundation

enum DoctorSpecialization: Int, RawRepresentable, CaseIterable {
    case all = 0
    case cardiologist
    case nephrologist
    case immunologists 
    case gastroenterologist
    case dentist
    case neurologist
    case orthopaedics
    case dermatologist
    case trichologist
    case gynacologist
    
    var specializationType: String {
        switch(self){
        case .all: return "All Doctors"
        case .cardiologist: return "Cardiologists"
        case .nephrologist: return "Nephrologists"
        case .immunologists: return "Immunologists"
        case .gastroenterologist: return "Gastroenterologists"
        case .dentist: return "Dentists"
        case .neurologist: return "Neurologists"
        case .orthopaedics: return "Orthopaedics"
        case .dermatologist: return "Dermatologists"
        case .trichologist: return "Trichologists"
        case .gynacologist: return "Gynacologists"
        }
    }
}

enum WorkShiftTable: Int, RawRepresentable {
    case availableVideoCallTimings = 0
    case availableHospitalTimings
    
    var tableName: String {
        switch(self){
        case .availableHospitalTimings: return "availableHospitalTimings"
        case .availableVideoCallTimings: return "availableVideoCallTimings"
        }
    }
}

enum DoctorWeekSlotsAvailability: String, RawRepresentable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case sunday = "Sunday"
}
