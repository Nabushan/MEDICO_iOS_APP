//
//  InformationValueChangeHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import Foundation

class InformationValueChangeHelper {
    weak var delegate: ProfileInformationValueChangeProtocol?
    
    let nameFields = ["First", "Last"]
    let mailFields = ["Mail Id", "Domain"]
    let passwordFields = ["Old", "New"]
    let validators: Validators
    var user: User = User(id: -1, name: "", password: "", mailId: "", dateOfBirth: "")
    
    init() {
        validators = Validators()
        loadUserDetail(forId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
    
    func validateUserName(_ name: String) -> Bool {
        return validators.isContentValid(name)
    }
    
    func validateMailId(_ mailId: String) -> Bool {
        return validators.validateEmailId(mailId)
    }
    
    func updateUserDetail() {
        DBManager.sharedInstance.updateUserDetails(user, forId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
    
    func loadUserDetail(forId: Int) {
        user = DBManager.sharedInstance.getUserDetailForId(forId)
    }
}
