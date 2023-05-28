//
//  InformationDetailHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import Foundation

class InformationDetailHelper {
    
    weak var delegate: ProfileIndividualInformationProtocol?
    
    let nameAndOtherSectionHeaders = ["Name", "Contactable at", ""]
    let passwordAndOtherSections = ["Change Password"]
    let appearance = ["System", "Dark", "Light"]
    var user: User = User(id: -1, name: "", password: "", mailId: "", dateOfBirth: "")
    
    let nameAndOtherSectionFooters = ["", "This email address will be used to contact you via Mail and more", ""]
    init() {
        loadUserDetail(forId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
    
    func updateUserDetail() {
        DBManager.sharedInstance.updateUserDetails(user, forId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
    
    func loadUserDetail(forId: Int) {
        user = DBManager.sharedInstance.getUserDetailForId(forId)
    }
}
