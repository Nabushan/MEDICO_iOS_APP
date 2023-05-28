//
//  HospitalPlaces.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/12/22.
//

import Foundation

enum HospitalLocation: Int, RawRepresentable, CaseIterable {
    case all = 0
    case chennai
    case coimbatore
    case bangalore
    case mumbai
    case hyderabad
    
    var locationName: String {
        switch(self) {
        case .chennai: return "Chennai"
        case .bangalore: return "Bangalore"
        case .coimbatore: return "Coimbatore"
        case .mumbai: return "Mumbai"
        case .hyderabad: return "Hyderabad"
        case .all: return "All"
        }
    }
}
