//
//  Consultation.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 26/10/22.
//

import Foundation

class ConsultationUpdater {
    let doctorId: Int?
    var consultationDate: String?
    var consultationTime: String?
    let patientName: String?
    let patientGender: String?
    let patientAge:  String?
    let patientProblem: String?
    let packageInfomation: ConsultationPackageType?
    let cost: String?
    let status: ConsultationState?
    let forUserId: Int
    
    init(doctorId: Int?, consultationDate: String?, consultationTime: String?, patientName: String?, patientGender: String?, patientAge:  String?, patientProblem: String?, packageInfomation: ConsultationPackageType?, cost: String?, status: ConsultationState?, forUserId: Int){
        self.doctorId = doctorId
        self.consultationDate = consultationDate
        self.consultationTime = consultationTime
        self.patientName = patientName
        self.patientGender = patientGender
        self.patientAge = patientAge
        self.patientProblem = patientProblem
        self.packageInfomation = packageInfomation
        self.cost = cost
        self.status = status
        self.forUserId = forUserId
    }
}

class ConsultationGetter: ConsultationUpdater {
    let doctorImage: String?
    let doctorName: String?
    
    init(doctorId: Int?, doctorName: String?, doctorImage: String?, consultationDate: String?, consultationTime: String?, patientName: String?, patientGender: String?, patientAge: String?, patientProblem: String?, packageInfomation: ConsultationPackageType?, cost: String?, status: ConsultationState?, forUserId: Int) {
        
        self.doctorName = doctorName
        self.doctorImage = doctorImage
        
        super.init(doctorId: doctorId, consultationDate: consultationDate, consultationTime: consultationTime, patientName: patientName, patientGender: patientGender, patientAge: patientAge, patientProblem: patientProblem, packageInfomation: packageInfomation, cost: cost, status: status, forUserId: forUserId)
    }
}
