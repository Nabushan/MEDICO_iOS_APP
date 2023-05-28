//
//  InformationDetailVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import UIKit

class InformationDetailVC: UIViewController, ProfileIndividualInformationProtocol {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.register(InformationDetailVCTableViewCell.self, forCellReuseIdentifier: InformationDetailVCTableViewCell.identifier)
        
        tableView.register(InformationDetailDatePickerTableViewCell.self, forCellReuseIdentifier: InformationDetailDatePickerTableViewCell.identifier)
        
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: 15,
                                                bottom: 0,
                                                right: 0)
        
        return tableView
    }()
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDatePickerDone))
        
        return button
    }()
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDatePickerCancel))
        
        return button
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter
    }()
    
    var datePicker: UIDatePicker?
    var dateLabel: ResizedLabel?
    
    let informationDetailHelper: InformationDetailHelper
    let selectionType: ProfileInfo
    var shouldShowDatePickerView: Bool = false
    
    var previouslySelectedCell: InformationDetailVCTableViewCell?
    
    init(_ selectionType: ProfileInfo) {
        informationDetailHelper = InformationDetailHelper()
        self.selectionType = selectionType
        
        super.init(nibName: nil, bundle: nil)
        
        informationDetailHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        view.addSubview(tableView)
        
        switch(selectionType){
        case .nameAndDetails:
            self.title = "Personal Details"
        case .appearance:
            self.title = "Appearance"
        case .passwordAndSecurity:
            self.title = "Password & Security"
        }
        
        configureTableView()
        loadTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        ])
    }
    
    @objc func didTapDatePickerDone(_ sender: UIBarButtonItem) {
        print("Done Tapped")
        
        if(shouldShowDatePickerView == true){
            shouldShowDatePickerView = false
            
            tableView.beginUpdates()
            
            let indexPath = IndexPath(row: 1, section: 2)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
        
        guard let date = datePicker?.date else {
            return
        }
        
        dateLabel?.text = formatter.string(from: date)
        
        UserDefaults.standard.setValue(dateLabel?.text, forKey: "User-DOB")
        
        informationDetailHelper.loadUserDetail(forId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        informationDetailHelper.user.dateOfBirth = dateLabel?.text ?? ""
        
        informationDetailHelper.updateUserDetail()
        
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
    }
    
    @objc func didTapDatePickerCancel(_ sender: UIBarButtonItem) {
        print("Cancel Tapped")
        
        if(shouldShowDatePickerView == true){
            shouldShowDatePickerView = false
            
            tableView.beginUpdates()
            
            let indexPath = IndexPath(row: 1, section: 2)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
    }
}

extension InformationDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch(selectionType) {
        case .nameAndDetails:
            return informationDetailHelper.nameAndOtherSectionHeaders.count
        case .passwordAndSecurity:
            return informationDetailHelper.passwordAndOtherSections.count
        case .appearance:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(selectionType == .appearance){
            return informationDetailHelper.appearance.count
        }
        else{
            if(section == 2){
                if(shouldShowDatePickerView){
                    return 2
                }
                else{
                    return 1
                }
            }
            else{
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationDetailVCTableViewCell.identifier, for: indexPath) as? InformationDetailVCTableViewCell else {
            return UITableViewCell()
        }
        
        switch(selectionType){
        case .nameAndDetails:
            switch(indexPath.section) {
            case 0:
                cell.shouldShowChevronRight = true
                cell.shouldShowDateContentLabel = false
                
                if let name = UserDefaults.standard.string(forKey: "User - Name") {
                    cell.contentLabel.text = name
                }
                else{
                    cell.contentLabel.text = "Unknown"
                }
            case 1:
                cell.shouldShowChevronRight = true
                cell.shouldShowDateContentLabel = false
                
                if let mailId = UserDefaults.standard.string(forKey: "User - MailID"){
                    cell.contentLabel.text = mailId
                }
                else{
                    cell.contentLabel.text = "youmail@yourdomain.com"
                }
            case 2:
                if(indexPath.row == 0) {
                    cell.shouldShowChevronRight = false
                    cell.shouldShowDateContentLabel = true
                    
                    cell.contentLabel.text = "Date of Birth"
                    
                    if let dob = UserDefaults.standard.string(forKey: "User-DOB") {
                        cell.contentDateLabel.text = dob
                    }
                    else {
                        cell.contentDateLabel.text = "dd/mm/yyyy"
                    }
                    
                    dateLabel = cell.contentDateLabel
                }
                else if(indexPath.row == 1){
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationDetailDatePickerTableViewCell.identifier, for: indexPath) as? InformationDetailDatePickerTableViewCell else {
                        return UITableViewCell()
                    }
                    
                    datePicker = cell.datePicker
                    
                    return cell
                }
                
                
            default:
                ()
            }
            
        case .passwordAndSecurity:
            cell.shouldShowChevronRight = true
            cell.shouldShowDateContentLabel = false
            
            cell.contentLabel.text = "Change Password"
            cell.contentLabel.textColor = .systemBlue
            
        case .appearance:
            cell.shouldShowChevronRight = false
            cell.shouldShowDateContentLabel = false
            
            cell.contentLabel.text = informationDetailHelper.appearance[indexPath.row]
            
            switch(UIApplication.shared.keyWindow?.overrideUserInterfaceStyle) {
            case .dark:
                if(cell.contentLabel.text == informationDetailHelper.appearance[1]) {
                    previouslySelectedCell = cell
                    previouslySelectedCell?.accessoryType = .checkmark
                }
            case .light:
                if(cell.contentLabel.text == informationDetailHelper.appearance[2]) {
                    previouslySelectedCell = cell
                    previouslySelectedCell?.accessoryType = .checkmark
                }
            case .unspecified:
                if(cell.contentLabel.text == informationDetailHelper.appearance[0]) {
                    previouslySelectedCell = cell
                    previouslySelectedCell?.accessoryType = .checkmark
                }
            default:
                ()
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch(selectionType){
        case .nameAndDetails:
            switch(indexPath.section) {
            case 0:
                let informationDetailVC = InformationValueChangeVC(.userName)
                
                navigationController?.pushViewController(informationDetailVC, animated: true)
            case 1:
                let informationDetailVC = InformationValueChangeVC(.userMailId)
                
                navigationController?.pushViewController(informationDetailVC, animated: true)
            case 2:
                if(shouldShowDatePickerView == false){
                    navigationItem.hidesBackButton = true
                    
                    self.navigationItem.rightBarButtonItem = rightBarButtonItem
                    self.navigationItem.leftBarButtonItem = leftBarButtonItem
                    
                    shouldShowDatePickerView = true
                    
                    tableView.beginUpdates()
                    
                    let indexPath = IndexPath(row: 1, section: 2)
                    
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    tableView.endUpdates()
                }
            default:
                ()
            }
        case .passwordAndSecurity:
            let informationDetailVC = InformationValueChangeVC(.userPassword)
            
            navigationController?.pushViewController(informationDetailVC, animated: true)
        case .appearance:
            guard let cell = tableView.cellForRow(at: indexPath) as? InformationDetailVCTableViewCell else {
                return
            }
            
            previouslySelectedCell?.accessoryType = .none
            cell.accessoryType = .checkmark
            previouslySelectedCell = cell
            
            switch(indexPath.row) {
            case 0:
                UserDefaults.standard.setValue(true, forKey: "Is_SystemPreference_Enabled")
                UserDefaults.standard.setValue(false, forKey: "Is_DarkMode_Enabled")
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
            case 1:
                UserDefaults.standard.setValue(false, forKey: "Is_SystemPreference_Enabled")
                UserDefaults.standard.setValue(true, forKey: "Is_DarkMode_Enabled")
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
            case 2:
                UserDefaults.standard.setValue(false, forKey: "Is_SystemPreference_Enabled")
                UserDefaults.standard.setValue(false, forKey: "Is_DarkMode_Enabled")
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
            default:
                ()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(selectionType){
        case .nameAndDetails:
            return informationDetailHelper.nameAndOtherSectionHeaders[section].capitalized
        case .passwordAndSecurity:
            return nil
        case .appearance:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch(selectionType){
        case .nameAndDetails:
            if(section == 1){
                return informationDetailHelper.nameAndOtherSectionFooters[section]
            }
            else{
                return nil
            }
        case .passwordAndSecurity:
            return nil
        case .appearance:
            return nil
        }
    }
}

extension InformationDetailVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let indexPathOne = IndexPath(row: 0, section: 0)
        let indexPathTwo = IndexPath(row: 0, section: 1)
        
        tableView.reloadRows(at: [indexPathOne, indexPathTwo], with: .automatic)
    }
}
