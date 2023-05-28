//
//  ConsultationType.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 26/10/22.
//

import Foundation

enum ConsultationPackageType: Int, RawRepresentable {
    case videoConsultation = 0
    case hospitalVisit
    
    var consultationType: String {
        switch(self){
        case .hospitalVisit: return "Hospital Visit"
        case .videoConsultation: return "Video Consultation"
        }
    }
}

enum ConsultationState: Int, RawRepresentable {
    case upcoming = 0
    case completed
    case cancelled
    
    var consultationName: String {
        switch(self){
        case .upcoming: return "Upcoming"
        case .completed: return "Completed"
        case .cancelled: return "Cancelled"
        }
    }
}

enum ConsultationSortingType: Int, RawRepresentable {
    case dateAscending = 0
    case dateDescending
}
