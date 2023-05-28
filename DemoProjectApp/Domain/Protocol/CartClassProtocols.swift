//
//  CartClassProtocols.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 14/12/22.
//

import Foundation
import UIKit

protocol CartProtocol: AnyObject {
    var searchController: UISearchController { get set }
}

protocol EditCartObjectDetailProtocol: AnyObject {
    func hideTabBar()
    func showTabBar()
    func updateTheMedCountAndChangeQuantityInDb(forIndexPath: IndexPath, toValue: Int)
}

protocol CartCheckoutProtocol: AnyObject {
    func didTapCheckOut()
}

protocol CartCheckOutCompletionProtocol: AnyObject {
    func didCompleteCheckOut()
    func didCancelPayment()
}

protocol ShippingAddressProtocol: AnyObject {
    
}

protocol NewShippingAddressProtocol: AnyObject {
    
}

protocol ShippingAddressUpdateCommunicationProtocol: AnyObject {
    func reloadTableViewToShowAddedShippingAddress()
    var selectShippingAddressCell: ShippingAddress? { get set }
}

protocol CartPaymentCompletionProtocol: AnyObject {
    func didCompletePayment()
    func didCancelPayment()
}

protocol ViewInCartProtocol: AnyObject {
    func showCartVC()
}
