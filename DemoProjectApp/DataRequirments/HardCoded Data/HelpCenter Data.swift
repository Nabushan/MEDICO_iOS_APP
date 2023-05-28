//
//  FAQs.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 12/12/22.
//

import Foundation

class HelpCenterData {
    func getFAQs() -> [FAQ] {
        let faq: [FAQ] = [
            FAQ(question: "What is Medico App?", answer: "India’s Most Trusted Pharmacy App for Online Medicines, Lab Tests & Doctor Consultations Medico App is the best online doctor and pharmacy app which brings you medicine delivery, doctor consultations and lab tests on one single platform. With the Medico medicine app, you will never have to worry again about your medicine delivery."),
            FAQ(question: "How to use Medico App?", answer: "All the patient information will only be disclosed to the respective user and to the doctor for treatment purposes only. We make sure that all your data and medication history remains safe and secure with us."),
            FAQ(question: "How to cancel an appointment in Medico App?", answer: "In the Appoinments page under the Upcoming section you'll find the option for Cancelling, Upon clicking it enter the reason for cancelling, then click on submit, but only the intimated amount will be refunded."),
            FAQ(question: "How to reschedule an Appointment in Medico App?", answer: "In the Appoinments page under the Upcoming section you'll find the option for Rescheduling, Upon clicking it enter the reason for rescheduling, then select a suitable date and time to reschedule. Upon doing so your appointment will be rescheduled successfully."),
        ]
        
        return faq
    }
    
    func getContactUsData() -> [ContactUs] {
        let contactUs: [ContactUs] = [
            ContactUs(queryImageName: "beats.headphones", queryName: "Customer Service"),
            ContactUs(queryImageName: "globe", queryName: "Website"),
            ContactUs(queryImageName: "mail.stack", queryName: "Mail"),
            ContactUs(queryImageName: "ellipsis.message", queryName: "Message"),
        ]
        
        return contactUs
    }
}
