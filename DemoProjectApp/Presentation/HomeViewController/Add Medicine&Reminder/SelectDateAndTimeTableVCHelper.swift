//
//  SelectDateAndTimeTableVCHelper.swift
//  Medico
//
//  Created by nabushan-pt5611 on 05/02/23.
//

import Foundation
import UIKit

class SelectDateAndTimeTableVCHelper {
    
    var selectDateAndTimeTableTextContents: [[String]] = [["Date", "Time"], ["Repeat (For 1 year)"]]
    var selectDateAndTimeTableImageContents: [[String]] = [["calendar", "clock.fill"], ["repeat"]]
    
    let calender = Calendar.current
    
    weak var delegate: SelectDateAndTimeContentForReminderProtocol?
    
    init() {
        
    }
    
    func getRemindersScheduled(bySelectedState: ReminderRepeatPreference, with datePickerValue: Date, with timePickerValue: Date) -> [ReminderDateAndTime] {
        var array: [ReminderDateAndTime] = []
        
        let reminderDateFormat = "yyyy-MM-dd"
        let reminderTimeFormat = "HH:mm a"
        let weekEndsFormat = "EEEE"
        
        var datePickerDate = datePickerValue
        var datePickerTime = timePickerValue
        
        var year = calender.component(.year, from: datePickerDate)
        let currentYear = calender.component(.year, from: Date.now)
        
        switch(bySelectedState){
        case .never:
            delegate?.dateFormatter.dateFormat = reminderDateFormat
            let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
            
            delegate?.dateFormatter.dateFormat = reminderTimeFormat
            let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
            
            let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
            
            array.append(reminderTime)
        
        case .daily:
            
            while(year <= currentYear) {
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .day, value: 1, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
            
        case .weekdays:
            
            while(year <= currentYear) {
                
                delegate?.dateFormatter.dateFormat = weekEndsFormat
                let day = DoctorWeekSlotsAvailability(rawValue: delegate?.dateFormatter.string(from: datePickerDate) ?? "")
                
                if(day == .sunday || day == .saturday) {
                    guard let nextDate = calender.date(byAdding: .day, value: 1, to: datePickerDate) else {
                        return []
                    }
                    
                    datePickerDate = nextDate
                    
                    year = calender.component(.year, from: datePickerDate)
                    
                    continue
                }
                
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .day, value: 1, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
            
        case .weekends:
            
            var tempDate = datePickerDate
            
            var firstSaturdayDate: Date?
            var firstSundayDate: Date?
            
            while(year <= currentYear) {
                
                if(firstSundayDate != nil && firstSaturdayDate != nil) {
                    break
                }
                
                delegate?.dateFormatter.dateFormat = weekEndsFormat
                let day = DoctorWeekSlotsAvailability(rawValue: delegate?.dateFormatter.string(from: tempDate) ?? "")
                
                if(day == .saturday && firstSaturdayDate == nil) {
                    firstSaturdayDate = tempDate
                }
                
                if(day == .sunday && firstSundayDate == nil) {
                    firstSundayDate = tempDate
                }
                
                guard let nextDate = calender.date(byAdding: .day, value: 1, to: tempDate) else {
                    return []
                }
                
                tempDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
            }
            
            guard var datePickerDate = firstSaturdayDate else {
                return []
            }
            
            while(year <= currentYear) {
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .day, value: 7, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
            
            guard var datePickerDate = firstSundayDate else {
                return []
            }
            
            year = calender.component(.year, from: datePickerDate)
            
            while(year <= currentYear) {
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .day, value: 7, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
            
            
        case .weekly:
            
            while(year <= currentYear) {
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .day, value: 7, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
            
            
        case .biweekly:
            
            while(year <= currentYear) {
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .day, value: 14, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
            
        case .monthly:
            
            while(year <= currentYear) {
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .month, value: 1, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
            
        case .every2Months:
            
            while(year <= currentYear) {
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .month, value: 2, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
            
        case .every3Months:
            
            while(year <= currentYear) {
                delegate?.dateFormatter.dateFormat = reminderDateFormat
                let dateValue = delegate?.dateFormatter.string(from: datePickerDate) ?? ""
                
                delegate?.dateFormatter.dateFormat = reminderTimeFormat
                let timeValue = delegate?.dateFormatter.string(from: datePickerTime) ?? ""
                
                let reminderTime = ReminderDateAndTime(date: dateValue, time: timeValue)
                
                guard let nextDate = calender.date(byAdding: .month, value: 3, to: datePickerDate) else {
                    return []
                }
                
                datePickerDate = nextDate
                
                year = calender.component(.year, from: datePickerDate)
                
                array.append(reminderTime)
            }
        }
        
        return array
    }
}
