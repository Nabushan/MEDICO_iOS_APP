//
//  UserCartAddNewShippingAddressHelper.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import Foundation

class UserCartAddNewShippingAddressHelper {
    
    weak var delegate: NewShippingAddressProtocol?
    let validators: Validators
    
    init() {
        validators = Validators()
    }
    
    func validateContents(_ shippingAddress: ShippingAddress) -> AlertMessage {
        var alertMessage = AlertMessage(state: true, title: "Data Successfully Added", body: "Your Shipping Address has been added Successfully.")
        
        if(shippingAddress.name.count == 0){
            alertMessage.state = false
            alertMessage.title = "Name Field Empty."
            alertMessage.body = "Please make sure that the Name Field is filled."
        }
        else if(shippingAddress.contactNumber.count == 0){
            alertMessage.state = false
            alertMessage.title = "Contact Number Field Empty."
            alertMessage.body = "Please make sure that the Contact Number Field is filled."
        }
        else if(shippingAddress.doorNumber.count == 0){
            alertMessage.state = false
            alertMessage.title = "Door Number Field Empty."
            alertMessage.body = "Please make sure that the Door Number Field is filled."
        }
        else if(shippingAddress.addressLine1.count == 0){
            alertMessage.state = false
            alertMessage.title = "Address Line One Field Empty."
            alertMessage.body = "Please make sure that the Address Line One Field is filled."
        }
        else if(shippingAddress.addressLine2.count == 0){
            alertMessage.state = false
            alertMessage.title = "Address Line Two Field Empty."
            alertMessage.body = "Please make sure that the Address Line Two Field is filled."
        }
        else if(shippingAddress.pincode.count == 0){
            alertMessage.state = false
            alertMessage.title = "Pincode Field Empty."
            alertMessage.body = "Please make sure that the Pincode Field is filled."
        }
        else if(!validators.isContentValid(shippingAddress.name)) {
            alertMessage.state = false
            alertMessage.title = "Invalid Content"
            alertMessage.body = "The content entered into name field is invalid please make sure that you have entered a proper content"
        }
        else if(!shippingAddress.contactNumber.isPhoneNumber || shippingAddress.contactNumber.count != 10) {
            alertMessage.state = false
            alertMessage.title = "Invalid Content"
            alertMessage.body = "The content entered into Contact Number field is invalid please make sure that you have entered a proper content"
        }
        else if(!validators.isContentValidDoorNumber(shippingAddress.doorNumber)) {
            alertMessage.state = false
            alertMessage.title = "Invalid Content"
            alertMessage.body = "The content entered into door Number field is invalid please make sure that you have entered a proper content"
        }
        else if(!validators.isContentValidAlphaNumeric(shippingAddress.addressLine1)) {
            alertMessage.state = false
            alertMessage.title = "Invalid Content"
            alertMessage.body = "The content entered into Address Line1 field is invalid please make sure that you have entered a proper content"
        }
        else if(!validators.isContentValidAlphaNumeric(shippingAddress.addressLine2)) {
            alertMessage.state = false
            alertMessage.title = "Invalid Content"
            alertMessage.body = "The content entered into Address Line2 field is invalid please make sure that you have entered a proper content"
        }
        else if(!validators.validateIfNumber(shippingAddress.pincode) || shippingAddress.pincode.count != 6) {
            alertMessage.state = false
            alertMessage.title = "Invalid Content"
            alertMessage.body = "The content entered into Pincode field is invalid please make sure that you have entered a proper content"
        }
        
        return alertMessage
    }
    
    func addShippingAddress(_ shippingAddress: ShippingAddress) {
        DBManager.sharedInstance.addToShippingAddress(shippingAddress)
    }
    
    func updateShippingAddress(forId: Int, _ shippingAddress: ShippingAddress) {
        DBManager.sharedInstance.updateShippingAddress(forId: forId, shippingAddress)
    }
}
