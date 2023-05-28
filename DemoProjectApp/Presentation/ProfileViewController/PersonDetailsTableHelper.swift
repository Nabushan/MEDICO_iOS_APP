//
//  PersonDetailsTableHelper.swift
//  Medico
//
//  Created by nabushan-pt5611 on 01/02/23.
//

import Foundation

class PersonDetailsTableHelper {
    
    weak var delegate: PersonDetailsProtocol?
    var personDetails: [Person] = []
    
    var detailsPlaceHolder = ["Name", "Date Of Birth", "Gender"]
    var genderChoice = ["Male", "Female", " Other"]
    let validators = Validators()
    
    init() {
        loadPersonDetails()
    }
    
    func loadPersonDetails() {
        personDetails = DBManager.sharedInstance.getAllPersonDetails()
    }
    
    func validate(_ person: Person) -> AlertMessage {
        var alertMessage = AlertMessage(state: false, title: "", body: "")
        
        if(person.name.count == 0) {
            alertMessage.title = "Name Field Empty"
            alertMessage.body = "Please make sure that the name field is filled."
        }
        else if(person.dateOfBirth.count == 0) {
            alertMessage.title = "Date Of Birth Field Empty"
            alertMessage.body = "Please make sure that the Date Of Birth field is filled."
        }
        else if(person.gender.count == 0) {
            alertMessage.title = "Gender Field Empty"
            alertMessage.body = "Please make sure that the Gender field is filled."
        }
        else if(!validators.isContentValid(person.name)) {
            alertMessage.title = "Invalid Content"
            alertMessage.body = "Please make sure that the name field contains proper valid content"
        }
        else{
            alertMessage.state = true
            alertMessage.title = "Data Saved Successfully"
            alertMessage.body = "The entered data has been saved successfully"
        }
        
        return alertMessage
    }
    
    func addPersonDetails(_ person: Person) {
        DBManager.sharedInstance.addPersonDetails(person)
    }
    
    func updatePersonDetails(_ person: Person, forId: Int) {
        DBManager.sharedInstance.updatePersonDetails(person, forId: forId)
    }
    
    func removePersonDetails(forId: Int) {
        DBManager.sharedInstance.removePersonDetail(forId: forId)
        personDetails.remove(at: forId)
    }
}
