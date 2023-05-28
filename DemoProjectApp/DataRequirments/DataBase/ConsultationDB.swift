//
//  ConsultationDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 26/10/22.
//

import Foundation
import SQLite3

class ConsultationDB {
    func createTable() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS Consultations (doctorId INTEGER, consultationDate TEXT, consultationTime TEXT, patientName TEXT, patientAge TEXT, patientGender TEXT, patientProblem TEXT, pakageType INTEGER, cost TEXT, status INTEGER, forUserId INTEGER);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Consultation tables")
            return true
        }

        print("Unable to create Consultation table")
        return false
    }
    
    func addConsultation(_ consultation: ConsultationUpdater) {
        
        guard let doctorId = consultation.doctorId,
              let consultationDate = consultation.consultationDate,
              let consultationTime = consultation.consultationTime,
              let patientName = consultation.patientName,
              let patientAge = consultation.patientAge,
              let patientGender = consultation.patientGender,
              let patientProblem = consultation.patientProblem,
              let packageInfomation = consultation.packageInfomation,
              let cost = consultation.cost,
              let status = consultation.status else{
            print("Insertion failed in guard let")
            return
        }
        
        let query = "INSERT INTO Consultations VALUES ('\(doctorId)','\(consultationDate)','\(consultationTime)','\(patientName)','\(patientAge)','\(patientGender)','\(patientProblem)','\(packageInfomation.rawValue)','\(cost)','\(status.rawValue)', '\(consultation.forUserId)');"

        print(query)
        
        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Consultation Table Successfull")
            }
            else{
                print("Insertion into Consultation Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropConsultationTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE Consultations"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Consultation table")
            }
            else{
                print("Failed to dropp Consultation table")
            }
        }
    }
    
    func emptyConsultationTable() {
        let query = "DELETE FROM Consultations;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Consultation table")
            }
            else{
                print("Failed to delete all sample records from Consultation table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromConsultationTable(for state: ConsultationState, forUserId: Int) -> [ConsultationGetter] {
        var array: [ConsultationGetter] = []
        
        let query = "SELECT doctorId, consultationDate, consultationTime, patientName, patientAge, patientGender, patientProblem, pakageType, cost, status, doctor.name, doctor.imageName FROM Consultations INNER JOIN doctor ON Consultations.doctorId = doctor.id AND Consultations.status = '\(state.rawValue)' AND Consultations.forUserId = '\(forUserId)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
        
                let doctorId = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let consultationDate = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let consultaionTime = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let patientName = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let patientAge = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let patientGender = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let patientProblem = String(cString: sqlite3_column_text(selectionQueryPointer, 6))
                
                let packageType = ConsultationPackageType(rawValue: Int(sqlite3_column_int(selectionQueryPointer, 7))) ?? .hospitalVisit
                
                let cost = String(cString: sqlite3_column_text(selectionQueryPointer, 8))
                
                let status = ConsultationState(rawValue: Int(sqlite3_column_int(selectionQueryPointer, 9))) ?? .upcoming
                
                let doctorName = String(cString: sqlite3_column_text(selectionQueryPointer, 10))
                
                let doctorImage = String(cString: sqlite3_column_text(selectionQueryPointer, 11))
                
                let userId = Int(sqlite3_column_int(selectionQueryPointer, 12))
                
                let consultation = ConsultationGetter(
                    doctorId: doctorId,
                    doctorName: doctorName,
                    doctorImage: doctorImage,
                    consultationDate: consultationDate,
                    consultationTime: consultaionTime,
                    patientName: patientName,
                    patientGender: patientGender,
                    patientAge: patientAge,
                    patientProblem: patientProblem,
                    packageInfomation: packageType,
                    cost: cost,
                    status: status,
                    forUserId: userId)
                
                array.append(consultation)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func updateConsultation(date: String, time: String, for consultation: ConsultationUpdater, forUserId: Int) {
        var updatePointer: OpaquePointer?

        guard let doctorId = consultation.doctorId,
              let consultationDate = consultation.consultationDate,
              let consultationTime = consultation.consultationTime,
              let packageInfomation = consultation.packageInfomation else{
            print("Insertion failed in guard let")
            return
        }

        let query = "UPDATE Consultations SET consultationDate = '\(date)', consultationTime = '\(time)' WHERE doctorId = '\(doctorId)' AND consultationDate = '\(consultationDate)' AND consultationTime = '\(consultationTime)' AND pakageType = '\(packageInfomation.rawValue)' AND forUserId = '\(forUserId)'"

        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updatePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updatePointer) == SQLITE_DONE) {
                print("Previous Review Consultation successfully.")
            }
            else{
                print("Review state Consultation failed.")
            }
        }
    }
    
    func updateConsultation(state: ConsultationState, for consultation: ConsultationGetter, forUserId: Int) {
        var updatePointer: OpaquePointer?

        guard let doctorId = consultation.doctorId,
              let consultationDate = consultation.consultationDate,
              let consultationTime = consultation.consultationTime,
              let packageInfomation = consultation.packageInfomation else{
            print("Insertion failed in guard let")
            return
        }

        let query = "UPDATE Consultations SET status = '\(state.rawValue)' WHERE doctorId = '\(doctorId)' AND consultationDate = '\(consultationDate)' AND consultationTime = '\(consultationTime)' AND pakageType = '\(packageInfomation.rawValue)' AND forUserId = '\(forUserId)'"

        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updatePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updatePointer) == SQLITE_DONE) {
                print("Previous Review Consultation successfully.")
            }
            else{
                print("Review state Consultation failed.")
            }
        }
    }
    
    func removeConsultation(_ consultation: ConsultationGetter, forUserId: Int) {
        var updatePointer: OpaquePointer?

        guard let doctorId = consultation.doctorId,
              let consultationDate = consultation.consultationDate,
              let consultationTime = consultation.consultationTime,
              let packageInfomation = consultation.packageInfomation?.rawValue,
              let conslutationState = consultation.status?.rawValue else{
            print("Removal failed in guard let")
            return
        }
        

        let query = "DELETE from Consultations WHERE doctorId = '\(doctorId)' AND consultationDate = '\(consultationDate)' AND consultationTime = '\(consultationTime)' AND pakageType = '\(packageInfomation)' AND status = '\(conslutationState)' AND forUserId = '\(forUserId)';"

        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updatePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updatePointer) == SQLITE_DONE) {
                print("Removed Consultation successfully.")
            }
            else{
                print("Attempt to remove Consultation failed.")
            }
        }
    }
}
