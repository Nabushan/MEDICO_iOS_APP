//
//  BookAppointmentPaymentsHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 17/10/22.
//

import Foundation
import UIKit

class PaymentsHelperVC {
    
    var cardDetails: [CardDetails] = []
    let cardImageLinks: [String] = [
        "https://assets.stickpng.com/images/580b57fcd9996e24bc43c516.png",
        "https://freepngimg.com/save/66903-google-pay-gboard-platform-logo-cloud/1734x1662",
        "https://www.nicepng.com/png/detail/19-194337_paypal-logo-transparent-png-paypal-logo-transparent.png",
        "https://www.pngfind.com/pngs/m/328-3281030_mastercard-logo-png-mastercard-png-transparent-png.png",
        "https://toppng.com/uploads/preview/visa-115507187089o8siwhhtf.png"
    ]
    
    var cardImages: [UIImage] = []
    
    weak var delegate: PaymentProtocol?
    
    init() {
        
        fetchCardDetails()
        loadCardImages()
    }
    
    func fetchCardDetails() {
        cardDetails = DBManager.sharedInstance.getRowsFromPaymentOptionsTable()
    }
    
    func loadCardImages() {
        let imageNames = ["Apple Pay", "Gpay", "Pay Pal", "Master Card", "Visa"]
        
        for imageName in imageNames {
            if(imageName == "Apple Pay"){
                guard let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal).withTintColor(.label) else {
                    return
                }
                
                cardImages.append(image)
            }
            else{
                guard let image = UIImage(named: imageName) else {
                    return
                }
                
                cardImages.append(image)
            }
        }
    }
}
