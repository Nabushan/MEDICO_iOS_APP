//
//  ReminderChoice.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 22/09/22.
//

import Foundation

enum ReminderChoice: Int {
    case dateAndTime = 1
    case messageName
    case messageBody
    case status
    
    var updateFieldName: String {
        switch(self){
        case .dateAndTime: return "DATE"
        case .messageName: return "MEDICINENAME"
        case .messageBody: return "MEDICINEBODY"
        case .status: return "STATUS"
        }
    }
}

enum ReminderState: Int, CaseIterable {
    case all = 0
    case yetToTake
    case missed
    case completed
    
    var updateFieldName: String {
        switch(self){
        case .completed: return "COMPLETED"
        case .missed: return "MISSED"
        case .yetToTake: return "Yet To Take"
        case .all: return "ALL"
        }
    }
    
    var scopeBarName: String {
        switch(self){
        case .completed: return "Completed"
        case .yetToTake: return "Yet To Take"
        case .missed: return "Missed"
        case .all: return "All"
        }
    }
}

enum FoodInterval: Int, CaseIterable {
    case breakFast = 0
    case lunch
    case dinner
    
    var intervalName: String {
        switch(self){
        case .breakFast: return "Breakfast"
        case .lunch: return "Lunch"
        case .dinner: return "Dinner"
        }
    }
}

enum Schedule: Int, CaseIterable {
    case before = 0
    case after
    
    var scheduleName: String {
        switch(self){
        case .before: return "Before"
        case .after: return "After"
        }
    }
}
