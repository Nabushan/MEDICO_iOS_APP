//
//  EmergencyProfile.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 04/10/22.
//

import Foundation

struct EmergencyProfile: EmergencyValueStorageProtocol {
    static var key: String = "UserDefault - EmergencyProfile"
    
    let name: String
    let dateOfBirth: String
    let age: String
    let bloodGroup: String
    let height: String
    let weight: String
}

struct EmergencyContact: Codable, Equatable {
    let firstName: String
    let lastName: String
    let number: String
    let identifier: String
    let profileImage: Data?
}
