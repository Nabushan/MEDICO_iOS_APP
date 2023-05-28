//
//  HomeVCHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/09/22.
//

import Foundation
import UIKit

class HomeVCHelper {
    var reminderMedicines: [Reminder] = DBManager.sharedInstance.getRowsFromReminderTable(forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
    
    var medArticleData: [Article] = []
    
    weak var delegate: HomeVCDelegate?
    
    let api: API = {
        let api = API()
        
        return api
    }()
    
    let imageDataProvider = ImageDataProvider()
    
    var medicalSolution: [MedicalSolution] = []
    var specialists: [Specialities] = []
    
    var pageCount = 1
    var startTimeForReminderTable: String!
    
    init(){
        
        
        updateMedicineStates()
        configureApiDelegate()
        loadDatas()
        fetchData(forUrl: apiUrl)
        
        fetchCurrentReminderMedicines()
        
        scheduleAllNotifications()
    }
    
    func loadDatas() {
        medicalSolution  = imageDataProvider.getMedicalSolutionData()
        specialists = imageDataProvider.getSpecialistsData()
    }
    
    func configureApiDelegate() {
        api.delegate = self
    }
    
    func fetchCurrentReminderMedicines() {
        reminderMedicines = DBManager.sharedInstance.getRowsFromReminderTable(forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
    }
}

extension HomeVCHelper: APIDelegateProtocol {
    var apiUrl: String {
        return "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=eea6ecf77e1149fd8c90a2e7ff564162&page=\(pageCount)"
    }
    
    func fetchData(forUrl: String) {
        api.getData(fromLink: forUrl)
        pageCount+=1
    }
    
    var medicalArticleCollectionView: UICollectionView {
        return delegate!.medicalArticleCollectionView
    }
}

extension HomeVCHelper: ReminderProtocol {
    func completion(reminder: Reminder){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { success,error in
            if success {
                self.scheduleNotification(withIdentifier: "identifier-\(reminder.time)", reminder: reminder)
                }
                else if let error = error {
                    print("Error occured \(error)")
                }
            })
    }
    
    func scheduleNotification(withIdentifier: String, reminder: Reminder) {
        let content = UNMutableNotificationContent()
            
        content.title = reminder.medicineName
        content.sound = .default
        content.body = reminder.medicineBody ?? " "
        
        print(reminder.time)
        let time = reminder.time
        let hourRange = time.index(time.startIndex, offsetBy: 0)...time.index(time.startIndex, offsetBy: 1)
        let minuteRange = time.index(time.startIndex, offsetBy: 3)...time.index(time.startIndex, offsetBy: 4)
        
        guard let hour = Int(time[hourRange]),let minute = Int(time[minuteRange]) else {
            print("Invalid time")
            return
        }
        
        print("Hour : ",hour)
        print("Minute : ",minute)
        
        let calenderComponents = Calendar.current
            
        let targetDate = Date()
        
        var dateComponent = calenderComponents.dateComponents([.year, .month, .day], from: targetDate)
        
        dateComponent.hour = hour
        dateComponent.minute = minute
        dateComponent.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent,
                                                    repeats: false)
         
        let request = UNNotificationRequest(identifier: withIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if(error != nil){
                print("Something went wrong")
                return
            }
        })
        
        print("Notification Registered")
    }
    
    func scheduleAllNotifications() {
        print("Scheduling all previous notifications.")
        for reminderMedicine in reminderMedicines {
            print("Sceduling notifications for \(reminderMedicine.time)")
            completion(reminder: reminderMedicine)
        }
    }
    
    func updateReminderTable(forDate: String, medName: String) {
        let dateAndTime = Date.now.description
        
        let dateRange = dateAndTime.index(dateAndTime.startIndex, offsetBy: 0)...dateAndTime.index(dateAndTime.startIndex, offsetBy: 9)
        
        print(dateAndTime[dateRange], forDate)
        
        if(String(dateAndTime[dateRange]) == forDate){
            delegate?.reloadReminderTableView()
        }
    }
    
    func updateMedicineStates() {
        DBManager.sharedInstance.setEarlierMedicinesToMissed(forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        let calendar = Calendar.current.dateComponents([.hour, .minute], from: Date())
        
        print("From update medicines : ",calendar)
        var time = ""
        
        if(calendar.hour! < 10){
            time = "0\(calendar.hour!)"
        }
        else{
            time = "\(calendar.hour!)"
        }
        
        if(calendar.minute! < 10){
           time =  time + ":0\(calendar.minute!):00"
        }
        else{
            time = time + ":\(calendar.minute!):00"
        }
        
        for reminder in reminderMedicines {
            print("Calendar Time: ",time)
            print("Reminder Time: ", reminder.time)
            if(reminder.time < time){
                print("Updating \(reminder.medicineName) to missed => \(reminder.time)")
                DBManager.sharedInstance.updateReminderDetails(.status, from: ReminderState.yetToTake.updateFieldName, to: ReminderState.missed.updateFieldName, reminder: reminder)
            }
        }
    }
}
