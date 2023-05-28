//
//  Image Datas.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 25/09/22.
//

import Foundation
import UIKit

struct MedicalSolution {
    let name: String
    let description: String
    let image: UIImage?
    
    init(name: String, desciption:  String){
        self.name = name
        self.description = desciption
        
        self.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate) ?? UIImage(systemName: "exclamationmark.triangle")?.withRenderingMode(.alwaysTemplate)
    }
}

struct Specialities {
    let name: String
    let description: String
    let image: UIImage?
    
    init(name: String, desciption:  String){
        self.name = name
        self.description = desciption
        
        self.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate) ?? UIImage(systemName: "exclamationmark.triangle")?.withRenderingMode(.alwaysTemplate)
    }
}

struct Image {
    let category: ImageCategory
    let link: String
}

struct FAQ {
    let question: String
    let answer: String
}

struct ContactUs {
    let queryImageName: String
    let queryName: String
}

struct Hospital {
    let id: Int
    let name: String
    let imageLink: String
    let ratings: Double
    let openHours: String
    let address: String
    let place: HospitalLocation
    let directionLink: String
}
