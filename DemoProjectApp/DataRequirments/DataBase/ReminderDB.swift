//
//  ReminderDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 29/09/22.
//

import Foundation
import SQLite3

class ReminderDB {
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss a"
        
        return formatter
    }()
    
    func createTables() -> Bool {

        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS REMINDER (MEDICINENAME TEXT, MEDICINEBODY TEXT, DATE DATETIME, TIME DATETIME, STATUS TEXT, MEDICINETYPE TEXT, FOODINTERVAL INTEGER, SCHEDULE INTEGER, FORUSERID INTEGER)", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Reminder tables")
            return true
        }

        print("Unable to create Reminder table")
        return false
    }

    func addRowToReminder(_ reminder: Reminder) {
        let query = "INSERT INTO REMINDER (MEDICINENAME, MEDICINEBODY, DATE, TIME, STATUS, MEDICINETYPE, FOODINTERVAL, SCHEDULE, FORUSERID) VALUES('\(reminder.medicineName)', '\(reminder.medicineBody ?? "")', '\(String(describing: reminder.date))','\(String(describing: reminder.time))','\(reminder.status)','\(reminder.medicineType)','\(reminder.foodIntervalToTake.rawValue)','\(reminder.schedule.rawValue)', '\(reminder.userId)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion Successfull")
            }
            else{
                print("Insertion Error")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }

    func getRowsFromReminderTable(forUserId: Int) -> [Reminder] {
        var array: [Reminder] = []
        
        let date = formatter.string(from: Date())
        
        print("Date from reminder DB",date)
        
        let dateRange = date.index(date.startIndex, offsetBy: 0)...date.index(date.startIndex, offsetBy: 9)
        
        let dateValue = date[dateRange]
        
        let timeRange = date.index(date.startIndex, offsetBy: 11)...date.index(date.startIndex, offsetBy: 15)
        
        let timeValue = date[timeRange]
        
        let query = "SELECT * FROM REMINDER WHERE DATE = '\(dateValue)' AND TIME >= '\(timeValue)' AND STATUS = '\("Yet To Take")' AND FORUSERID = '\(forUserId)' ORDER BY TIME;"
        

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let medicineName = String(cString: sqlite3_column_text(selectionQueryPointer, 0))
                let medicineBody = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                let date = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let time = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let reminderStatus = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let medicineType = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let foodInterval = Int(sqlite3_column_int(selectionQueryPointer, 6))
                
                let schedule = Int(sqlite3_column_int(selectionQueryPointer, 7))
                
                let userId = Int(sqlite3_column_int(selectionQueryPointer, 8))
                
                var reminder = Reminder(date: date,
                                        time: time,
                                        medicineName: medicineName,
                                        medicineBody: medicineBody,
                                        medicineType: medicineType,
                                        foodIntervalToTake: FoodInterval(rawValue: foodInterval) ?? .breakFast,
                                        schedule: Schedule(rawValue: schedule) ?? .before,
                                        userId: userId)
                
                reminder.status = reminderStatus
                
                array.append(reminder)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }

    func emptyReminderTable() {
        let query = "DELETE FROM REMINDER;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records")
            }
            else{
                print("deletion failed")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func deleteReminders(_ reminder: Reminder) {
        let query = "DELETE FROM REMINDER WHERE MEDICINENAME = '\(reminder.medicineName)' AND DATE = '\(reminder.date)' AND TIME = '\(reminder.time)' AND FORUSERID = '\(reminder.userId)';"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted \(reminder.medicineName) from sample records")
            }
            else{
                print("deletion for '\(reminder.medicineName)' failed")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }

    func updateReminderDetails(_ field: ReminderChoice,from: String, to: String, reminder: Reminder) {
        
        let fieldToUpdate: String = field.updateFieldName
        
        var query = ""
        
        switch(field){
        case .messageName:
            ()
        case .messageBody:
            ()
        case .dateAndTime:
            ()
        case .status:
            query = "UPDATE REMINDER SET \(fieldToUpdate) = '\(to)' WHERE \(fieldToUpdate) = '\(from)' AND MEDICINENAME = '\(reminder.medicineName)' AND FORUSERID = '\(reminder.userId)' AND DATE = '\(reminder.date)' AND TIME = '\(reminder.time)';"
        }

        print(query)
        
        var updationQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updationQueryPointer) == SQLITE_DONE){
                print("Successfully Updated the sample")
            }
            else{
                print("Updation Failed")
            }
        }
    }
    
    func dropReminderTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE REMINDER"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped table")
            }
            else{
                print("Table drop failed")
            }
        }
    }
    
    func getSearchResults(for searchString: String,status: ReminderState,forDate: String, forUserId: Int) -> [Reminder] {
        var searchResultPointer: OpaquePointer?
        
        var array: [Reminder] = []
        var query = ""
        
        switch(status){
        case .all:
            query = "SELECT * FROM REMINDER WHERE MEDICINENAME LIKE '%\(searchString)%' AND DATE = '\(forDate)' AND FORUSERID = '\(forUserId)'"
        default:
            query = "SELECT * FROM REMINDER WHERE MEDICINENAME LIKE '%\(searchString)%' AND STATUS = '\(status.updateFieldName)' AND DATE = '\(forDate)' AND FORUSERID = '\(forUserId)'"
        }
        
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &searchResultPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(searchResultPointer) == SQLITE_ROW){
                let medicineName = String(cString: sqlite3_column_text(searchResultPointer, 0))
                let medicineBody = String(cString: sqlite3_column_text(searchResultPointer, 1))
                let date = String(cString: sqlite3_column_text(searchResultPointer, 2))
                
                let time = String(cString: sqlite3_column_text(searchResultPointer, 3))
                
                let reminderStatus = String(cString: sqlite3_column_text(searchResultPointer, 4))
                
                let medicineType = String(cString: sqlite3_column_text(searchResultPointer, 5))
                
                let foodInterval = Int(sqlite3_column_int(searchResultPointer, 6))
                
                let schedule = Int(sqlite3_column_int(searchResultPointer, 7))
                
                let userId = Int(sqlite3_column_int(searchResultPointer, 8))
                
                var reminder = Reminder(date: date,
                                        time: time,
                                        medicineName: medicineName,
                                        medicineBody: medicineBody,
                                        medicineType: medicineType,
                                        foodIntervalToTake: FoodInterval(rawValue: foodInterval) ?? .breakFast,
                                        schedule: Schedule(rawValue: schedule) ?? .before,
                                        userId: userId)
                
                reminder.status = reminderStatus
                
                array.append(reminder)
            }
        }

        sqlite3_finalize(searchResultPointer)
        return array
    }
    
    func getAvailableDates(forUserId:  Int) -> Set<String> {
        var dateResultPointer: OpaquePointer?
        
        let query = "SELECT DATE FROM REMINDER WHERE FORUSERID = '\(forUserId)'"
        var tempArray: Set<String> = []
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dateResultPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(dateResultPointer) == SQLITE_ROW){
                let date = String(cString: sqlite3_column_text(dateResultPointer, 0))
                
                tempArray.insert(date)
            }
        }
            
        return tempArray
    }
    
    func setEarlierMedicinesToMissed(forUserId: Int) {
        var missedPointer: OpaquePointer?
        
        let date = Date.now.description
        
        let dateRange = date.index(date.startIndex, offsetBy: 0)...date.index(date.startIndex, offsetBy: 9)
        
        let dateValue = date[dateRange]
        
        let query = "UPDATE REMINDER SET STATUS = 'MISSED' WHERE DATE < '\(dateValue)' AND STATUS = 'Yet To Take' AND FORUSERID = '\(forUserId)';"
        
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &missedPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(missedPointer) == SQLITE_DONE) {
                print("Previous Reminder states Updated successfully.")
            }
            else{
                print("Reminder states updation failed.")
            }
        }
    }
}
