//
//  ReminderVCHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/09/22.
//

import Foundation
import UIKit

class ReminderVCHelper {
    
    var delegate: ReminderListVCProtocol?
    
    var dates: Set = DBManager.sharedInstance.getAvailableDates(forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
    var sortedDates: [String] = []
    var futureDates: [String] = []
    var futureDatesBackUp: [String] = []
    
    var multipleSelectedRemindersToDelete: [Reminder] = []
    
    var yetToTakeReminders: [[Reminder]] = []
    
    var missedReminders: [[Reminder]] = []
    
    var completedReminders: [[Reminder]] = []
    
    var allMedicines: [[Reminder]] = []
    
    var tempYetToTakeMedicines: [[Reminder]] = []
    
    var tempMissedReminders: [[Reminder]] = []
    
    var tempCompletedReminders: [[Reminder]] = []
    
    var tempAllMedicines: [[Reminder]] = []
    
    var previousStatus: ReminderState = .yetToTake
    var status: ReminderState = .yetToTake
    
    var selectedRemindersToDelete: Set<Reminder> = []
    
    init(){
        
        getData()
    }
    
    func getData() {
        sortedDates = dates.sorted()
        
        let date = Date.now.description
        let userId = UserDefaults.standard.integer(forKey: "User - Id")
        
        let dateRange = date.index(date.startIndex, offsetBy: 0)...date.index(date.startIndex, offsetBy: 9)
        let currentDate = date[dateRange]
        
        for dates in sortedDates {
            if(dates >= currentDate){
                futureDates.append(dates)
                yetToTakeReminders.append(DBManager.sharedInstance.getReminderSearchResults(forString: "", status: .yetToTake, forDate: dates, forUserId: userId))
            }
            
            missedReminders.append(DBManager.sharedInstance.getReminderSearchResults(forString: "", status: .missed, forDate: dates, forUserId: userId))
            
            completedReminders.append(DBManager.sharedInstance.getReminderSearchResults(forString: "", status: .completed, forDate: dates, forUserId: userId))
            
            allMedicines.append(DBManager.sharedInstance.getReminderSearchResults(forString: "", status: .all, forDate: dates, forUserId: userId))
        }
        
        futureDatesBackUp = futureDates
        
        yetToTakeReminders = dropEmptySections(yetToTakeReminders, forSortedDate: false)
        missedReminders = dropEmptySections(missedReminders, forSortedDate: true)
        completedReminders = dropEmptySections(completedReminders, forSortedDate: true)
        allMedicines = dropEmptySections(allMedicines, forSortedDate: true)
    }
    
    func loadSearchResults(searchText: String) {
        sortedDates = dates.sorted()
        tempAllMedicines = []
        tempMissedReminders = []
        tempYetToTakeMedicines = []
        tempCompletedReminders = []
        
        let userId = UserDefaults.standard.integer(forKey: "User - Id")
        
        for date in sortedDates {
            switch(status){
            case .all:
                tempAllMedicines.append(DBManager.sharedInstance.getReminderSearchResults(forString: searchText, status: status, forDate: date, forUserId: userId))
            
            case .completed:
                tempCompletedReminders.append(DBManager.sharedInstance.getReminderSearchResults(forString: searchText, status: status, forDate: date, forUserId: userId))
                
            case .missed:
                tempMissedReminders.append(DBManager.sharedInstance.getReminderSearchResults(forString: searchText, status: status, forDate: date, forUserId: userId))
                
            case .yetToTake:
                tempYetToTakeMedicines.append(DBManager.sharedInstance.getReminderSearchResults(forString: searchText, status: status, forDate: date, forUserId: userId))
            }
        }
        
        
        switch(status){
            case .all:
                tempAllMedicines = dropEmptySections(tempAllMedicines, forSortedDate: true)
            case .completed:
                tempCompletedReminders = dropEmptySections(tempCompletedReminders, forSortedDate: true)
            case .missed:
                tempMissedReminders = dropEmptySections(tempMissedReminders, forSortedDate: true)
            case .yetToTake:
                tempYetToTakeMedicines = dropEmptySections(tempYetToTakeMedicines, forSortedDate: true)
        }
    }
    
    func fetchYetToTakeRemindersForFutureDates() {
        yetToTakeReminders = []
        futureDates = futureDatesBackUp
        for date in futureDates {
            yetToTakeReminders.append(DBManager.sharedInstance.getReminderSearchResults(forString: "", status: .yetToTake, forDate: date, forUserId: UserDefaults.standard.integer(forKey: "User - Id")))
        }
        
        yetToTakeReminders = dropEmptySections(yetToTakeReminders, forSortedDate: false)
    }
    
    func fetchMissedRemindersForDates() {
        missedReminders = []
        sortedDates = dates.sorted()
        for date in sortedDates {
            missedReminders.append(DBManager.sharedInstance.getReminderSearchResults(forString: "", status: .missed, forDate: date, forUserId: UserDefaults.standard.integer(forKey: "User - Id")))
        }
        
        missedReminders = dropEmptySections(missedReminders, forSortedDate: true)
    }
    
    func fetchCompletedRemindersForDates() {
        completedReminders = []
        sortedDates = dates.sorted()
        for date in sortedDates {
            completedReminders.append(DBManager.sharedInstance.getReminderSearchResults(forString: "", status: .completed, forDate: date, forUserId: UserDefaults.standard.integer(forKey: "User - Id")))
        }
        
        completedReminders = dropEmptySections(completedReminders, forSortedDate: true)
    }
    
    func fetchAllRemindersForDates() {
        allMedicines = []
        sortedDates = dates.sorted()
        for date in sortedDates {
            allMedicines.append(DBManager.sharedInstance.getReminderSearchResults(forString: "", status: .all, forDate: date, forUserId: UserDefaults.standard.integer(forKey: "User - Id")))
        }
        
        allMedicines = dropEmptySections(allMedicines, forSortedDate: true)
        
        print(allMedicines)
    }
    
    func dropEmptySections(_ inputArray: [[Reminder]], forSortedDate: Bool) -> [[Reminder]] {
        var indicesToDrop: [Int] = []
        sortedDates = dates.sorted()
        var arrays = inputArray
        
        for index in 0..<arrays.count {
//            print(arrays[index])
            if(arrays[index].count == 0){
                indicesToDrop.append(index)
            }
        }
        
        indicesToDrop = indicesToDrop.reversed()
        for index in indicesToDrop {
            if(forSortedDate){
                sortedDates.remove(at: index)
            }
            else{
                futureDates.remove(at: index)
            }
            arrays.remove(at: index)
        }
        
        return arrays
    }
    
    func highlight(fromSource: String, toTarget: String) -> NSMutableAttributedString {
        let fromSourceCnt = fromSource.count
        
        var indices: [Int] = []
        
        for index in 0..<toTarget.count - fromSourceCnt + 1 {
            let range = toTarget.index(toTarget.startIndex, offsetBy: index)..<toTarget.index(toTarget.startIndex, offsetBy: index + fromSourceCnt)
            
            if(toTarget[range].lowercased() == fromSource.lowercased()){
                indices.append(index)
            }
        }
        
        let attributedString = NSMutableAttributedString(string: toTarget)
        
        for index in indices {
            attributedString.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: NSRange(location: index, length: fromSourceCnt))
        }
        
        return attributedString
    }
    
    func getCount(of arrays: [[Reminder]]) -> Int {
        var count = 0
        
        for array in arrays {
            count+=array.count
        }
        
        return count
    }
    
    func changeStateToCompleted(forReminder: Reminder) {
        print(forReminder)
        DBManager.sharedInstance.updateReminderDetails(.status, from: forReminder.status, to: "COMPLETED", reminder: forReminder)
    }
    
    func deleteRemindes(_ reminders: [Reminder]){
        DBManager.sharedInstance.deleteReminders(reminders)
    }
    
    func getSectionCount(isSearchActive: Bool) -> Int {
        var sections = 0
        
        if(isSearchActive == false && status == .yetToTake) {
            sections = futureDates.count
        }
        else{
            sections = sortedDates.count
        }
        
        return sections
    }
    
    func getRowCount(isSearchActive: Bool, section: Int) -> Int {
        var rows = 0
        
        if(isSearchActive){
            switch(status){
            case .yetToTake:
                if(tempYetToTakeMedicines.count == 0) {
                    return 0
                }
                rows = tempYetToTakeMedicines[section].count
            case .missed:
                if(tempMissedReminders.count == 0) {
                    return 0
                }
                rows = tempMissedReminders[section].count
            case .completed:
                if(tempCompletedReminders.count == 0) {
                    return 0
                }
                rows = tempCompletedReminders[section].count
            default:
                if(tempAllMedicines.count == 0) {
                    return 0
                }
                rows = tempAllMedicines[section].count
            }
        }
        else{
            switch(status){
            case .yetToTake:
                if(yetToTakeReminders.count == 0) {
                    return 0
                }
                rows = yetToTakeReminders[section].count
            case .missed:
                if(missedReminders.count == 0) {
                    return 0
                }
                rows = missedReminders[section].count
            case .completed:
                if(completedReminders.count == 0) {
                    return 0
                }
                rows = completedReminders[section].count
            default:
                if(allMedicines.count == 0) {
                    return 0
                }
                rows = allMedicines[section].count
            }
        }
            
        return rows
    }
    
    func getTotalRows(isSearchActive: Bool) -> Int {
        let sections = getSectionCount(isSearchActive: isSearchActive)
        
        var val = 0
        
        for section in 0..<sections {
            let rows = getRowCount(isSearchActive: isSearchActive, section: section)
            for _ in 0..<rows {
                val+=1
            }
        }
        
        return val
    }
    
    func removeRemindersBeforeDeletion(_ reminder: Reminder) {
        for index in 0..<multipleSelectedRemindersToDelete.count {
            if(multipleSelectedRemindersToDelete[index].isEqual(toReminder: reminder)) {
                multipleSelectedRemindersToDelete.remove(at: index)
                break
            }
        }
    }
}
