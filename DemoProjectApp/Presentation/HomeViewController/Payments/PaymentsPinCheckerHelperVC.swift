//
//  PaymentsPinCheckerHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/10/22.
//

import Foundation

class PaymentsPinCheckerHelperVC {
    
    weak var delegate: PinCheckerProtocol?
    
    init(){
        
    }
    
    func addConsultation(_ consultation: ConsultationUpdater) {
        DBManager.sharedInstance.addConsultation(consultation)
    }
}
