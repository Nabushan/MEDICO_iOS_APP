//
//  ReviewSummaryStruct.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 14/10/22.
//

import Foundation
import UIKit

struct ReviewSummary {
    var doctorId: Int?
    var docImage: String?
    var docName: String?
    var docDesignation: DoctorSpecialization
    var docAddress: String?
    var package: String?
    var duration: String?
    var amount: Double?
    var date: String?
    var hourSlot: String?
    var selectedCardType: SelectedCard?
}

struct SelectedCard {
    var cardImage: UIImage
    var cardDetail: PaymentType
    var arrtibutedCardNumber: NSAttributedString
    var cardNumber: String
}
