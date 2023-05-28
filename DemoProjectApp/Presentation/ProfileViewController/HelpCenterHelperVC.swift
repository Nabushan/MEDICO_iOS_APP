//
//  HelpCenterHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 12/12/22.
//

import Foundation

class HelpCenterHelperVC {
    weak var delegate: HelpCenterProtocol?
    private let helpCenterData = HelpCenterData()
    
    var selectedState: Query = .faq
    var frequentlyAskedQuestions: [FAQ] = []
    var contactUs: [ContactUs] = []
    
    init() {
        frequentlyAskedQuestions = helpCenterData.getFAQs()
        contactUs = helpCenterData.getContactUsData()
    }
}
