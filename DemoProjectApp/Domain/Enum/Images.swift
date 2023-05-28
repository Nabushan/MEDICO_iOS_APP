//
//  Images.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 03/10/22.
//

import Foundation

enum ImageCategory: Int, RawRepresentable, CaseIterable {
    case emergency = 0
    
    var name: String {
        switch(self){
        case .emergency: return "Emergency"
        }
    }
}
