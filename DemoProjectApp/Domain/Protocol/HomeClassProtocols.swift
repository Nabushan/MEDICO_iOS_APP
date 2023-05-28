//
//  File.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/09/22.
//

import Foundation
import UIKit

protocol HomeVCDelegate: AnyObject {
    var reminderTableView: UITableView { get set }
    var zeroReminderLabel: ResizedLabel! { get set }
    var medicalArticleCollectionView: UICollectionView { get set }
    func reloadReminderTableView()
}

protocol AddMedicineVCProtocol: AnyObject {
    
}

protocol SelectDateAndTimeForReminderProtocol: AnyObject {
    func loadDateAndTime(for array: [ReminderDateAndTime], selectedRepeatState: ReminderRepeatPreference)
}

protocol SelectDateAndTimeContentForReminderProtocol: AnyObject {
    var dateFormatter: DateFormatter { get }
}

protocol ReminderRepeatProtocol: AnyObject {
    
}

protocol ReminderRepeatSelectionCommunicationProtocol: AnyObject {
    func updateSelectedRepeatPreference(for selectedState: ReminderRepeatPreference)
}

protocol ReminderListVCProtocol: AnyObject {
    var searchController: UISearchController { get }
}

protocol ReminderPostDeletionProtocol: AnyObject {
    func getNonDeletedReminders()
}

protocol MedicineInformationVCProtocol: AnyObject {
    
}

protocol DoctorListVCProtocol: AnyObject {
    
}

protocol DoctorProfileVCProtocol: AnyObject {
    
}

protocol EmergencyProtocol: AnyObject {
    
}

protocol EmergencyProfileProtocol: AnyObject {
    var emergencyContactsTableView: UITableView { get }
}

protocol EmergencyValueStorageProtocol: Codable {
    static var key: String { get }
}

protocol PharmacyProfileProtocol: AnyObject {
    
}

protocol PharmacyWriteAReviewProtocol: AnyObject {
    
}

protocol PharmacyListProtocol: AnyObject {
    var isSearchActive: Bool { get set }
}

protocol PaymentProtocol: AnyObject {
    
}

protocol PinCheckerProtocol: AnyObject {
    
}

protocol PaymentsAddNewCardProtocol: AnyObject {
    func addNewCard()
}

protocol AddedCardDetailUpdationProtocol: AnyObject {
    var collectionView: UICollectionView { get }
    var previouslySelectedRowText: String { get set }
    func updateTableView()
}

protocol ShowAvailableCardForChangeProtocol: AnyObject {
    var reviewSummary: ReviewSummary { get }
    func showAvailableCards(selectedCardNumber: String)
}

protocol ChangeCardForPaymentProtocol: AnyObject {
    func changeSelectedCardOfReviewSummary(to selectedCard: SelectedCard)
    func reloadPaymentCardRow()
}

protocol SegueToParentProtocol: AnyObject {
    func segueToParent()
}

extension PaymentsAddNewCardProtocol {
    func addNewCard() {
        
    }
}

protocol AddToCartProtocol: AnyObject {
    
}

protocol SeeAllReviewsProtocol: AnyObject {
    
}

protocol PharmacyAvailableProductsProrocol: AnyObject {
    
}

protocol HospitalsListingProtocol: AnyObject {
    
}

protocol PersonDetailsAutoFillProtocol: AnyObject {
    func autoFillDetails(_ person: Person)
}
