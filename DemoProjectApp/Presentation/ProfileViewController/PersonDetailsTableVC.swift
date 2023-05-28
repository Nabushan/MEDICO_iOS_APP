//
//  PersonDetailsTableVC.swift
//  Medico
//
//  Created by nabushan-pt5611 on 01/02/23.
//

import UIKit

class PersonDetailsTableVC: UIViewController, PersonDetailsProtocol {
    
    var personDetailsTableHelper: PersonDetailsTableHelper
    var isToAddOrEditPersonDetails: Bool = false
    var isEditingDetails: Bool?
    var personDetails: Person?
    
    var doneBarButton: UIBarButtonItem = UIBarButtonItem()
    var infoBarButton: UIBarButtonItem = UIBarButtonItem()
    var isFromBookingAppointments = false
    
    weak var autoFillDelegate: PersonDetailsAutoFillProtocol? {
        didSet {
            isFromBookingAppointments = true
            
            infoBarButton = UIBarButtonItem(image: UIImage(systemName: "info.circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(didTapCancel))
            
            navigationItem.rightBarButtonItem = infoBarButton
        }
    }
    
    var textFields: [TextFieldWithPadding] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.keyboardDismissMode = .onDrag
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        tableView.register(PersonDetailTableViewCell.self, forCellReuseIdentifier: PersonDetailTableViewCell.identifier)
        
        tableView.register(CartShippingAddAddressTableViewCell.self, forCellReuseIdentifier: CartShippingAddAddressTableViewCell.identifier)
        
        tableView.register(CartShippingNewAddressEntryTableViewCell.self, forCellReuseIdentifier: CartShippingNewAddressEntryTableViewCell.identifier)
        
        return tableView
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        
        datePicker.maximumDate = Date.now
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -150, to: Date.now)
        
        datePicker.clipsToBounds = true
        
        return datePicker
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MMM-YYYY"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        
        return formatter
    }()
    
    lazy var viewForPickerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = self.view.backgroundColor
        
        return view
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    lazy var viewForDatePicker: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var datePickerBlurEffect: UIVisualEffectView = {
        let blurEffect = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        blurEffect.layer.opacity = 0.4
        
        return blurEffect
    }()
    
    var toolBar: UIToolbar!
    
    init(isToAddOrEditPersonDetails: Bool, isEditingDetails: Bool?, personDetails: Person?) {
        personDetailsTableHelper = PersonDetailsTableHelper()
        self.isToAddOrEditPersonDetails = isToAddOrEditPersonDetails
        self.isEditingDetails = isEditingDetails
        self.personDetails = personDetails
        
        super.init(nibName: nil, bundle: nil)
        
        personDetailsTableHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Person Details"
        view.backgroundColor = tableView.backgroundColor
        
        view.addSubview(tableView)
        
        viewForPickerView.isHidden = true
        viewForDatePicker.isHidden = true
        configureTableView()
        loadTableView()
        
        if(isToAddOrEditPersonDetails) {
            toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
            toolBar.sizeToFit()
            
            view.addSubview(viewForPickerView)
            viewForPickerView.addSubview(toolBar)
            viewForPickerView.addSubview(pickerView)
            
            
            view.addSubview(viewForDatePicker)
            viewForDatePicker.addSubview(datePickerBlurEffect)
            viewForDatePicker.addSubview(datePicker)
            
            viewForDatePicker.bringSubviewToFront(datePicker)
            
            configurePickerView()
            loadViewForPickerView()
            loadViewForDatePicker()
            
            doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
            infoBarButton = UIBarButtonItem(image: UIImage(systemName: "info.circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(didTapCancel))
            
            navigationItem.rightBarButtonItem = doneBarButton
            
            if let  _ = personDetails {
                self.title = "Edit Person Details"
            }
            else{
                self.title = "Add Person Details"
            }
        }
    }

    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapAccessoryViewCancel))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelBarButton, flexibleSpace], animated: true)
    }
    
    @objc func didTapAccessoryViewCancel(_ sender: UIBarButtonItem) {
        textFields[2].text = ""
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapDone(_ sender: UIBarButtonItem) {
        
        guard let name = textFields[0].text,
              let dob = textFields[1].text,
              let gender = textFields[2].text else {
            return
        }
        
        let person = Person(id: personDetailsTableHelper.personDetails.count + 1,
                            name: name,
                            dateOfBirth: dob,
                            gender: gender)
        
        let result = personDetailsTableHelper.validate(person)
        
        let alertView = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        if(result.state) {
            alertView.title = result.title
            alertView.message = result.body
            
            if let personDetails = personDetails {
                personDetailsTableHelper.updatePersonDetails(person, forId: personDetails.id)
                self.navigationController?.popViewController(animated: true)
            }
            else{
                personDetailsTableHelper.addPersonDetails(person)
                self.navigationController?.popViewController(animated: true)
            }
            
            alertView.addAction(UIAlertAction(title: "Okay", style: .default){_ in
                self.navigationController?.popViewController(animated: true)
            })
            
            return
        }
        else{
            alertView.title = result.title
            alertView.message = result.body
            
            alertView.addAction(UIAlertAction(title: "Okay", style: .default))
        }
        
        self.present(alertView, animated: true)
    }
    
    @objc func didTapCancel(_ sender: UIBarButtonItem) {
        let alertView = UIAlertController(title: "Quick help", message: "Long press the shown data for more actions, swipe for delete Action.", preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction(title: "Okay", style: .default))
        
        self.present(alertView, animated: true)
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == datePickerBlurEffect) {
            tapGesture.addTarget(self, action: #selector(hideDatePicker))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func showPickerView() {
        if(textFields[2].text?.count == 0) {
            textFields[2].text = personDetailsTableHelper.genderChoice[0]
        }
        
        viewForPickerView.isHidden = false
    }
    
    @objc func showDatePicker() {
        tableView.isScrollEnabled = false
        viewForDatePicker.isHidden = false
    }
    
    @objc func hideDatePicker(_ sender: UITapGestureRecognizer) {
        tableView.isScrollEnabled = true
        viewForDatePicker.isHidden = true
    }
    
    @objc func didSelectDate(_ sender: UIDatePicker) {
        textFields[1].text = formatter.string(from: sender.date)
        
        tableView.isScrollEnabled = true
    }
    
    func loadTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func loadViewForDatePicker() {
        viewForDatePicker.translatesAutoresizingMaskIntoConstraints = false
        datePickerBlurEffect.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.backgroundColor = .systemBackground
        
        viewForDatePicker.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            viewForDatePicker.topAnchor.constraint(equalTo: view.topAnchor),
            viewForDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewForDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewForDatePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            datePickerBlurEffect.topAnchor.constraint(equalTo: viewForDatePicker.topAnchor),
            datePickerBlurEffect.leadingAnchor.constraint(equalTo: viewForDatePicker.leadingAnchor),
            datePickerBlurEffect.trailingAnchor.constraint(equalTo: viewForDatePicker.trailingAnchor),
            datePickerBlurEffect.bottomAnchor.constraint(equalTo: viewForDatePicker.bottomAnchor),
            
            datePicker.centerXAnchor.constraint(equalTo: viewForDatePicker.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: viewForDatePicker.centerYAnchor),
        ])
        
        datePicker.layer.cornerRadius = 10
        datePicker.addTarget(self, action: #selector(didSelectDate), for: .valueChanged)
        addTapGesture(toView: datePickerBlurEffect)
    }
    
    func loadViewForPickerView() {
        viewForPickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let toolBarHeight = CGFloat(50)
        
        let constraints = [
            viewForPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewForPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewForPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            viewForPickerView.heightAnchor.constraint(equalToConstant: (0.3 * view.frame.height) + toolBarHeight),
            
            pickerView.widthAnchor.constraint(equalTo: viewForPickerView.widthAnchor),
            pickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            pickerView.centerXAnchor.constraint(equalTo: viewForPickerView.centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: viewForPickerView.bottomAnchor),
            
            toolBar.bottomAnchor.constraint(equalTo: pickerView.topAnchor),
            toolBar.centerXAnchor.constraint(equalTo: viewForPickerView.centerXAnchor),
            toolBar.widthAnchor.constraint(equalTo: viewForPickerView.widthAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: toolBarHeight)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func getContextMenuForEditingDetails(_ person: Person, indexPath: IndexPath) -> UIContextMenuConfiguration {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { menu in
            let editAction = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { action in
                let viewController = PersonDetailsTableVC(isToAddOrEditPersonDetails: true, isEditingDetails: true, personDetails: person)
                
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
            let alertView = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
            
            alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel){_ in
                self.tableView.reloadRows(at: [indexPath], with: .none)
            })
            
            alertView.addAction(UIAlertAction(title: "Delete", style: .destructive){_ in
                let person = self.personDetailsTableHelper.personDetails[indexPath.row]
                self.personDetailsTableHelper.removePersonDetails(forId: person.id)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                self.present(alertView, animated: true)
            }
            
            let menu = UIMenu(options: .singleSelection, children: [editAction, deleteAction])
            
            return menu
        }
        
        return contextMenu
    }
}

extension PersonDetailsTableVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if(isToAddOrEditPersonDetails) {
            return 3
        }
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isToAddOrEditPersonDetails) {
            return 1
        }
        else{
            if(section == 1) {
                return 1
            }
            return personDetailsTableHelper.personDetails.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(isToAddOrEditPersonDetails) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CartShippingNewAddressEntryTableViewCell.identifier, for: indexPath) as? CartShippingNewAddressEntryTableViewCell else {
                return UITableViewCell()
            }
            
            if let bool = isEditingDetails, bool == true {
                guard let personDetails = personDetails else {
                    return UITableViewCell()
                }
                
                switch(indexPath.section) {
                case 0:
                    cell.textField.text = personDetails.name
                case 1:
                    cell.textField.text = personDetails.dateOfBirth
                    cell.textField.isUserInteractionEnabled = false
                case 2:
                    cell.textField.text = personDetails.gender
                    cell.textField.isUserInteractionEnabled = false
                default:
                    ()
                }
                
                textFields.append(cell.textField)
                textFields[indexPath.section].delegate = self
                
                return cell
            }
            else{
                cell.textField.placeholder = personDetailsTableHelper.detailsPlaceHolder[indexPath.section]
            }
            
            textFields.append(cell.textField)
            textFields[indexPath.section].delegate = self
            
            switch(indexPath.section) {
            case 0:
                cell.textField.keyboardType = .alphabet
                cell.textField.returnKeyType = .next
            case 1:
                cell.textField.isUserInteractionEnabled = false
                
            case 2:
                cell.textField.isUserInteractionEnabled = false
                
            default:
                ()
            }
            
            return cell
        }
        else{
            if(indexPath.section == 1) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CartShippingAddAddressTableViewCell.identifier, for: indexPath) as? CartShippingAddAddressTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.addShippingAddressLabel.text = "Add New Person Detail"
                
                return cell
            }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonDetailTableViewCell.identifier, for: indexPath) as? PersonDetailTableViewCell else {
                return UITableViewCell()
            }
            
            cell.label.text = personDetailsTableHelper.personDetails[indexPath.row].name
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isFromBookingAppointments && indexPath.section == 0) {
            autoFillDelegate?.autoFillDetails(personDetailsTableHelper.personDetails[indexPath.row])
            
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.popViewController(animated: true)
            return
        }
        
        if(isToAddOrEditPersonDetails) {
            textFields[0].resignFirstResponder()
            if(indexPath.section == 2) {
                showPickerView()
            }
            else if(indexPath.section == 1) {
                showDatePicker()
            }
        }
        else {
            if(indexPath.section == 0) {
                let viewController = PersonDetailsTableVC(isToAddOrEditPersonDetails: true, isEditingDetails: true, personDetails: personDetailsTableHelper.personDetails[indexPath.row])
                
                navigationController?.pushViewController(viewController, animated: true)
            }
            else if(indexPath.section == 1) {
                let viewController = PersonDetailsTableVC(isToAddOrEditPersonDetails: true, isEditingDetails: false, personDetails: nil)
                
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 0) {
            return 10.0
        }
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if(indexPath.section == 1 || personDetailsTableHelper.personDetails.count == 0){
            return nil
        }
        
        let alertView = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel){_ in
            tableView.reloadRows(at: [indexPath], with: .none)
        })
        
        alertView.addAction(UIAlertAction(title: "Delete", style: .destructive){_ in
            let person = self.personDetailsTableHelper.personDetails[indexPath.row]
            self.personDetailsTableHelper.removePersonDetails(forId: person.id)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, _, _ in
            self.present(alertView, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        if(isFromBookingAppointments && indexPath.section == 0) {
            return getContextMenuForEditingDetails(personDetailsTableHelper.personDetails[indexPath.row], indexPath: indexPath)
        }
        return nil
    }
}

extension PersonDetailsTableVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        
        if(textField == textFields[2]) {
            if(textFields[0].isFirstResponder) {
                textFields[0].resignFirstResponder()
            }
            
            if(textFields[2].text?.count == 0) {
                textFields[2].text = personDetailsTableHelper.genderChoice[0]
            }
            viewForPickerView.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == textFields[2]) {
            viewForPickerView.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == textFields[0]) {
            textFields[0].resignFirstResponder()
            showDatePicker()
        }
        
        return true
    }
}

extension PersonDetailsTableVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        personDetailsTableHelper.genderChoice.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        personDetailsTableHelper.genderChoice[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFields[2].text = personDetailsTableHelper.genderChoice[row]
        viewForPickerView.isHidden = true
    }
}

extension PersonDetailsTableVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewForPickerView.isHidden = true
    }
}

extension PersonDetailsTableVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        personDetailsTableHelper.loadPersonDetails()
        textFields = []
        tableView.reloadData()
    }
}
