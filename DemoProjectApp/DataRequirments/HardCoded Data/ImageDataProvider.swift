//
//  ImageDataProvider.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 25/09/22.
//

import Foundation

struct ImageDataProvider {
    
    func getMedicalSolutionData() -> [MedicalSolution] {
        let temp: [MedicalSolution] = [
            MedicalSolution(name: "doctor.png", desciption: "Doctors"),
            MedicalSolution(name: "hospital.png", desciption: "Hospitals"),
            MedicalSolution(name: "virus.png", desciption: "Articles"),
            MedicalSolution(name: "ambulance.png", desciption: "Ambulance"),
            MedicalSolution(name: "reminder.png", desciption: "Reminders"),
            MedicalSolution(name: "medicines.png", desciption: "Pharmacy"),
        ]
        
        return temp
    }
    
    func getSpecialistsData() -> [Specialities] {
        let temp: [Specialities] = [
            Specialities(name: "cardiogram.png", desciption: "Cardio"),
            Specialities(name: "kidneys.png", desciption: "Nephro"),
            Specialities(name: "lungs.png", desciption: "Asthma"),
            Specialities(name: "stomach-care.png", desciption: "Gastric"),
            Specialities(name: "dental-implant.png", desciption: "Dental"),
            Specialities(name: "brain.png", desciption: "Neuro"),
            Specialities(name: "bone.png", desciption: "Ortho"),
            Specialities(name: "skin-treatment.png", desciption: "Skin"),
            Specialities(name: "hair.png", desciption: "Hair"),
            Specialities(name: "baby.png", desciption: "Kids"),
        ]
        
        return temp
    }
    
}
