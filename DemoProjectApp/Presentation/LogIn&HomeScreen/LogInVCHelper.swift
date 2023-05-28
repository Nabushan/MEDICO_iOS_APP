//
//  LogInVCHelper.swift
//  Medico
//
//  Created by nabushan-pt5611 on 21/01/23.
//

import Foundation

class LogInVCHelper {
    var users: [User] = []
    
    init() {
        loadUserDetails()
    }
    
    func loadUserDetails() {
        users = DBManager.sharedInstance.getAllUserDetails()
    }
    
    func addNewUser(_ user: User) {
        DBManager.sharedInstance.addUserDetails(user)
    }
}
