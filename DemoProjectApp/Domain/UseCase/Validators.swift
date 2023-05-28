//
//  Validators.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/09/22.
//

import Foundation

class Validators {
    func isPasswordValid(_ password: String) -> Bool {
        let regexRequirment = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[0-9]).{6,}$"
        
        let range = NSRange(location: 0, length: password.utf16.count)
        let regex = try? NSRegularExpression(pattern: regexRequirment)
        let match = regex?.firstMatch(in: password,options: [], range: range)
        
        return match != nil
    }
    
    func isContentValid(_ name: String) -> Bool {
        let regexRequirment = #"^[A-Za-z\s]+$"#
        
        let range = NSRange(location: 0, length: name.utf16.count)
        let regex = try? NSRegularExpression(pattern: regexRequirment)
        let match = regex?.firstMatch(in: name,options: [], range: range)
        
        return match != nil
    }
    
    func isContentValidDoorNumber(_ name: String) -> Bool {
        let regexRequirment = "^[^@!#$%^&*()<>?'{}~`]+$"
        
        let range = NSRange(location: 0, length: name.utf16.count)
        let regex = try? NSRegularExpression(pattern: regexRequirment)
        let match = regex?.firstMatch(in: name,options: [], range: range)
        
        return match != nil
    }
    
    func isContentValidAlphaNumeric(_ name: String) -> Bool {
        let regexRequirment = "(?=.*[A-Za-z0-9])"
        
        let range = NSRange(location: 0, length: name.utf16.count)
        let regex = try? NSRegularExpression(pattern: regexRequirment)
        let match = regex?.firstMatch(in: name,options: [], range: range)
        
        return match != nil
    }
    
    func validateIfNumber(_ age: String) -> Bool {
        let regexRequirment = "^[0-9]+$"
        
        let range = NSRange(location: 0, length: age.utf16.count)
        let regex = try? NSRegularExpression(pattern: regexRequirment)
        let match = regex?.firstMatch(in: age,options: [], range: range)
        
        return match != nil
    }
    
    func validateIfCardNumber(_ age: String) -> Bool {
        let regexRequirment = "^[0-9\\s]+$"
        
        let range = NSRange(location: 0, length: age.utf16.count)
        let regex = try? NSRegularExpression(pattern: regexRequirment)
        let match = regex?.firstMatch(in: age,options: [], range: range)
        
        return match != nil
    }
    
    func validateEmailId(_ id: String) -> Bool {
        let regexRequirment = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        "([a-zA-z.0-9]{2,})@([a-z]{2,})\\.([a-z]{2,})\\.?([a-z]{2,})?" => proper way.
        
        let range = NSRange(location: 0, length: id.utf16.count)
        let regex = try? NSRegularExpression(pattern: regexRequirment)
        let match = regex?.firstMatch(in: id, range: range)
        
        return match != nil
    }
}
