//
//  ProfileInformation.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import Foundation

enum ProfileInfo: Int {
    case nameAndDetails = 0
    case passwordAndSecurity
    case appearance
    
    var categoryName: String {
        switch(self) {
        case .nameAndDetails: return "Name And Details"
        case .passwordAndSecurity: return "Password And Security"
        case .appearance: return "Appearance"
        }
    }
}

enum ProfileValueChange: Int {
    case userName = 0
    case userMailId
    case userPassword
    
    var categoryName: String {
        switch(self){
        case .userName: return "Name"
        case .userMailId: return "Mail"
        case .userPassword: return "Change Password"
        }
    }
}
