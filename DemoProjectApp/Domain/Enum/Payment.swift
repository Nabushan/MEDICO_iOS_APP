//
//  Payment.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 17/10/22.
//

import Foundation

enum PaymentType: Int, RawRepresentable {
    case applePay = 0
    case googlePay
    case payPal
    case masterCard
    case visa
    
    var typeName: String {
        switch(self){
        case .applePay: return "Apple Pay"
        case .googlePay: return "Google Pay"
        case .payPal: return "Pay Pal"
        case .masterCard: return "Master Card"
        case .visa: return "Visa"
        }
    }
}
