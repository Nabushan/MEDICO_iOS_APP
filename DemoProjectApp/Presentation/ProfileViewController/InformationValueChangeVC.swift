//
//  InformationValueChangeVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import UIKit

class InformationValueChangeVC: UIViewController, ProfileInformationValueChangeProtocol {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.register(InformationValueChangeTableViewCell.self, forCellReuseIdentifier: InformationValueChangeTableViewCell.identifier)
        
        return tableView
    }()
    
    var valueStateChange: ProfileValueChange
    let informationValueChangeHelper: InformationValueChangeHelper
    var firstTextField: UITextField?
    var secondTextField: UITextField?
    
    lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        
        return barButtonItem
    }()
    
    let validator: Validators
    
    init(_ valueStateChange: ProfileValueChange) {
        self.valueStateChange = valueStateChange
        informationValueChangeHelper = InformationValueChangeHelper()
        validator = Validators()
        
        super.init(nibName: nil, bundle: nil)
        
        informationValueChangeHelper.delegate = self
        
        self.title = valueStateChange.categoryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
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
    
    func populateFields() {
        switch(valueStateChange) {
        case .userName:
            let name = UserDefaults.standard.string(forKey: "User - Name")
            
            let splitedNames = name?.split(separator: " ")
            
            guard let splitedNames = splitedNames else {
                return
            }
            
            print(splitedNames)
            
            if(splitedNames.count == 2) {
                firstTextField?.text = String(splitedNames[0])
                secondTextField?.text = String(splitedNames[1])
            }
            else{
                firstTextField?.text = String(splitedNames[0])
                secondTextField?.text = ""
            }
        case .userMailId:
            let mailId = UserDefaults.standard.string(forKey: "User - MailID")
            
            let splitedNames = mailId?.split(separator: "@")
            
            guard let splitedNames = splitedNames else {
                return
            }
            
            print(splitedNames)
            
            firstTextField?.text = String(splitedNames[0])
            secondTextField?.text = String(splitedNames[1])
        default:
            ()
        }
    }
    
    @objc func didTapDoneButton(_ sender: UIBarButtonItem) {
        print("Done Tapped")
        
        print("Value from first field : \(firstTextField?.text ?? "")")
        print("Value from second field : \(secondTextField?.text ?? "")")
        
        let alertViewController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        var isSuccessfull: Bool = true
        
        alertViewController.addAction(UIAlertAction(title: "Okay", style: .default){_ in
            if(isSuccessfull){
                self.navigationItem.rightBarButtonItem = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.navigationController?.popViewController(animated: true)
                }
            }
        })
        
        informationValueChangeHelper.loadUserDetail(forId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        switch(valueStateChange) {
        case .userName:
            let name = "\(firstTextField?.text ?? "") \(secondTextField?.text ?? "")"
            
            if(!informationValueChangeHelper.validateUserName(name)) {
                isSuccessfull = false
                
                alertViewController.title = "Invalid Detail"
                alertViewController.message = "Please make sure that the entered name is valid."
                
                present(alertViewController, animated: true)
                
                return
            }
            
            UserDefaults.standard.setValue(name, forKey: "User - Name")
            informationValueChangeHelper.user.name = name
            
            NotificationCenter.default.post(name: NSNotification.Name("Profile-UserName-Changed-From-ProfileInfoValueChangeVC"), object: nil)
            
            alertViewController.title = "Details Saved Successfully"
            alertViewController.message = "The User Name has been changed successfully."
            
            present(alertViewController, animated: true)
            
        case .userMailId:
            let mail = "\(firstTextField?.text ?? "")@\(secondTextField?.text ?? "")"
            
            if(!informationValueChangeHelper.validateMailId(mail)) {
                isSuccessfull = false
                
                alertViewController.title = "Invalid Content"
                alertViewController.message = "Please make sure that the entered Mail ID is valid."
                
                present(alertViewController, animated: true)
                
                return
            }
            
            UserDefaults.standard.setValue(mail, forKey: "User - MailID")
            informationValueChangeHelper.user.mailId = mail
            
            alertViewController.title = "Details Saved Successfully"
            alertViewController.message = "The Mail Id has been changed successfully."
            
            present(alertViewController, animated: true)
            
        case .userPassword:
            let oldReferencePassword = UserDefaults.standard.string(forKey: "User - Password")
            let oldPassword = firstTextField?.text ?? ""
            let newPassword = secondTextField?.text ?? ""
            
            var messageHead = ""
            var messageBody = ""
            var isAccepted: Bool = false
            
            let alertView = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "Okay", style: .default){ [weak self] _ in
                if(isAccepted){
                    self?.navigationItem.rightBarButtonItem = nil
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            })
            
            if(oldPassword != oldReferencePassword) {
                messageHead = "Password mismatch"
                messageBody = "The entered old password is not matching the previously entered old reference password. Please make sure you've entered the correct password."
                
                alertView.title = messageHead
                alertView.message = messageBody
                
                self.present(alertView, animated: true)
            }
            
            else if(!validator.isPasswordValid(oldPassword)) {
                messageHead = "Incorrect password"
                messageBody = "The entered old password is invalid, please make sure that you've entered the correct password."
                
                alertView.title = messageHead
                alertView.message = messageBody
                
                self.present(alertView, animated: true)
            }
            
            else if(!validator.isPasswordValid(newPassword)) {
                messageHead = "Incorrect password"
                messageBody = "The entered new password is invalid, please make sure that you've entered accordingly to the given constraints."
                
                alertView.title = messageHead
                alertView.message = messageBody
                
                self.present(alertView, animated: true)
            }
            
            else if(oldPassword == newPassword) {
                messageHead = "Same Password"
                messageBody = "The entered old password and new password is the same, please make sure you've entered the another valid password."
                
                alertView.title = messageHead
                alertView.message = messageBody
                
                self.present(alertView, animated: true)
            }
            
            else {
                isAccepted = true
                messageHead = "Password Changed"
                messageBody = "The password has been changed successfully"
                
                alertView.title = messageHead
                alertView.message = messageBody
                
                UserDefaults.standard.setValue(newPassword, forKey: "User - Password")
                informationValueChangeHelper.user.password = newPassword
                
                self.present(alertView, animated: true)
            }
            
        }
        
        informationValueChangeHelper.updateUserDetail()
    }
}

extension InformationValueChangeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(valueStateChange) {
        case .userName:
            return 2
        case .userMailId:
            return 2
        case .userPassword:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationValueChangeTableViewCell.identifier, for: indexPath) as? InformationValueChangeTableViewCell else {
            return UITableViewCell()
        }
        
        if(indexPath.row == 0){
            firstTextField = cell.firstValueTextField
        }
        else{
            secondTextField = cell.firstValueTextField
        }
        
        switch(valueStateChange){
        case .userName:
            cell.firstValueLabel.text = informationValueChangeHelper.nameFields[indexPath.row]
        case .userMailId:
            cell.firstValueLabel.text = informationValueChangeHelper.mailFields[indexPath.row]
        case .userPassword:
            cell.firstValueLabel.text = informationValueChangeHelper.passwordFields[indexPath.row]
            cell.firstValueTextField.isSecureTextEntry = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension InformationValueChangeVC {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        populateFields()
    }
}
