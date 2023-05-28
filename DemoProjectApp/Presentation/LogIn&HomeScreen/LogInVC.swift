//
//  ViewController.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/09/22.
//

import UIKit

class LogInViewController: UIViewController {

    var showPassword: Bool = true
    var isUserNameFieldActive = false
    var isPasswordFieldActive = false
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let validators = Validators()
    
    lazy var label: ResizedLabel = {
        let label = ResizedLabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .left
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = .label
        
        label.text = """
                    Please Note:-
                    
                    Minimum Password Requirments :
                    Password should be a minimum of 6 Characters
                    Should have atleast one Capital Character
                    Should have atleast one Special Character
                    Should have atleast one Small Character
                    
                    """
        
        return label
    }()
    
    lazy var welcomeLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.clipsToBounds = true
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var personImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))

        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .secondaryLabel
        
        return imageView
    }()
    
    lazy var lockImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        imageView.image = UIImage(systemName: "lock.fill")
        imageView.tintColor = .secondaryLabel
        
        return imageView
    }()
    
    lazy var eyeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        imageView.image = UIImage(systemName: "eye.slash")
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .secondaryLabel
        
        return imageView
    }()
    
    lazy var userNameField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.rightViewMode = .always
        
        textField.tag = 0
        textField.placeholder = "User Name"
        textField.textAlignment = .left
        textField.font = UIFont(name: "Helvetica", size: 20)
        textField.textColor = .secondaryLabel
        textField.clipsToBounds = true
        textField.returnKeyType = .next
        
        textField.textPadding = UIEdgeInsets(
            top: 10,
            left: 30,
            bottom: 10,
            right: 20
        )
        
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        
        return textField
    }()
    
    lazy var passwordField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textField.rightViewMode = .always
        
        textField.tag = 1
        textField.placeholder = "Password"
        textField.textAlignment = .left
        textField.font = UIFont(name: "Helvetica", size: 20)
        textField.textColor = .secondaryLabel
        textField.clipsToBounds = true
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 15
        
        textField.textPadding = UIEdgeInsets(
            top: 10,
            left: 30,
            bottom: 10,
            right: 20
        )
        
        return textField
    }()
    
    lazy var logInButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    lazy var statementLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .left
        label.contentMode = .left
        label.clipsToBounds = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        label.textColor = .label
        
        return label
    }()
    
    lazy var statementOptionLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .left
        label.contentMode = .left
        label.clipsToBounds = true
        label.isUserInteractionEnabled = true
        label.font = UIFont(name: "Helvetica", size: 15)
        label.textColor = .label
        
        return label
    }()
    
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    var logInVCHelper: LogInVCHelper
    
    var isFromSignUp: Bool = false
    
    init(isFromSignUp: Bool) {
        self.isFromSignUp = isFromSignUp
        self.logInVCHelper = LogInVCHelper()
        
        super.init(nibName: nil, bundle: nil)
        
        toggleSetUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        view.addSubview(imageView)
        view.addSubview(welcomeLabel)
        view.addSubview(userNameField)
        view.addSubview(personImageView)
        view.addSubview(passwordField)
        view.addSubview(lockImageView)
        view.addSubview(eyeImageView)
        view.addSubview(logInButton)
        view.addSubview(statementLabel)
        view.addSubview(statementOptionLabel)
        
        self.addTapGesture(toView: view)
        self.addTapGesture(toView: eyeImageView)
        self.addTapGesture(toView: statementOptionLabel)
        
        view.bringSubviewToFront(userNameField)
        view.bringSubviewToFront(passwordField)
        view.bringSubviewToFront(eyeImageView)
        view.bringSubviewToFront(personImageView)
        view.bringSubviewToFront(lockImageView)
        view.bringSubviewToFront(statementOptionLabel)
        
        configureDelegates()
        
        loadContents()
        
        userNameTextView(isSelected: false)
        passwordTextView(isSelected: false)
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone || (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight)) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    func loadContents() {
        loadImageView()
        loadWelcomeLabel()
        
        loadUserNameField()
        loadPersonSymbol()
        loadPasswordField()
        loadLockSymbol()
        loadEyeSymbol()
        loadLogInButton()
        loadStatementLabel()
        loadStatementOptionLabel()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                if(view.frame.height > 800) {
                    self.view.frame.origin.y -= keyboardSize.height - 120
                }
                else {
                    self.view.frame.origin.y -= keyboardSize.height - 50
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.hideKeyBoard()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        
        previousConstraintsToDeActivate = []
        loadContents()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        else{
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    @objc func hideKeyBoard() {
        
        if(isUserNameFieldActive == true && self.view.frame.origin.y != 0){
            userNameField.resignFirstResponder()
            isUserNameFieldActive = false
        }
        if(isPasswordFieldActive == true && self.view.frame.origin.y != 0){
            passwordField.resignFirstResponder()
            isPasswordFieldActive = false
        }
        
        userNameTextView(isSelected: false)
        passwordTextView(isSelected: false)
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func configureDelegates() {
        userNameField.delegate = self
        passwordField.delegate = self
    }
    
    @objc func didTapEyeButton(_ sender: UITapGestureRecognizer) {
        if(showPassword == true){
            eyeImageView.image = UIImage(systemName: "eye.fill")
            passwordField.isSecureTextEntry = false
        }
        else{
            eyeImageView.image = UIImage(systemName: "eye.slash")
            passwordField.isSecureTextEntry = true
        }
        showPassword.toggle()
    }
    
    @objc func toggleToRespectiveView(_ sender: UITapGestureRecognizer) {
        toggleToRespectiveViewUtil()
    }
    
    func toggleToRespectiveViewUtil() {
        isFromSignUp = !isFromSignUp
        toggleSetUp()
    }
    
    func toggleSetUp() {
        userNameField.text = ""
        passwordField.text = ""
        
        if(isFromSignUp) {
            welcomeLabel.text = "Create New Account"
            logInButton.setTitle("Sign Up", for: .normal)
            statementLabel.text = "Already have an account?"
            statementOptionLabel.text = "Sign In"
        }
        else{
            welcomeLabel.text = "Login to Your Account"
            logInButton.setTitle("Sign In", for: .normal)
            statementLabel.text = "Don't have an account?"
            statementOptionLabel.text = "Sign Up"
        }

    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == view) {
            tapGesture.addTarget(self, action: #selector(hideKeyBoard))
        }
        else if(toView == eyeImageView) {
            tapGesture.addTarget(self, action: #selector(didTapEyeButton))
        }
        else if(toView == statementOptionLabel) {
            tapGesture.addTarget(self, action: #selector(toggleToRespectiveView))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    func loadImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "Transparent App Icon")
        UserDefaults.standard.setImage(UIImage(named: "Transparent App Icon"), forKey: "Default Image")
        
        print(view.frame.width)
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.bottomAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: -20),
                imageView.heightAnchor.constraint(equalToConstant: 0.4*view.frame.width),
                imageView.widthAnchor.constraint(equalToConstant: 0.4*view.frame.width)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
            
            imageView.layer.cornerRadius = (0.4*view.frame.width)/2
        }
        else {
            let constraints = [
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.bottomAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: -20),
                imageView.heightAnchor.constraint(equalToConstant: 0.35*view.frame.width),
                imageView.widthAnchor.constraint(equalToConstant: 0.35*view.frame.width)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
            
            imageView.layer.cornerRadius = (0.35*view.frame.width)/2
        }
        
        
        
        imageView.layer.masksToBounds = true
    }
    
    func loadWelcomeLabel(){
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -0.03*view.frame.height),
                welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 0.1*view.frame.width),
                welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -(0.1*view.frame.width))
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
                welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10),
                welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        
        if(view.frame.width > 850){
            welcomeLabel.font = UIFont(name: "Helvetica", size: 30)
        }
        
    }
    
    func loadUserNameField(){
        userNameField.translatesAutoresizingMaskIntoConstraints = false
        
        userNameField.backgroundColor = view.backgroundColor
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                userNameField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
                userNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                userNameField.widthAnchor.constraint(equalToConstant: 480),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
            
            userNameField.font = UIFont(name: "Helvetica", size: 30)
        }
        else{
            let constraints = [
                userNameField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor,constant: 20),
                userNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                userNameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                userNameField.heightAnchor.constraint(equalToConstant: 50)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadPersonSymbol() {
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            personImageView.centerYAnchor.constraint(equalTo: userNameField.centerYAnchor),
            personImageView.leadingAnchor.constraint(equalTo: userNameField.leadingAnchor, constant: 15)
        ])
    }
    
    func loadPasswordField(){
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordField.backgroundColor = view.backgroundColor
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                passwordField.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 20),
                passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                passwordField.widthAnchor.constraint(equalToConstant: 480),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
            passwordField.font = UIFont(name: "Helvetica", size: 30)
        }
        else{
            let constraints = [
                passwordField.topAnchor.constraint(equalTo: userNameField.bottomAnchor,constant: 20),
                passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                passwordField.widthAnchor.constraint(equalTo: userNameField.widthAnchor),
                passwordField.heightAnchor.constraint(equalTo: userNameField.heightAnchor)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadLockSymbol() {
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor, constant: 15)
        ])
    }
    
    func loadEyeSymbol() {
        eyeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eyeImageView.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor),
            eyeImageView.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor, constant: -15)
        ])
    }
    
    func loadLogInButton(){
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        logInButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        
        
        if(view.frame.width > 850){
            logInButton.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        }
        
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor,constant: 50),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.widthAnchor.constraint(equalTo: userNameField.widthAnchor)
        ])
        
        logInButton.layer.cornerRadius = 20
    }
    
    func loadStatementLabel() {
        statementLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statementLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            statementLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -(30))
        ])
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            statementLabel.font = UIFont(name: "Helvetica", size: 20)
        }
    }
    
    func loadStatementOptionLabel() {
        statementOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statementOptionLabel.textColor = .systemBlue
        
        NSLayoutConstraint.activate([
            statementOptionLabel.bottomAnchor.constraint(equalTo: statementLabel.bottomAnchor),
            statementOptionLabel.leadingAnchor.constraint(equalTo: statementLabel.trailingAnchor, constant: 5)
        ])
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            statementOptionLabel.font = UIFont(name: "Helvetica", size: 20)
        }
    }
    
    func verify(password: String) ->  Bool {
        print(password)
        if(validators.isPasswordValid(password)){
            return true
        }
        return false
    }
    
    
    func shouldProceed() {
        if(!isFromSignUp) {
            let userName = userNameField.text ?? ""
            let password = passwordField.text ?? ""
            var userDetail: User?
            var isUserPresent: Bool = false
            
            for user in logInVCHelper.users {
                if(user.name == userName) {
                    isUserPresent = true
                    userDetail = user
                    break
                }
            }
            
            guard let userDetail = userDetail else {
                let alertView = UIAlertController(title: "User Name not present", message: "Entered User name doesn't exist please Sign Up to continue", preferredStyle: .alert)

                alertView.addAction(UIAlertAction(title: "Sign Up", style: .cancel){ _ in
                    self.toggleToRespectiveViewUtil()
                })

                present(alertView, animated: true)
                return
            }
            
            if(isUserPresent && verify(password: password)){
                if(password == userDetail.password) {
                    
                    UserDefaults.standard.setValue(userDetail.id, forKey: "User - Id")
                    UserDefaults.standard.setValue(userDetail.name, forKey: "User - Name")
                    UserDefaults.standard.setValue(userDetail.mailId, forKey: "User - MailID")
                    UserDefaults.standard.setValue(userDetail.password, forKey: "User - Password")
                    UserDefaults.standard.setValue(userDetail.dateOfBirth, forKey: "User-DOB")
                    UserDefaults.standard.setValue(true, forKey: "User_Logged_In")
                    
                    navigationController?.pushViewController(HomeScreenVC(), animated: true)
                }
                else{
                    let alertView = UIAlertController(title: "Password Mismatch", message: "Entered password doesn't match with the previously entered password", preferredStyle: .alert)

                    alertView.addAction(UIAlertAction(title: "Try Again", style: .cancel))

                    present(alertView, animated: true)
                }
            }
            else{
                if(userName == "" && passwordField.text == ""){
                    userNameField.layer.borderColor = UIColor.systemRed.cgColor
                    passwordField.layer.borderColor = UIColor.systemRed.cgColor
                }
                else if(passwordField.text == ""){
                    passwordField.layer.borderColor = UIColor.systemRed.cgColor
                }
                else if(userName == ""){
                    userNameField.layer.borderColor = UIColor.systemRed.cgColor
                }
                else{
                    let alertView = UIAlertController(title: "User Name not present", message: "Entered User name doesn't exist please Sign Up to continue", preferredStyle: .alert)

                    alertView.addAction(UIAlertAction(title: "Sign Up", style: .cancel){ _ in
                        self.toggleToRespectiveViewUtil()
                    })

                    present(alertView, animated: true)
                }
            }
        }
        else{
            let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
            
            if(!validators.isContentValid(userNameField.text ?? "")) {
                alertController.title = "Invalid User Name"
                alertController.message = "The entered User Name is Invalid please enter a valid User Name."
                
                alertController.addAction(UIAlertAction(title: "Okay", style: .default))
                
                self.present(alertController, animated: true)
                return
            }
            
            if(!validators.isPasswordValid(passwordField.text ?? "")) {
                
                let tableContent = ["Should be a minimum of 6 characters", "Should have atleast 1 Capital character", "Should have atleast 1 Special character", "Should have atleast 1 Small character."]
                    
                let vc = CustomAlertViewWithTableStructure(style: .insetGrouped, tableContent: tableContent)
                
                vc.preferredContentSize = CGSize(width: 350, height: 300)
                vc.tableView.isScrollEnabled = false
                vc.preferredFontSize = 13
                vc.preferredNumberofLines = 2
                vc.tableView.isUserInteractionEnabled = false
                
                alertController.title = "Minimum Password Requirments"
                alertController.message = nil
                alertController.setValue(vc, forKey: "contentViewController")
                
                alertController.addAction(UIAlertAction(title: "Okay", style: .default))
                
                present(alertController, animated: true)
                
                return
            }
            
            var isUserNameTaken = false
            
            for user in logInVCHelper.users {
                if(userNameField.text ?? "" == user.name) {
                    alertController.title = "User Name already taken"
                    alertController.message = "The user name entered has already been taken, please enter some other user name"
                    
                    alertController.addAction(UIAlertAction(title: "Okay", style: .default){_ in
                        self.userNameField.text = ""
                    })
                    
                    present(alertController, animated: true)
                    
                    isUserNameTaken = true
                    break
                }
            }
            
            if(!isUserNameTaken) {
                let id = logInVCHelper.users.count
                
                UserDefaults.standard.setValue(true, forKey: "User_Logged_In")
                UserDefaults.standard.setValue(true, forKey: "User_Signed_In")
                UserDefaults.standard.setValue(userNameField.text ?? "", forKey: "User - Name")
                UserDefaults.standard.setValue(passwordField.text ?? "", forKey: "User - Password")
                UserDefaults.standard.setValue(nil, forKey: "User - MailID")
                UserDefaults.standard.setValue(nil, forKey: "User-DOB")
                UserDefaults.standard.setValue(id+1, forKey: "User - Id")
                UserDefaults.standard.setValue(0, forKey: "User-\(UserDefaults.standard.integer(forKey: "User - Id"))-Selected-Payment-Option")
                
                let user = User(id: id+1, name: userNameField.text ?? "", password: passwordField.text ?? "", mailId: "yourmail@yourdomain.com", dateOfBirth: "dd/mm/yyyy")
                
                logInVCHelper.addNewUser(user)
                
                navigationController?.pushViewController(HomeScreenVC(), animated: true)
            }
        }
    }
    
    @objc func didTapLogin(_ sender: UIButton) {
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        shouldProceed()
    }
    
    func userNameTextView(isSelected: Bool) {
        if(isSelected) {
            if(UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .unspecified) {
                if (UIScreen.main.traitCollection.userInterfaceStyle == .dark) {
                    userNameField.backgroundColor = UIColor(red: 25/255, green: 33/255, blue: 49/255, alpha: 1)
                }
                else{
                    userNameField.backgroundColor = UIColor(red: 238/255, green: 244/255, blue: 255/255, alpha: 1)
                }
            }
            else if (UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .dark) {
                userNameField.backgroundColor = UIColor(red: 25/255, green: 33/255, blue: 49/255, alpha: 1)
            }
            else{
                userNameField.backgroundColor = UIColor(red: 238/255, green: 244/255, blue: 255/255, alpha: 1)
            }
            userNameField.layer.borderColor = UIColor.systemBlue.cgColor
            personImageView.tintColor = .systemBlue
        }
        else{
            userNameField.backgroundColor = view.backgroundColor
            userNameField.layer.borderColor = UIColor.secondaryLabel.cgColor
            personImageView.tintColor = .secondaryLabel
        }
    }
    
    func passwordTextView(isSelected: Bool) {
        if(isSelected) {
            if(UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .unspecified) {
                if (UIScreen.main.traitCollection.userInterfaceStyle == .dark) {
                    passwordField.backgroundColor = UIColor(red: 25/255, green: 33/255, blue: 49/255, alpha: 1)
                }
                else{
                    passwordField.backgroundColor = UIColor(red: 238/255, green: 244/255, blue: 255/255, alpha: 1)
                }
            }
            else if (UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .dark) {
                passwordField.backgroundColor = UIColor(red: 25/255, green: 33/255, blue: 49/255, alpha: 1)
            }
            else{
                passwordField.backgroundColor = UIColor(red: 238/255, green: 244/255, blue: 255/255, alpha: 1)
            }
            
            passwordField.layer.borderColor = UIColor.systemBlue.cgColor
            lockImageView.tintColor = .systemBlue
            eyeImageView.tintColor = .systemBlue
        }
        else{
            passwordField.backgroundColor = view.backgroundColor
            passwordField.layer.borderColor = UIColor.secondaryLabel.cgColor
            lockImageView.tintColor = .secondaryLabel
            eyeImageView.tintColor = .secondaryLabel
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        
        if(textField == userNameField){
            isUserNameFieldActive = true
            
            userNameTextView(isSelected: true)
            passwordTextView(isSelected: false)
        }
        else if(textField == passwordField){
            isPasswordFieldActive = true
            
            userNameTextView(isSelected: false)
            passwordTextView(isSelected: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.tag == 0){
            textFieldDidBeginEditing(passwordField)
        }
        if(textField.tag == 1){
            textField.resignFirstResponder()
            print("Logging In")
            verify(password: textField.text!)
            shouldProceed()
        }
        return true
    }
}

extension LogInViewController {
    override func viewWillAppear(_ animated: Bool) {
        resetFields()
        
        resetAdminLogInImage()
        
    }
    
    func resetFields() {
        userNameField.text = ""
        passwordField.text = ""
    }
    
    func resetAdminLogInImage() {
        imageView.image = UserDefaults.standard.image(forKey: "Default Image")
    }
}
