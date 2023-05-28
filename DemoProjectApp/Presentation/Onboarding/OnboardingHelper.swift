//
//  OnboardingHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 29/12/22.
//

import Foundation

class OnboardingHelper {
    var data: [Onboarding] = []
    var darkModeImages: [String] = ["Onboarding  Image 1 Dark Mode", "Onboarding  Image 2 Dark Mode", "Onboarding  Image 3 Dark Mode"]
    
    weak var delegate: OnboardingProtocol?
    
    init() {
        loadOnboardingData()
    }
    
    func loadOnboardingData() {
        data = [
            Onboarding(imageName: "Onboarding Image 1",
                       labelContent: "Thousands of doctors & experts to help your health!"),
            Onboarding(imageName: "Onboarding Image 2",
                       labelContent: "Health checks & consultations easily anywhere anytime"),
            Onboarding(imageName: "Onboarding Image 3",
                       labelContent: "Let's start living healthy and well with us right now!"),
        ]
    }
    
    
}
