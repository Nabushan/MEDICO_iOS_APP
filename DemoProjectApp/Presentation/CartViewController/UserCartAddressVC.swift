//
//  UserCartAddressVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import UIKit

class UserCartAddressVC: UIViewController, ShippingAddressProtocol, ShippingAddressUpdateCommunicationProtocol, CartPaymentCompletionProtocol {

    override var sheetPresentationController: UISheetPresentationController! {
        return presentationController as? UISheetPresentationController
    }
    
    lazy var completePaymentButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Complete Payment", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.register(CartShippingAddressTableViewCell.self, forCellReuseIdentifier: CartShippingAddressTableViewCell.identifier)
        
        tableView.register(CartShippingAddAddressTableViewCell.self, forCellReuseIdentifier: CartShippingAddAddressTableViewCell.identifier)
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return tableView
    }()
    
    let userCartAddressHelper: UserCartAddressHelper
    var previouslySelectedCell: CartShippingAddressTableViewCell?
    
    var delegate: CartCheckOutCompletionProtocol?
    var selectShippingAddressCell: ShippingAddress?
    
    init() {
        userCartAddressHelper = UserCartAddressHelper()
        
        super.init(nibName: nil, bundle: nil)
        
        userCartAddressHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = tableView.backgroundColor
        
        view.addSubview(completePaymentButton)
        view.addSubview(tableView)
        
        configureTableView()
        configureSheetPresentationController()
        loadTableView()
        loadCompletePaymentButton()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSheetPresentationController() {
        sheetPresentationController.delegate = self
        sheetPresentationController.detents = [.medium(), .large()]
        sheetPresentationController.preferredCornerRadius = 10
        sheetPresentationController.prefersGrabberVisible = true
    }
    
    func loadTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: completePaymentButton.topAnchor, constant: -10)
        ])
    }
    
    func loadCompletePaymentButton() {
        completePaymentButton.translatesAutoresizingMaskIntoConstraints = false
        
        completePaymentButton.addTarget(self, action: #selector(didTapCompletePayment), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            completePaymentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            completePaymentButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            completePaymentButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
        
        completePaymentButton.layer.cornerRadius = 10
    }
    
    @objc func didTapCompletePayment(_ sender: UIButton) {
        print("Tapped Complete Payment Button.")
        
        guard let _ = previouslySelectedCell else {
            
            let alertViewController = UIAlertController(title: "Shipping Address Not Selected", message: "Please make sure that you have selected your designated shipping address.", preferredStyle: .alert)
            alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
            
            present(alertViewController, animated: true)
            
            return
        }
        
        let paymentsVC = PaymentsPinCheckerVC(isFromCart: true)
        paymentsVC.cartPaymentCompletionDelegate = self
        
        present(paymentsVC, animated: true)
    }
    
    func addNewShippingAddress() {
        print("Add New Shipping Address Tapped.")
        
        var count = 0
        
        if(userCartAddressHelper.shippingAddresses.count > 0) {
            count = userCartAddressHelper.shippingAddresses[userCartAddressHelper.shippingAddresses.count - 1].id
        }
        
        let addNewShippingAddressVC = UserCartAddNewShippingAddressVC(previousAddressListCount: count)
        addNewShippingAddressVC.delegateForShippingAddressCommunication = self
        
        let addNewShippingAddressNavVC = UINavigationController(rootViewController: addNewShippingAddressVC)
        
        addNewShippingAddressNavVC.customiseNavBarAppearance()
        
        present(addNewShippingAddressNavVC, animated: true)
    }
    
    func editShippingAddress(_ index: Int, _ indexPath: IndexPath) {
        print("Edit Shipping Address Tapped.")
        
        let addNewShippingAddressVC = UserCartAddNewShippingAddressVC(isForEditingShippingAddress: true, forId: index, userCartAddressHelper.shippingAddresses[indexPath.row])
        addNewShippingAddressVC.delegateForShippingAddressCommunication = self
        
        let addNewShippingAddressNavVC = UINavigationController(rootViewController: addNewShippingAddressVC)
        
        addNewShippingAddressNavVC.customiseNavBarAppearance()
        
        present(addNewShippingAddressNavVC, animated: true)
    }
    
    func reloadTableViewToShowAddedShippingAddress() {
        userCartAddressHelper.loadShippingAddress()
        tableView.reloadData()
    }
    
    func didCompletePayment() {
        delegate?.didCompleteCheckOut()
        self.dismiss(animated: true)
    }
    
    func didCancelPayment() {
        delegate?.didCancelPayment()
        self.dismiss(animated: true)
    }
    
    func updateSelectedShippingAddress(_ indexPath: IndexPath) {
        if(indexPath.row == self.userCartAddressHelper.shippingAddresses.count) {
            if(indexPath.row - 1 > -1) {
                guard let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row - 1, section: indexPath.section)) as? CartShippingAddressTableViewCell else {
                    return
                }
                
                cell.isCellSelected(true)
                previouslySelectedCell = cell
            }
        }
        else if(self.userCartAddressHelper.shippingAddresses.count > 0) {
            guard let cell = tableView.cellForRow(at: indexPath) as? CartShippingAddressTableViewCell else {
                return
            }
            
            cell.isCellSelected(true)
            previouslySelectedCell = cell
        }
    }
}

extension UserCartAddressVC: UISheetPresentationControllerDelegate {
    
}

extension UserCartAddressVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            if(userCartAddressHelper.shippingAddresses.count == 0){
                addNewShippingAddress()
            }
            return userCartAddressHelper.shippingAddresses.count
        }
        else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CartShippingAddAddressTableViewCell.identifier) as? CartShippingAddAddressTableViewCell else {
                return UITableViewCell()
            }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartShippingAddressTableViewCell.identifier) as? CartShippingAddressTableViewCell else {
            return UITableViewCell()
        }
        
        cell.shippingAddress = userCartAddressHelper.shippingAddresses[indexPath.row]
        
        if let selectShippingAddressCell = selectShippingAddressCell, let cellShippingAddress = cell.shippingAddress {
            if(selectShippingAddressCell == cellShippingAddress) {
                
                if(previouslySelectedCell != nil) {
                    previouslySelectedCell?.isCellSelected(false)
                }
                
                previouslySelectedCell = cell
                previouslySelectedCell?.isCellSelected(true)
            }
        }
        else{
            if(indexPath.section == 0 && indexPath.row == 0){
                cell.isCellSelected(true)
                previouslySelectedCell = cell
            }
            else{
                cell.isCellSelected(false)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 1) {
            addNewShippingAddress()
        }
        else {
            
            guard let cell = tableView.cellForRow(at: indexPath) as? CartShippingAddressTableViewCell else {
                return
            }
            
            if(previouslySelectedCell == nil){
                previouslySelectedCell = cell
                previouslySelectedCell?.isCellSelected(true)
                tableView.deselectRow(at: indexPath, animated: true)
                return
            }
            
            previouslySelectedCell?.isCellSelected(false)
            previouslySelectedCell = cell
            previouslySelectedCell?.isCellSelected(true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0 && userCartAddressHelper.shippingAddresses.count != 0){
            return "Select Shipping Address"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if(indexPath.section == 1){
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, _, _ in
            
            let alertController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default){_ in
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
            
            alertController.addAction(UIAlertAction(title: "Delete", style: .destructive){_ in
                self.userCartAddressHelper.removeShippingAddress(index: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
                self.updateSelectedShippingAddress(indexPath)
            })
            
            self.present(alertController, animated: true)
            
        }
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        if(indexPath.section == 1) {
            return nil
        }
        
        let menu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            let deleteAction = UIAction(title: "Delete",
                                        image: UIImage(systemName: "trash"),
                                        identifier: nil,
                                        discoverabilityTitle: nil,
                                        attributes: .destructive,
                                        state: .off) { _ in
                
                let alertController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
                
                alertController.addAction(UIAlertAction(title: "Delete", style: .destructive){_ in
                    self.userCartAddressHelper.removeShippingAddress(index: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    
                    self.updateSelectedShippingAddress(indexPath)
                })
                
                self.present(alertController, animated: true)
            }
            
            let editAction = UIAction(title: "Edit",
                                      image: UIImage(systemName: "square.and.pencil"),
                                      identifier: nil,
                                      discoverabilityTitle: nil,
                                      state: .off) { _ in
              
              let alertController = UIAlertController(title: "Edit Action", message: "Are you sure you want to edit this address", preferredStyle: .alert)
              
              alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
              
              alertController.addAction(UIAlertAction(title: "Edit", style: .default){_ in
                  self.editShippingAddress(self.userCartAddressHelper.shippingAddresses[indexPath.row].id, indexPath)
                  self.updateSelectedShippingAddress(indexPath)
              })
              
              self.present(alertController, animated: true)
          }
            
            let menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [deleteAction, editAction])
            
            return menu
        }
        
        return menu
    }
}
