//
//  SQLiteCommands.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 22/09/22.
//

import Foundation
import SQLite3

class DoctorDB {
    
    func createTables() -> Bool {
        return createAvailableHospitalTimings() && createAvailableVideoCallTimings() && createDoctorTables() && createDoctorRatingsTable() && createDoctorReviewsTable()
    }
    
    private func createAvailableHospitalTimings() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS availableHospitalTimings (Id INTEGER, Monday TEXT, Tuesday TEXT, Wednesday TEXT, Thursday TEXT, Friday TEXT, Saturday TEXT, Sunday TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Available Hospital Timings tables")
            return true
        }

        print("Unable to create Available Hospital Timings table")
        return false
    }
    
    private func createAvailableVideoCallTimings() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS availableVideoCallTimings (Id INTEGER, Monday TEXT, Tuesday TEXT, Wednesday TEXT, Thursday TEXT, Friday TEXT, Saturday TEXT, Sunday TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Available Video Call Timings tables")
            return true
        }

        print("Unable to create Available Video Call Timings table")
        return false
    }
    
    private func createDoctorTables() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS doctor (id INTEGER, name TEXT, imageName TEXT, designation INTEGER, experience TEXT, qualification TEXT, location TEXT, languagesKnown TEXT, availableForAMinimumOf INTEGER, vedioConsultationCost INTEGER, hospitalVisitCost INTEGER, locationImageName TEXT, locationAddress TEXT, videoConsultTimings INTEGER, hospitalTiming INTEGER, ratings NUMBER, totalNumberOfRaters INTEGER);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Doctors tables")
            return true
        }

        print("Unable to create Doctors table")
        return false
    }
    
    private func createDoctorReviewsTable() -> Bool {
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS doctorReviews (id INTEGER, reviewerName TEXT, reviewDate TEXT, overAllReview TEXT, review TEXT, userSelectedRatings NUMBER)", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Doctors Review tables")
            return true
        }

        print("Unable to create Doctors Review table")
        return false
    }

    private func createDoctorRatingsTable() -> Bool {
        
        
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS doctorRatings (id INTEGER, NumberOfFiveStars INTEGER, NumberOfFourStars INTEGER, NumberOfThreeStars INTEGER, NumberOfTwoStars INTEGER, NumberOfOneStars INTEGER);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Doctors Ratings tables")
            return true
        }

        print("Unable to create Doctors Ratings table")
        return false
    }
    
    func addAvailableVideoCallTimings(_ timings: DoctorTiming){
        let query = "INSERT INTO availableVideoCallTimings VALUES ('\(timings.id)','\(timings.monday)','\(timings.tuesday)','\(timings.wednesday)','\(timings.thursday)','\(timings.friday)','\(timings.saturday)','\(timings.sunday)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Available Vedio Call Timings Successfull")
            }
            else{
                print("Insertion into Available Vedio Call Timings Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func addAvailableHospitalTimings(_ timings: DoctorTiming){
        let query = "INSERT INTO availableHospitalTimings VALUES ('\(timings.id)','\(timings.monday)','\(timings.tuesday)','\(timings.wednesday)','\(timings.thursday)','\(timings.friday)','\(timings.saturday)','\(timings.sunday)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Available Hospital Timings Timings Successfull")
            }
            else{
                print("Insertion into Available Hospital Timings Timings Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func addDoctorDetailsToTable(_ doctor: Doctor) {
        let query = "INSERT INTO doctor VALUES ('\(doctor.id)','\(doctor.name)','\(doctor.imageName)','\(doctor.designation.rawValue)','\(doctor.experience)','\(doctor.qualification)','\(doctor.location)','\(doctor.languagesKnown)','\(doctor.availableForAMinimumOf)','\(doctor.vedioConsultationCost)','\(doctor.hospitalVisitCost)','\(doctor.locationImageName)','\(doctor.locationAddress)','\(doctor.videoConsultTimings)','\(doctor.hospitalTiming)','\(doctor.ratings)','\(doctor.totalNumberOfRaters)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Doctor Table Successfull")
            }
            else{
                print("Insertion into Doctor Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func addDoctorReviewsAndRatingsToTable(_ doctorRatingsAndReviews: DoctorReviewAndRating) {
        var query = "INSERT INTO doctorReviews VALUES ('\(doctorRatingsAndReviews.rating.id)', '\(doctorRatingsAndReviews.review.reviewerName)', '\(doctorRatingsAndReviews.review.dateOfReview)', '\(doctorRatingsAndReviews.review.title)', '\(doctorRatingsAndReviews.review.body)', '\(doctorRatingsAndReviews.review.numberOfRatingStars)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Doctor Review Table Successfull")
            }
            else{
                print("Insertion into Doctor Rating Table Failed")
            }
        }
        
        query = "INSERT INTO doctorRatings VALUES ('\(doctorRatingsAndReviews.rating.id)', '\(doctorRatingsAndReviews.rating.numberOfFiveStars)', '\(doctorRatingsAndReviews.rating.numberOfFourStars)', '\(doctorRatingsAndReviews.rating.numberOfThreeStars)', '\(doctorRatingsAndReviews.rating.numberOfTwoStars)','\(doctorRatingsAndReviews.rating.numberOfOneStars)');"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Doctor Rating Table Successfull")
            }
            else{
                print("Insertion into Doctor Rating Table Failed")
            }
        }
        
        sqlite3_finalize(insertQueryPointer)
    }
    
    func addDoctorReview(_ reviews: Reviews) {
        var query = "INSERT INTO doctorReviews VALUES ('\(reviews.id)', '\(reviews.reviewerName)', '\(reviews.dateOfReview)', '\(reviews.title)', '\(reviews.body)', '\(reviews.numberOfRatingStars)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Doctor Review Table Successfull")
            }
            else{
                print("Insertion into Doctor Rating Table Failed")
            }
        }
    }
    
    func dropDoctorDBTables() {
        dropDoctorTable()
        dropAvailableHospitalTimingsTable()
        dropAvailableVideoCallTimingsTable()
        dropDoctorReviewAndRatingTable()
    }
    
    private func dropDoctorTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE doctor"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Doctor table")
            }
            else{
                print("Failed to dropp Doctor table")
            }
        }
    }
    
    private func dropAvailableHospitalTimingsTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE availableHospitalTimings"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Available Hospital Timings Table")
            }
            else{
                print("Failed to drop Available Hospital Timings Table")
            }
        }
    }
    
    private func dropAvailableVideoCallTimingsTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE availableVideoCallTimings"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Available VideoCall Timings Table")
            }
            else{
                print("Failed to drop Available VideoCall Timings Table")
            }
        }
    }
    
    private func dropDoctorReviewAndRatingTable() {
        var dropTablePointer: OpaquePointer?
        
        var query = "DROP TABLE doctorReviews"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Doctor Reviews table")
            }
            else{
                print("Failed to dropp Doctor Reviews table")
            }
        }
        
        
        query = "DROP TABLE doctorRatings"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Doctor Ratings table")
            }
            else{
                print("Failed to dropp Doctor Ratings table")
            }
        }
    }
    
    func emptyTables() {
        emptyDoctorTable()
        emptyAvailableHospitalTimingsTable()
        emptyAvailableVideoCallTimingsTable()
        emptyDoctorReviewsAndRatings()
    }
    
    private func emptyDoctorTable() {
        let query = "DELETE FROM doctor;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from doctor table")
            }
            else{
                print("Failed to delete all sample records from doctor table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    private func emptyAvailableHospitalTimingsTable() {
        let query = "DELETE FROM availableHospitalTimings;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Available Hospital Timings table")
            }
            else{
                print("Failed to delete all sample records from Available Hospital Timings table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    private func emptyAvailableVideoCallTimingsTable() {
        let query = "DELETE FROM availableVideoCallTimings;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Available VideoCall Timings table")
            }
            else{
                print("Failed to delete all sample records from Available VideoCall Timings table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func emptyDoctorReviewsAndRatings() {
        var query = "DELETE FROM doctorReviews;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Doctor Reviews table")
            }
            else{
                print("Failed to delete all sample records from Doctor Reviews table")
            }
        }
        
        query = "DELETE FROM doctorRatings;"

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Doctor Ratings table")
            }
            else{
                print("Failed to delete all sample records from Doctor Ratings table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }

    func getRowsFromDoctorTable() -> [Doctor] {
        var array: [Doctor] = []
        
        let query = "SELECT * FROM doctor;"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let imageName = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let designationInt = Int(sqlite3_column_int(selectionQueryPointer, 3))
                
                let experience = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let qualification = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let location = String(cString: sqlite3_column_text(selectionQueryPointer, 6))
                
                let languagesKnown = String(cString: sqlite3_column_text(selectionQueryPointer, 7))
                
                let availableFor = Int(sqlite3_column_int(selectionQueryPointer, 8))
                
                let vedioConsultationCost = Int(sqlite3_column_int(selectionQueryPointer, 9))
                
                let hospitalVisitCost = Int(sqlite3_column_int(selectionQueryPointer, 10))
                
                let locationImageName = String(cString: sqlite3_column_text(selectionQueryPointer, 11))
                
                let locationAddress = String(cString: sqlite3_column_text(selectionQueryPointer, 12))
                
                let videoConsultTimingsInt = Int(sqlite3_column_int(selectionQueryPointer, 13))
                
                let hospitalTimingsInt = Int(sqlite3_column_int(selectionQueryPointer, 14))
                
                let ratings = Double(sqlite3_column_double(selectionQueryPointer, 15))
                
                let totalNumberOfRaters = Int(sqlite3_column_int(selectionQueryPointer, 16))
                
                let doctor = Doctor(id: id,
                                    name: name,
                                    imageName: imageName,
                                    designation: DoctorSpecialization(rawValue: designationInt) ?? .cardiologist,
                                    experience: experience,
                                    qualification: qualification,
                                    location: location,
                                    languagesKnown: languagesKnown,
                                    availableForAMinimumOf: availableFor,
                                    vedioConsultationCost: vedioConsultationCost,
                                    hospitalVisitCost: hospitalVisitCost,
                                    locationImageName: locationImageName,
                                    locationAddress: locationAddress,
                                    videoConsultTimings: videoConsultTimingsInt,
                                    hospitalTiming: hospitalTimingsInt,
                                    ratings: ratings,
                                    totalNumberOfRaters: totalNumberOfRaters)
                
                array.append(doctor)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
    
    func getDoctorDetailFromTable(forId: Int) -> Doctor {
        
        var doctor: Doctor = Doctor(id: -1,
                                    name: "",
                                    imageName: "",
                                    designation: .all,
                                    experience: "",
                                    qualification: "",
                                    location: "",
                                    languagesKnown: "",
                                    availableForAMinimumOf: -1,
                                    vedioConsultationCost: -1,
                                    hospitalVisitCost: -1,
                                    locationImageName: "",
                                    locationAddress: "",
                                    videoConsultTimings: -1,
                                    hospitalTiming: -1,
                                    ratings: 0.0,
                                    totalNumberOfRaters: -1)
        
        let query = "SELECT * FROM doctor WHERE id = '\(forId)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let name = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let imageName = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let designationInt = Int(sqlite3_column_int(selectionQueryPointer, 3))
                
                let experience = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let qualification = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let location = String(cString: sqlite3_column_text(selectionQueryPointer, 6))
                
                let languagesKnown = String(cString: sqlite3_column_text(selectionQueryPointer, 7))
                
                let availableFor = Int(sqlite3_column_int(selectionQueryPointer, 8))
                
                let vedioConsultationCost = Int(sqlite3_column_int(selectionQueryPointer, 9))
                
                let hospitalVisitCost = Int(sqlite3_column_int(selectionQueryPointer, 10))
                
                let locationImageName = String(cString: sqlite3_column_text(selectionQueryPointer, 11))
                
                let locationAddress = String(cString: sqlite3_column_text(selectionQueryPointer, 12))
                
                let videoConsultTimingsInt = Int(sqlite3_column_int(selectionQueryPointer, 13))
                
                let hospitalTimingsInt = Int(sqlite3_column_int(selectionQueryPointer, 14))
                
                let ratings = Double(sqlite3_column_double(selectionQueryPointer, 15))
                
                let totalNumberOfRaters = Int(sqlite3_column_int(selectionQueryPointer, 16))
                
                doctor = Doctor(id: id,
                                name: name,
                                imageName: imageName,
                                designation: DoctorSpecialization(rawValue: designationInt) ?? .cardiologist,
                                experience: experience,
                                qualification: qualification,
                                location: location,
                                languagesKnown: languagesKnown,
                                availableForAMinimumOf: availableFor,
                                vedioConsultationCost: vedioConsultationCost,
                                hospitalVisitCost: hospitalVisitCost,
                                locationImageName: locationImageName,
                                locationAddress: locationAddress,
                                videoConsultTimings: videoConsultTimingsInt,
                                hospitalTiming: hospitalTimingsInt,
                                ratings: ratings,
                                totalNumberOfRaters: totalNumberOfRaters)
                
                
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return doctor
    }
    
    func getRowsFromTimingsTable(forTable: WorkShiftTable, index: Int) -> DoctorTiming? {
        let query = "SELECT * FROM \(forTable.tableName) WHERE Id = '\(index)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                let monday = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let tuesday = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let wednesday = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let thursday = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let friday = String(cString: sqlite3_column_text(selectionQueryPointer, 5))
                
                let saturday = String(cString: sqlite3_column_text(selectionQueryPointer, 6))
                
                let sunday = String(cString: sqlite3_column_text(selectionQueryPointer, 7))
                
                let doctorTiming = DoctorTiming(id: id,
                                                monday: monday,
                                                tuesday: tuesday,
                                                wednesday: wednesday,
                                                thursday: thursday,
                                                friday: friday,
                                                saturday: saturday,
                                                sunday: sunday)
                
                return doctorTiming
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return nil
    }
    
    func getDoctorSearchResults(for searchString: String,designation: DoctorSpecialization) -> [Doctor] {
        var searchResultPointer: OpaquePointer?
        
        var array: [Doctor] = []
        var query = ""
        
        switch(designation){
        case .all:
            query = "SELECT * FROM doctor WHERE name LIKE '%\(searchString)%'"
        default:
            query = "SELECT * FROM doctor WHERE name LIKE '%\(searchString)%' AND designation = '\(designation.rawValue)'"
        }
        
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &searchResultPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(searchResultPointer) == SQLITE_ROW){
                let id = Int(sqlite3_column_int(searchResultPointer, 0))
                
                let name = String(cString: sqlite3_column_text(searchResultPointer, 1))
                
                let imageName = String(cString: sqlite3_column_text(searchResultPointer, 2))
                
                let designationInt = Int(sqlite3_column_int(searchResultPointer, 3))
                
                let experience = String(cString: sqlite3_column_text(searchResultPointer, 4))
                
                let qualification = String(cString: sqlite3_column_text(searchResultPointer, 5))
                
                let location = String(cString: sqlite3_column_text(searchResultPointer, 6))
                
                let languagesKnown = String(cString: sqlite3_column_text(searchResultPointer, 7))
                
                let availableFor = Int(sqlite3_column_int(searchResultPointer, 8))
                
                let vedioConsultationCost = Int(sqlite3_column_int(searchResultPointer, 9))
                
                let hospitalVisitCost = Int(sqlite3_column_int(searchResultPointer, 10))
                
                let locationImageName = String(cString: sqlite3_column_text(searchResultPointer, 11))
                
                let locationAddress = String(cString: sqlite3_column_text(searchResultPointer, 12))
                
                let videoConsultTimingsInt = Int(sqlite3_column_int(searchResultPointer, 13))
                
                let hospitalTimingsInt = Int(sqlite3_column_int(searchResultPointer, 14))
                
                let ratings = Double(sqlite3_column_double(searchResultPointer, 15))
                
                let totalNumberOfRaters = Int(sqlite3_column_int(searchResultPointer, 16))
                
                let doctor = Doctor(id: id,
                                    name: name,
                                    imageName: imageName,
                                    designation: DoctorSpecialization(rawValue: designationInt) ?? .cardiologist,
                                    experience: experience,
                                    qualification: qualification,
                                    location: location,
                                    languagesKnown: languagesKnown,
                                    availableForAMinimumOf: availableFor,
                                    vedioConsultationCost: vedioConsultationCost,
                                    hospitalVisitCost: hospitalVisitCost,
                                    locationImageName: locationImageName,
                                    locationAddress: locationAddress,
                                    videoConsultTimings: videoConsultTimingsInt,
                                    hospitalTiming: hospitalTimingsInt,
                                    ratings: ratings,
                                    totalNumberOfRaters: totalNumberOfRaters)
                
                array.append(doctor)
            }
        }

        sqlite3_finalize(searchResultPointer)
        return array
    }
    
    func getDoctorReviews(forId: Int) -> [Reviews] {
        
        var doctorReviews: [Reviews] = []
        
        let query = "SELECT * FROM doctorReviews WHERE id = '\(forId)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){

                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let reviewerName = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let reviewDate = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let overAllReview = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let review = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let userSelectedRatings = Int(sqlite3_column_int(selectionQueryPointer, 5))
                
                let reviews =  Reviews(id: id,
                                title: overAllReview,
                                body: review,
                                numberOfRatingStars: userSelectedRatings,
                                dateOfReview: reviewDate,
                                reviewerName: reviewerName,
                                category: .doctor)
                
                doctorReviews.append(reviews)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return doctorReviews
    }
    
    func getDoctorRatings(forId: Int) -> Ratings {
        
        var doctorRatings: Ratings = Ratings(id: -1,
                                             numberOfFiveStars: -1,
                                             numberOfFourStars: -1,
                                             numberOfThreeStars: -1,
                                             numberOfTwoStars: -1,
                                             numberOfOneStars: -1,
                                             category: .doctor)
        
        let query = "SELECT * FROM doctorRatings WHERE id = '\(forId)';"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let id = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let fiveStars = Int(sqlite3_column_int(selectionQueryPointer, 1))
                
                let fourStars = Int(sqlite3_column_int(selectionQueryPointer, 2))
                
                let threeStars = Int(sqlite3_column_int(selectionQueryPointer, 3))
                
                let twoStars = Int(sqlite3_column_int(selectionQueryPointer, 4))
                
                let oneStars = Int(sqlite3_column_int(selectionQueryPointer, 5))
                
                doctorRatings = Ratings(id: id,
                                    numberOfFiveStars: fiveStars,
                                    numberOfFourStars: fourStars,
                                    numberOfThreeStars: threeStars,
                                    numberOfTwoStars: twoStars,
                                    numberOfOneStars: oneStars,
                                    category: .doctor)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return doctorRatings
    }
    
    func updateDoctorReview(_ review: Reviews, forDoctorId: Int) {
        
        let query = "UPDATE doctorReviews SET reviewDate = '\(review.dateOfReview)', overAllReview = '\(review.title)', review = '\(review.body)', userSelectedRatings = '\(review.numberOfRatingStars)' WHERE reviewerName = '\(review.reviewerName)' AND Id = '\(forDoctorId)';"

        print(query)
    
        var updationQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updationQueryPointer) == SQLITE_DONE){
                print("Successfully Updated the Ratings Table")
            }
            else{
                print("Updation of Ratings Table Failed")
            }
        }
    }
    
    func updateDoctorRatingStarCount(toValue: Int, forColumn: RatingStar, ratingId: Int) {
        
        let query = "UPDATE doctorRatings SET \(forColumn.dbName) = '\(toValue)' WHERE Id = '\(ratingId)';"

        print(query)
    
        var updationQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(updationQueryPointer) == SQLITE_DONE){
                print("Successfully Updated the Ratings Table")
            }
            else{
                print("Updation of Ratings Table Failed")
            }
        }
    }
    
    func getDoctorRatingsFromDoctorTable(forDoctorName: String, _ doctorId: Int) -> Double {
        var getResultPointer: OpaquePointer?
        
        let query = "SELECT ratings FROM doctor WHERE name = '\(forDoctorName)' AND id = \(doctorId);"
        var rating = 0.0
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &getResultPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(getResultPointer) == SQLITE_ROW){
                rating = Double(sqlite3_column_double(getResultPointer, 0))
            }
        }
        
        return rating
    }
    
    func updateDoctorRatings(forDoctorName: String, doctorId: Int, toRating: Double, raters: Int) {
        let query = "UPDATE doctor SET ratings = \(toRating), totalNumberOfRaters = '\(raters)' WHERE name = '\(forDoctorName)' AND id = \(doctorId);"

        var updationQueryPointer: OpaquePointer?
        
        print(query)

        if(sqlite3_prepare_v2(dbQueue, query, -1, &updationQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(updationQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully updated the sample rating record in Doctors DB")
            }
            else{
                print("Failed to delete updated the sample rating record in Doctors DB")
            }
        }

        sqlite3_finalize(updationQueryPointer)
    }
    
    func getDoctorVideoConsultTimingsFromDoctorTable(forDoctorName: String, _ doctorId: Int) -> Int {
        var getResultPointer: OpaquePointer?
        
        let query = "SELECT videoConsultTimings FROM doctor WHERE name = '\(forDoctorName)' AND id = \(doctorId);"
        var timing = 0
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &getResultPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(getResultPointer) == SQLITE_ROW){
                timing = Int(sqlite3_column_double(getResultPointer, 0))
            }
        }
        
        return timing
    }
    
    func getDoctorHospitalTimingsFromDoctorTable(forDoctorName: String, _ doctorId: Int) -> Int {
        var getResultPointer: OpaquePointer?
        
        let query = "SELECT hospitalTiming FROM doctor WHERE name = '\(forDoctorName)' AND id = \(doctorId);"
        var timing = 0
        print(query)
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &getResultPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(getResultPointer) == SQLITE_ROW){
                timing = Int(sqlite3_column_double(getResultPointer, 0))
            }
        }
        
        return timing
    }
}
