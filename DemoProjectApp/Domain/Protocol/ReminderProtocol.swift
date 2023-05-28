//
//  File.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 23/09/22.
//

import Foundation

protocol ReminderProtocol: AnyObject {
    func updateReminderTable(forDate: String, medName: String)
    func completion(reminder: Reminder)
}
