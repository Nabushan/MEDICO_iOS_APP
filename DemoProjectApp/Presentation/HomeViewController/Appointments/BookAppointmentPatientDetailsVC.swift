//
//  BookAppointmentPatientDetailsVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 14/10/22.
//

import UIKit

class BookAppointmentPatientDetailsVC: UIViewController {

    let reviewSummary: ReviewSummary?
    
    lazy var nameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var nameField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 15,
            left: 20,
            bottom: 15,
            right: 35
        )
        
        textField.textColor = .label
        textField.returnKeyType = .next
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        
        return textField
    }()
    
    lazy var genderLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var genderField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 15,
            left: 20,
            bottom: 15,
            right: 20
        )
        
        textField.textColor = .label
        textField.returnKeyType = .next
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.isUserInteractionEnabled = true
        
        return textField
    }()
    
    lazy var ageLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var ageField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 15,
            left: 20,
            bottom: 15,
            right: 20
        )
        
        textField.textColor = .label
        textField.returnKeyType = .next
        textField.keyboardType = .numberPad
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        
        return textField
    }()
    
    lazy var problemLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var problemTextView: UITextView = {
        let textView = UITextView()
        
        textView.textColor = .label
        textView.returnKeyType = .done
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        
        return textView
    }()
    
    lazy var nextButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = button.intrinsicContentSize.height/2
        
        return button
    }()
    
    lazy var nameImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
    }()
    
    lazy var genderImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
    }()
    
    lazy var ageImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
    }()
    
    lazy var problemImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        
        return formatter
    }()
    
    lazy var nameFieldChevronArrowView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var nameFieldChevronArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal))
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    var toolBar: UIToolbar!
    
    let validator = Validators()
    
    var previousConstraintsToDeactivate: [NSLayoutConstraint] = []
    var genderChoice = ["Male", "Female", " Other"]
    
    init(reviewSummary: ReviewSummary){
        self.reviewSummary = reviewSummary
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolBar.sizeToFit()
        
        self.title = "Patient Details"
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(nameField)
        scrollView.addSubview(nameFieldChevronArrowView)
        nameFieldChevronArrowView.addSubview(nameFieldChevronArrow)
        scrollView.addSubview(nameImportantMarkLabel)
        scrollView.addSubview(genderLabel)
        scrollView.addSubview(genderField)
        scrollView.addSubview(genderImportantMarkLabel)
        scrollView.addSubview(ageLabel)
        scrollView.addSubview(ageField)
        scrollView.addSubview(ageImportantMarkLabel)
        scrollView.addSubview(problemLabel)
        scrollView.addSubview(problemTextView)
        scrollView.addSubview(problemImportantMarkLabel)
        scrollView.addSubview(nextButton)
        
        scrollView.addSubview(viewForPickerView)
        viewForPickerView.addSubview(toolBar)
        viewForPickerView.addSubview(pickerView)
        
        configureDelegates()
        
        loadScrollView()
        loadPickerView()
        
        loadComponents()
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        addTapGesture(toView: view)
        addTapGesture(toView: genderField)
        viewForPickerView.isHidden = true
    }
    
    func configureDelegates() {
        nameField.delegate = self
        genderField.delegate = self
        ageField.delegate = self
        
        problemTextView.delegate = self
        pickerView.delegate = self
        scrollView.delegate = self
        
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapPickerViewCancel))
        let nextBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapPickerViewNext))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelBarButton, flexibleSpace, nextBarButton], animated: true)
    }
    
    func loadScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeactivate)
        loadComponents()
    }
    
    func loadComponents() {
        loadNameLabel()
        loadNameField()
        loadNameFieldChevronArrow()
        loadNameImportantMarkLabel()
        loadGenderLabel()
        loadGenderField()
        loadGenderImportantMarkLabel()
        loadAgeLabel()
        loadAgeField()
        loadAgeImportantMarkLabel()
        loadProblemLabel()
        loadProblemView()
        loadProblemImportantMarkLabel()
        loadNextButton()
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
    
    func loadNameLabel(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = "Patient Name"
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.1*view.frame.width),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
        else{
            let constraints = [
                nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
                nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
    }
    
    func loadNameField(){
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        nameField.backgroundColor = .secondarySystemBackground
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                nameField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                nameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0.1*view.frame.width)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
        else{
            let constraints = [
                nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                nameField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                nameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
        
        nameField.layer.cornerRadius = 10
        
        addTapGesture(toView: nameFieldChevronArrow)
    }
    
    func loadNameFieldChevronArrow() {
        nameFieldChevronArrowView.translatesAutoresizingMaskIntoConstraints = false
        nameFieldChevronArrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameFieldChevronArrowView.centerYAnchor.constraint(equalTo: nameField.centerYAnchor),
            nameFieldChevronArrowView.trailingAnchor.constraint(equalTo: nameField.trailingAnchor, constant: 0),
            nameFieldChevronArrowView.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            nameFieldChevronArrowView.widthAnchor.constraint(equalToConstant: 35),
            
            nameFieldChevronArrow.centerYAnchor.constraint(equalTo: nameField.centerYAnchor),
            nameFieldChevronArrow.trailingAnchor.constraint(equalTo: nameFieldChevronArrowView.trailingAnchor, constant: -15),
            nameFieldChevronArrow.heightAnchor.constraint(equalToConstant: 20),
            nameFieldChevronArrow.widthAnchor.constraint(equalToConstant: 15),
        ])
        
        addTapGesture(toView: nameFieldChevronArrow)
        addTapGesture(toView: nameFieldChevronArrowView)
    }
    
    func loadNameImportantMarkLabel() {
        nameImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameImportantMarkLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameImportantMarkLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -8)
        ])
    }
    
    func loadGenderLabel(){
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        genderLabel.text = "Gender"
        
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15),
            genderLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
        ])
    }
    
    func loadGenderField(){
        genderField.translatesAutoresizingMaskIntoConstraints = false
        
        genderField.backgroundColor = .secondarySystemBackground
        
        NSLayoutConstraint.activate([
            genderField.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            genderField.leadingAnchor.constraint(equalTo: genderLabel.leadingAnchor),
            genderField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
        ])
        
        genderField.layer.cornerRadius = 10
    }
    
    func loadGenderImportantMarkLabel() {
        genderImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genderImportantMarkLabel.topAnchor.constraint(equalTo: genderLabel.topAnchor),
            genderImportantMarkLabel.leadingAnchor.constraint(equalTo: genderLabel.trailingAnchor, constant: -8)
        ])
    }
    
    func loadAgeLabel(){
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ageLabel.text = "Age"
        
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: genderField.bottomAnchor, constant: 15),
            ageLabel.leadingAnchor.constraint(equalTo: genderField.leadingAnchor),
        ])
    }
    
    func loadAgeField(){
        ageField.translatesAutoresizingMaskIntoConstraints = false
        
        ageField.backgroundColor = .secondarySystemBackground
        
        ageField.inputAccessoryView = getToolBar()
        
        NSLayoutConstraint.activate([
            ageField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            ageField.leadingAnchor.constraint(equalTo: ageLabel.leadingAnchor),
            ageField.trailingAnchor.constraint(equalTo: genderField.trailingAnchor),
        ])
        
        ageField.layer.cornerRadius = 10
    }
    
    func loadAgeImportantMarkLabel() {
        ageImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ageImportantMarkLabel.topAnchor.constraint(equalTo: ageLabel.topAnchor),
            ageImportantMarkLabel.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: -8)
        ])
    }
    
    func loadProblemLabel() {
        problemLabel.translatesAutoresizingMaskIntoConstraints = false
        
        problemLabel.text = "Write Your Problem"
        
        NSLayoutConstraint.activate([
            problemLabel.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 15),
            problemLabel.leadingAnchor.constraint(equalTo: ageField.leadingAnchor),
        ])
    }
    
    func loadProblemView() {
        problemTextView.translatesAutoresizingMaskIntoConstraints = false
        
        problemTextView.backgroundColor = .secondarySystemBackground
        problemTextView.contentInset = UIEdgeInsets(
            top: 5,
            left: 15,
            bottom: 5,
            right: 5)
        
        var textViewHeight = CGFloat.zero
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            textViewHeight = 0.4
        }
        else {
            textViewHeight = 0.5
        }
        
        var bottomPadding = view.safeAreaInsets.bottom
        
        if(view.frame.height > 750) {
            bottomPadding+=10
        }
        
        NSLayoutConstraint.activate([
            problemTextView.topAnchor.constraint(equalTo: problemLabel.bottomAnchor),
            problemTextView.leadingAnchor.constraint(equalTo: problemLabel.leadingAnchor),
            problemTextView.trailingAnchor.constraint(equalTo: ageField.trailingAnchor),
            problemTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -(bottomPadding + 20 + nextButton.intrinsicContentSize.height + 20)),
            problemTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: textViewHeight)
        ])
        
        problemTextView.layer.cornerRadius = 10
    }
    
    func loadProblemImportantMarkLabel() {
        problemImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            problemImportantMarkLabel.topAnchor.constraint(equalTo: problemLabel.topAnchor),
            problemImportantMarkLabel.leadingAnchor.constraint(equalTo: problemLabel.trailingAnchor, constant: -8)
        ])
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == view){
            tapGesture.addTarget(self, action: #selector(didTapToDismissKeyBoard))
        }
        else if(toView == genderField) {
            tapGesture.addTarget(self, action: #selector(didTapGenderTextField))
        }
        else if(toView == nameFieldChevronArrow || toView == nameFieldChevronArrowView) {
            tapGesture.addTarget(self, action: #selector(didTapNameField))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapNameField(_ sender: UITapGestureRecognizer) {
        let viewController = PersonDetailsTableVC(isToAddOrEditPersonDetails: false, isEditingDetails: false, personDetails: nil)
        
        viewController.isFromBookingAppointments = true
        viewController.autoFillDelegate = self
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func didTapToDismissKeyBoard(_ sender: UITapGestureRecognizer) {
        dismissKeyBoard()
    }
    
    func dismissKeyBoard() {
        if(nameField.isFirstResponder) {
            nameField.resignFirstResponder()
        }
        else if(genderField.isFirstResponder) {
            genderField.resignFirstResponder()
        }
        else if(ageField.isFirstResponder) {
            ageField.resignFirstResponder()
        }
        else if(problemTextView.isFirstResponder) {
            problemTextView.resignFirstResponder()
        }
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapPickerViewCancel(_ sender: UIBarButtonItem) {
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapPickerViewNext(_ sender: UIBarButtonItem) {
        viewForPickerView.isHidden = true
        
        ageField.becomeFirstResponder()
    }
    
    func loadNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        let window = UIApplication.shared.keyWindow
        
        var insets = CGFloat.zero
        
        if let value = window?.safeAreaInsets.bottom, value != .zero {
            insets = value
        }
        else{
            insets = 10
        }
        
        let constraints = [
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: problemTextView.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: problemTextView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
        
        if(view.frame.height > 800){
            let heightAnchor = nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065)
            heightAnchor.isActive = true
            
            previousConstraintsToDeactivate.append(heightAnchor)
        }
        nextButton.layer.cornerRadius = 10
    }
    
    func loadPickerView() {
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
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
    }
    
    @objc func didTapNextButton(_ sender: UIButton) {
        problemTextView.resignFirstResponder()
        print("Patient details next button tapped.")
        
        guard let name = nameField.text,
              let gender = genderField.text,
              let age = ageField.text,
              let problem = problemTextView.text else {
            return
        }
                
        if(name.count != 0 && gender.count != 0 && age.count != 0 && problem.count != 0){
            guard let reviewSummary = reviewSummary else {
                return
            }
            
            if(validator.isContentValid(name) && validator.validateIfNumber(age) && (Int(age) ?? 200) <= 150 && (Int(age) ?? 0) > 0 && validator.isContentValid(problem)){
                
                let packageInfo = (reviewSummary.package == ConsultationPackageType.hospitalVisit.consultationType) ? ConsultationPackageType.hospitalVisit : ConsultationPackageType.videoConsultation
                
                let consultation = ConsultationGetter(
                    doctorId: reviewSummary.doctorId,
                    doctorName: reviewSummary.docName,
                    doctorImage: reviewSummary.docImage,
                    consultationDate: reviewSummary.date,
                    consultationTime: reviewSummary.hourSlot,
                    patientName: name,
                    patientGender: gender,
                    patientAge: age,
                    patientProblem: problem,
                    packageInfomation: packageInfo,
                    cost: "Rs \(reviewSummary.amount ?? 0.0)",
                    status: .upcoming,
                    forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
                
                let paymentsVC = PaymentsVC(reviewSummary: reviewSummary, consultation: consultation)
            
                navigationController?.pushViewController(paymentsVC, animated: true)
            }
            else{
                let alertViewController = UIAlertController(title: "Invalid Credentials", message: "Please make sure that the values entered are correct", preferredStyle: .alert)
                
                alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
                
                if(!validator.isContentValid(name)) {
                    alertViewController.title = "Invalid Name"
                    alertViewController.message = "Please make sure that the Name entered in the Name Field is Valid."
                }
                else if (!validator.isContentValid(gender)) {
                    alertViewController.title = "Invalid Gender"
                    alertViewController.message = "Please make sure that the Gender entered in the Gender Field is Valid."
                }
                else if (!validator.validateIfNumber(age) || (Int(age) ?? 200) > 150) {
                    alertViewController.title = "Invalid Age"
                    alertViewController.message = "Please make sure that the Age entered in the Age Field is Valid."
                }
                else if (!validator.isContentValid(problem)) {
                    alertViewController.title = "Invalid Problem"
                    alertViewController.message = "Please make sure that the Problem entered in the Problem Field is Valid."
                }
                
                present(alertViewController, animated: true)
            }
        }
        else{
            let alertViewController = UIAlertController(title: "Insufficient Details", message: "Please make sure that you have entered all the required details", preferredStyle: .alert)
            
            alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
            
            if(name.count == 0) {
                alertViewController.title = "Name Field Empty"
                alertViewController.message = "Please make sure that the Name Field Is Filled."
            }
            else if (gender.count == 0) {
                alertViewController.title = "Gender Field Empty"
                alertViewController.message = "Please make sure that the Gender Field Is Filled."
            }
            else if (age.count == 0) {
                alertViewController.title = "Age Field Empty"
                alertViewController.message = "Please make sure that the Age Field Is Filled."
            }
            else if (problem.count == 0) {
                alertViewController.title = "Problem Field Empty"
                alertViewController.message = "Please make sure that the Problem Field Is Filled."
            }
            
            present(alertViewController, animated: true)
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        viewForPickerView.isHidden = true
        if(problemTextView.isFirstResponder){
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                        self.view.frame.origin.y -= (keyboardSize.height - 150)
                        return
                    }
                    self.view.frame.origin.y -= keyboardSize.height - 60
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        self.view.frame.origin.y = 0
    }
    
    func getMenu() -> UIMenu {
        
        let maleAction = UIAction(title: "Male") { [weak self] _ in
            self?.genderField.text = "Male"
        }
        
        let femaleAction = UIAction(title: "Female") { [weak self] _ in
            self?.genderField.text = "Female"
        }
        
        let otherAction = UIAction(title: "Other") { [weak self] _ in
            self?.genderField.text = "Other"
        }
        
        let menu = UIMenu(options: .singleSelection ,children: [maleAction, femaleAction, otherAction])
        
        return menu
    }
    
    func getToolBar() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapToolBarNext))
        
        let cancelBUtton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didTapToolBarCancel))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolBar.setItems([cancelBUtton, flexibleSpace, nextButton], animated: true)
        
        return toolBar
    }
    
    @objc func didTapToolBarNext(_ sender: UIBarButtonItem) {
        let _ = textFieldShouldReturn(ageField)
    }
    
    @objc func didTapToolBarCancel(_ sender: UIBarButtonItem) {
        ageField.resignFirstResponder()
    }
    
    func showGenderSelectionView() {
        if(genderField.text?.count == 0) {
            genderField.text = genderChoice[0]
        }
        viewForPickerView.isHidden = false
    }
    
    @objc func didTapGenderTextField() {
        genderField.resignFirstResponder()
        nameField.resignFirstResponder()
        ageField.resignFirstResponder()
        problemTextView.resignFirstResponder()
        
        if(genderField.text?.count == 0) {
            genderField.text = genderChoice[0]
        }
        
        showGenderSelectionView()
    }
}

extension BookAppointmentPatientDetailsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == nameField) {
            textField.resignFirstResponder()
        
            showGenderSelectionView()
        }
        else if(textField == ageField){
            
            problemTextView.becomeFirstResponder()
        }
        
        return true
    }
}

extension BookAppointmentPatientDetailsVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let content = textView.text else {
            return
        }
        
        if(content.count != 0 && content[content.index(content.endIndex, offsetBy: -1)] == "\n"){
            print("Text View Done Form keyboard tapped.")
            textView.resignFirstResponder()
            
            if(content.count == 1 && content[content.index(content.endIndex, offsetBy: -1)] == "\n"){
                textView.text = ""
            }
        }
    }
}

extension BookAppointmentPatientDetailsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderChoice.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genderChoice[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genderChoice[row]
    }
}

extension BookAppointmentPatientDetailsVC: PersonDetailsAutoFillProtocol {
    func autoFillDetails(_ person: Person) {
        nameField.text = person.name
        genderField.text = person.gender
        
        let currentYear = Int(formatter.string(from: Date.now)) ?? 0
        
        formatter.dateFormat = "dd-MMM-YYYY"
        
        guard let year = formatter.date(from: person.dateOfBirth) else {
            return
        }
        
        formatter.dateFormat = "YYYY"
        
        let givenYear = Int(formatter.string(from: year)) ?? 0
        
        ageField.text = "\(currentYear - givenYear)"
    }
}

extension BookAppointmentPatientDetailsVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyBoard()
    }
}

extension BookAppointmentPatientDetailsVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Patient Details"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.title = "Back"
    }
}
