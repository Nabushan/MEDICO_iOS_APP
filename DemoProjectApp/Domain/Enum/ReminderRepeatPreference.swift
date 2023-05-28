//
//  ReminderRepeatPreference.swift
//  Medico
//
//  Created by nabushan-pt5611 on 05/02/23.
//

import Foundation

enum ReminderRepeatPreference:  String, CaseIterable {
    case never = "Never"
    case daily = "Daily"
    case weekdays = "Weekdays"
    case weekends = "Weekends"
    case weekly = "Weekly"
    case biweekly = "Biweekly"
    case monthly = "Monthly"
    case every2Months = "Every 2 months"
    case every3Months = "Every 3 months"
}
