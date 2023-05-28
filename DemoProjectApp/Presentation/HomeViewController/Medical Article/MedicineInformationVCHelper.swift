//
//  MedicineInformationVCHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/09/22.
//

import Foundation

class MedicineInformationVCHelper {
    weak var delegate: MedicineInformationVCProtocol?
    
    init(){
        
    }
    
    func changeStateToCompleted(forReminder: Reminder) {
        print(forReminder)
        DBManager.sharedInstance.updateReminderDetails(.status, from: forReminder.status, to: "COMPLETED", reminder: forReminder)
    }
    
    func deleteReminder(_ reminder: Reminder){
        DBManager.sharedInstance.deleteReminders([reminder])
    }
}
