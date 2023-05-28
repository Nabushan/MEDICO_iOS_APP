//
//  BookAppointmentPaymentsAddNewCardHelperVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 17/10/22.
//

import Foundation

class PaymentsAddNewCardHelperVC {
    
    weak var delegate: PaymentsAddNewCardProtocol?
    let validator: Validators
    
    init(){
        validator = Validators()
    }
    
    func addCardDetailsToDB(_ card: CardDetails){
        DBManager.sharedInstance.addPaymentOption(card)
    }
    
    func validateCardDetail(_ card: CardDetails) -> AlertMessage {
        var alertMessage = AlertMessage(state: true, title: "Successfully Added", body: "Your card Details have been added Successfully.")
        
        if(card.cardName.count == 0) {
            alertMessage.state = false
            alertMessage.title = "Empty Card Holder Name Field"
            alertMessage.body = "Please make sure that the Card Holder Name Field is filled."
        }
        else if(card.cardNumber.count == 0) {
            alertMessage.state = false
            alertMessage.title = "Empty Card Number Field"
            alertMessage.body = "Please make sure that the Card Number Field is filled."
        }
        else if(card.expiryDate.count == 0) {
            alertMessage.state = false
            alertMessage.title = "Empty Expiry Date Field"
            alertMessage.body = "Please make sure that the Expiry Date Field is filled."
        }
        else if(card.cvvNumber.count == 0) {
            alertMessage.state = false
            alertMessage.title = "Empty CVV Number Field"
            alertMessage.body = "Please make sure that the CVV Number Field is filled."
        }
        else if(card.cardType.typeName.count == 0) {
            alertMessage.state = false
            alertMessage.title = "Empty Card Type Field"
            alertMessage.body = "Please make sure that the Card Type Field is filled."
        }
        else if(!validator.isContentValid(card.cardName)){
            alertMessage.state = false
            alertMessage.title = "Invalid Name"
            alertMessage.body = "Please make sure that the Name entered in Name Field is valid."
        }
        else if(card.cardNumber.count != 19 || !validator.validateIfCardNumber(card.cardNumber)) {
            alertMessage.state = false
            alertMessage.title = "Invalid Card Number"
            alertMessage.body = "Please make sure that the Card Number entered in Card Number Field is valid."
        }
        else if(!validator.validateIfNumber(card.cvvNumber)) {
            alertMessage.state = false
            alertMessage.title = "Invalid CVV"
            alertMessage.body = "Please make sure that the CVV entered in CVV Field is valid."
        }
        
        return alertMessage
    }
}
