//
//  EmergencyVCHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 03/10/22.
//

import Foundation

class EmergencyVCHelper {
    
    weak var delegate: EmergencyProtocol?
    
    var imageNames: [String] = []
    var reasons: [String] = [
        "I incurred a Cardiac arrest","I had a snake bite","I had an accident", "I have an injury", "I'm feeling zoned out",
    ]
    
    var emergencyNumbers: [String] = []
    
    init(){
        imageNames = getEmergencyImages()
        emergencyNumbers = getEmergencyContactNumbers()
    }
    
    private func getEmergencyImages() -> [String] {
        return DBManager.sharedInstance.getRowsFromImagesTable(forCategory: .emergency)
    }
    
    private func getEmergencyContactNumbers() -> [String] {
        return DBManager.sharedInstance.getEmergencyContactNumbers()
    }
    
    func updateStoredContactNumbers() {
        emergencyNumbers = getEmergencyContactNumbers()
    }
}
