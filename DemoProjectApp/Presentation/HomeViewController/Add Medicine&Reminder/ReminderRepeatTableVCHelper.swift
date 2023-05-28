//
//  ReminderRepeatTableVCHelper.swift
//  Medico
//
//  Created by nabushan-pt5611 on 05/02/23.
//

import Foundation

class ReminderRepeatTableVCHelper {
    weak var delegate: ReminderRepeatProtocol?
    
    var selectedState: ReminderRepeatPreference = .never
    
    var options: [String] = []
    
    init() {
        for caseVal in ReminderRepeatPreference.allCases {
            options.append(caseVal.rawValue)
        }
    }
}
