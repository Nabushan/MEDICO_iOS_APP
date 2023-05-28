//
//  Query Type.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 12/12/22.
//

import Foundation

enum Query: Int, CaseIterable {
    case faq = 0
    case contactUS
    
    var queryName: String {
        switch(self){
        case .faq: return "FAQ's"
        case .contactUS: return "Contact Us"
        }
    }
}
