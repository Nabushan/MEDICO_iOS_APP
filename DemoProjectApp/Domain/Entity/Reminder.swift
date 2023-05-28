//
//  Reminder.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 22/09/22.
//

import Foundation

struct Reminder: Hashable, Comparable {
    static func < (lhs: Reminder, rhs: Reminder) -> Bool {
        lhs.medicineName < rhs.medicineName
    }
    
    let date: String
    let time: String
    let medicineName: String
    let medicineBody: String?
    var status: String
    let medicineType: String
    let foodIntervalToTake: FoodInterval
    let schedule: Schedule
    let userId: Int
    
    init(date: String, time: String, medicineName: String, medicineBody: String, medicineType: String, foodIntervalToTake: FoodInterval, schedule: Schedule, userId: Int){
        self.date = date
        self.time = time
        self.medicineName = medicineName
        self.medicineBody = medicineBody
        self.status = ReminderState.yetToTake.scopeBarName
        self.medicineType = medicineType
        self.foodIntervalToTake = foodIntervalToTake
        self.schedule = schedule
        self.userId = userId
    }
    
    func isEqual(toReminder: Reminder) -> Bool {
        if(self.medicineName == toReminder.medicineName &&
           self.date == toReminder.date &&
           self.time == toReminder.time &&
           self.medicineType == toReminder.medicineType &&
           self.status == toReminder.status &&
           self.userId == toReminder.userId) {
            return true
        }
        return false
    }
}

struct ReminderDateAndTime {
    let date: String
    let time: String
}
