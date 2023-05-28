//
//  EmergencyProfileVCHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 04/10/22.
//

import Foundation

class EmergencyProfileVCHelper {
    
    weak var delegate: EmergencyProfileProtocol?
    
    var progressTracker: [String: Bool] = ["DOB" : false, "age" : false, "height" : false, "weight" : false, "bloodGroup" : false]
    
    var emergencyContacts: [EmergencyContact]
    init(){
        emergencyContacts = DBManager.sharedInstance.getRowsFromEmergencyContactTable()
    }
    
    func isContactAlreadyPresent(_ contact: EmergencyContact) -> Bool {
        for emergencyContact in emergencyContacts {
            if(emergencyContact == contact) {
                return true
            }
        }
        return false
    }
    
    func addToEmergencyContactsToTable(_ contact: EmergencyContact){
        guard let delegate = delegate else {
            return
        }
        
        delegate.emergencyContactsTableView.beginUpdates()
        
        let indexPath = IndexPath(row: emergencyContacts.count, section: 0)
        
        delegate.emergencyContactsTableView.insertRows(at: [indexPath], with: .automatic)
        
        emergencyContacts.append(contact)
        
        delegate.emergencyContactsTableView.endUpdates()
        
        DBManager.sharedInstance.addEmergenyContact(contact)
    }
    
    func removeContact(_ contact: EmergencyContact?, index: Int) {
        guard let contact = contact else {
            return
        }
        
        emergencyContacts.remove(at: index)
        
        DBManager.sharedInstance.removeContact(forFirstName: contact.firstName, forLastName: contact.lastName, forNumber: contact.number)
    }
}
