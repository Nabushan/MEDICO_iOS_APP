//
//  AppointmentClassProtocol.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 26/10/22.
//

import Foundation
import UIKit

protocol SplitViewCommunicationProtocol: AnyObject {
    func didSelectInParentView(_ index: Int)
    func didSelectInParentView(_ consultation: ConsultationGetter)
    func shouldReloadParentView()
}

extension SplitViewCommunicationProtocol {
    func didSelectInParentView(_ index: Int) {
        
    }
    
    func didSelectInParentView(_ consultation: ConsultationGetter) {
        
    }
    
    func shouldReloadParentView() {
        
    }
}

protocol AppointmentRequirmentProtocol: AnyObject {
    
}

protocol AppointmentListProtocol: AnyObject {
    var formatter: DateFormatter { get set }
    var isSearchBarActive: Bool { get set }
}

protocol AppointmentTableViewCellProtocol: AnyObject {
    var consultation: ConsultationGetter? { set get }
    var doctorImageView: ImageLoader { set get }
    var doctorName: ResizedLabel { get set }
    var delegate: AppointmentFunctionTableViewCellProtocol? { get set }
}

protocol AppointmentCancellingProtocol: AnyObject {
    func showCancelReason(_ consultation: ConsultationGetter)
    func confirmCancelAppointment(_ consultation: ConsultationGetter)
    func showTabBar()
    func hideTabBar()
}

extension AppointmentCancellingProtocol {
    func confirmCancelAppointment(_ consultation: ConsultationGetter) {
        
    }
    
    func showCancelReason(_ consultation: ConsultationGetter) {
        
    }
    
    func showTabBar() {
        
    }
    
    func hideTabBar() {
        
    }
}

protocol AppointmentFunctionTableViewCellProtocol: AnyObject {
    func cancelAppointment(_ consultation: ConsultationGetter)
    func rescheduleAppointment(_ consultation: ConsultationGetter)
    func bookAppointment(_ consultation: ConsultationGetter)
    func leaveAReview(_ consultation: ConsultationGetter)
}

extension AppointmentFunctionTableViewCellProtocol {
    func cancelAppointment(_ consultation: ConsultationGetter) {
        
    }
    
    func rescheduleAppointment(_ consultation: ConsultationGetter) {
        
    }
    
    func bookAppointment(_ consultation: ConsultationGetter) {
        
    }
    
    func leaveAReview(_ consultation: ConsultationGetter) {
        
    }
}

protocol ReBookingProtocol: AnyObject {
    func fetchAndReloadCollectionView()
}

protocol AppointmentMarkingCompletedAndCancellingProtocol: AnyObject, ReBookingProtocol {
    
}

protocol WriteAReviewProtocol: AnyObject {
    
}
