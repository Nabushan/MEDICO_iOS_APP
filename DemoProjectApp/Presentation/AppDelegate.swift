//
//  AppDelegate.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/09/22.
//

import UIKit
import SQLite3
import Contacts

var dbURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
var dbQueue: OpaquePointer?

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var restrictRotation:UIInterfaceOrientationMask = .portrait
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        Creates a DB and sets the pointer.
        dbQueue = createAndOpenDataBase()
        if(DBManager.sharedInstance.createTables() == false){
            print("Error in creating tables.")
        }
        else{
            print("Table created.")
        }
        
//        CNContactStore().requestAccess(for: .contacts) { (access, error) in
//          print("Access: \(access)")
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

//    Opaque Pointer => Swift type for C Pointers
    func createAndOpenDataBase() -> OpaquePointer? {
//        var db: OpaquePointer?
//
//        let url = NSURL(fileURLWithPath: dbURL) // Sets up the name for your databese
//
////        Name yout database here
//        if let pathComponent = url.appendingPathComponent("Testing.SQLite3"){
//            let filepath = pathComponent.path
//
//            if sqlite3_open(filepath, &db) == SQLITE_OK {
//                print("Successfully opened DataBase Connection at filepath \(filepath)")
//
//                return db
//            }
//            else{
//                print("Unable to open the data base")
//            }
//        }
//        else{
//            print("File path not available")
//        }
//
//        return db
//    }
            
    let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("DemoApp.sqlite")
//            print(filePath)
        var tempDb : OpaquePointer? = nil
                        
        if sqlite3_open(filePath.path, &tempDb) != SQLITE_OK {
            print("Not Created")
            return nil
        }
        else{
            print("Created File \(filePath)")
            return tempDb
        }
    }
}

