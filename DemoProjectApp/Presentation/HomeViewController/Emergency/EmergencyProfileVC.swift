//
//  EmergencyProfileVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 03/10/22.
//

import UIKit
import Contacts
import ContactsUI

class EmergencyProfileVC: UIViewController, EmergencyProfileProtocol {

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var profileDataCompletionLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        
        label.font = .preferredFont(forTextStyle: .callout)
        
        return label
    }()
    
    lazy var nameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        
        label.font = .preferredFont(forTextStyle: .title1)
        
        return label
    }()
    
    lazy var saveView: UIView = {
        let view = UIView()
        
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var saveLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        
        label.font = .preferredFont(forTextStyle: .callout)
        
        return label
    }()
    
    lazy var dateTextView: UITextView = {
        let textView = UITextView()
        
        textView.textAlignment = .center
        textView.contentMode = .center
        
        textView.font = .preferredFont(forTextStyle: .body)
        textView.isUserInteractionEnabled = false
        textView.textColor = .secondaryLabel
        
        return textView
    }()
    
    let calendar = Calendar.current
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date.now
        
        var minDateComponent = DateComponents()
        minDateComponent.year = -150
        
        datePicker.minimumDate = calendar.date(byAdding: minDateComponent, to: Date.now)
        
        return datePicker
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = .current
        formatter.timeZone = .current
        
        return formatter
    }()
    
    lazy var dateTextViewToolBar: UIToolbar = {
        let toolBar = UIToolbar()
        
        return toolBar
    }()
    
    lazy var ageToolBar: UIToolbar = {
        let toolBar = UIToolbar()

        return toolBar
    }()
    
    lazy var heightToolBar: UIToolbar = {
        let toolBar = UIToolbar()

        return toolBar
    }()

    lazy var weightToolBar: UIToolbar = {
        let toolBar = UIToolbar()

        return toolBar
    }()
    
    lazy var dobLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var ageAndBloodTypeView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var ageAndBloodTypeLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var ageAndBloodTypeVerticalLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var heightAndWeightView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var heightAndWeightLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var heightAndWeightVerticalLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var emergencyContactsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.register(EmergencyProfileTableViewCell.self, forCellReuseIdentifier: EmergencyProfileTableViewCell.identifier)
        
        return tableView
    }()
    
    lazy var ageLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    lazy var ageTextView: UITextView = {
        let textView = UITextView()
        
        textView.textAlignment = .center
        textView.contentMode = .center
        textView.font = UIFont(name: "Helvetica", size: 18)
        
        textView.isUserInteractionEnabled = true
        textView.textColor = .label
        textView.keyboardType = .decimalPad
        
        return textView
    }()
    
    lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var bloodGroupLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    lazy var bloodGroupTextView: UITextView = {
        let textView = UITextView()
        
        textView.textAlignment = .center
        textView.contentMode = .center
        textView.font = UIFont(name: "Helvetica", size: 18)
        
        textView.isUserInteractionEnabled = true
        textView.textColor = .label
        textView.keyboardType = .alphabet
        
        return textView
    }()
    
    lazy var bloodGroupImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var heightLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    lazy var heightTextView: UITextView = {
        let textView = UITextView()
        
        textView.textAlignment = .center
        textView.contentMode = .center
        textView.font = UIFont(name: "Helvetica", size: 18)
        
        textView.isUserInteractionEnabled = true
        textView.textColor = .label
        textView.keyboardType = .decimalPad
        
        return textView
    }()
    
    lazy var heightImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var weightLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    lazy var weightTextView: UITextView = {
        let textView = UITextView()
        
        textView.textAlignment = .center
        textView.contentMode = .center
        textView.font = UIFont(name: "Helvetica", size: 18)
        
        textView.isUserInteractionEnabled = true
        textView.textColor = .label
        textView.keyboardType = .decimalPad
        
        return textView
    }()
    
    lazy var weightImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var addPreviousMedication: ResizedButton = {
        let button = ResizedButton()
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    lazy var previousMedicationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var contactPickerViewController: CNContactPickerViewController = {
        let contactPicker = CNContactPickerViewController()
        
        return contactPicker
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        
        view.progressTintColor = .systemGreen
        
        return view
    }()
    
    lazy var saveBarButton: UIBarButtonItem = {
        let saveBarButton = getSaveBarButton()
        
        return saveBarButton
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
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
    
    var toolBar: UIToolbar!
    
    var classGlobalContactViewController: CNContactViewController?
    var classGlobalContact: CNContact?
    
    let contactStore = CNContactStore()
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    let emergencyProfileVCHelper: EmergencyProfileVCHelper
    var previousEmergencyProfile: EmergencyProfile?
    
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    var bloodGroups = ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"]
    var bloodGroupPreviousSelected = ""
    
    var progress = Float(0.0)
    
    init() {
        emergencyProfileVCHelper = EmergencyProfileVCHelper()
        
        if let savedProfile = UserDefaults.standard.object(forKey: EmergencyProfile.key) as? Data  {
            previousEmergencyProfile = try? decoder.decode(EmergencyProfile.self, from: savedProfile)
        }
        
        progress = UserDefaults.standard.float(forKey: "User-Progress")
        super.init(nibName: nil, bundle: nil)
        
        emergencyProfileVCHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "Emergency Profile"
        
        toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolBar.sizeToFit()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(profileDataCompletionLabel)
        scrollView.addSubview(progressView)
        scrollView.addSubview(saveView)
        saveView.addSubview(saveLabel)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(dateTextView)
        
        scrollView.addSubview(dobLineView)
        scrollView.addSubview(ageAndBloodTypeView)
        ageAndBloodTypeView.addSubview(ageAndBloodTypeVerticalLineView)
        ageAndBloodTypeView.addSubview(ageLabel)
        ageAndBloodTypeView.addSubview(ageTextView)
        ageAndBloodTypeView.addSubview(calendarImageView)
        ageAndBloodTypeView.addSubview(bloodGroupLabel)
        ageAndBloodTypeView.addSubview(bloodGroupTextView)
        ageAndBloodTypeView.addSubview(bloodGroupImageView)
        
        scrollView.addSubview(ageAndBloodTypeLineView)
        
        scrollView.addSubview(heightAndWeightView)
        heightAndWeightView.addSubview(heightAndWeightVerticalLineView)
        heightAndWeightView.addSubview(heightLabel)
        heightAndWeightView.addSubview(heightTextView)
        heightAndWeightView.addSubview(heightImageView)
        heightAndWeightView.addSubview(weightLabel)
        heightAndWeightView.addSubview(weightTextView)
        heightAndWeightView.addSubview(weightImageView)
        
        scrollView.addSubview(heightAndWeightLineView)
        
        scrollView.addSubview(emergencyContactsTableView)
        
        view.addSubview(viewForPickerView)
        viewForPickerView.addSubview(pickerView)
        viewForPickerView.addSubview(toolBar)
        
        progressView.setProgress(0.0, animated: true)
        
        progressView.isHidden = true
        
        configureDelegates()
        configureEmergencyContactsTableView()
        loadScrollView()
        loadPickerView()
        
        requestRequirments()
        loadContents()
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        viewForPickerView.isHidden = true
        
        addTapGesture(toView: self.view)
        addTapGesture(toView: ageLabel)
        addTapGesture(toView: calendarImageView)
        addTapGesture(toView: bloodGroupLabel)
        addTapGesture(toView: bloodGroupImageView)
        addTapGesture(toView: heightLabel)
        addTapGesture(toView: heightImageView)
        addTapGesture(toView: weightLabel)
        addTapGesture(toView: weightImageView)
        addTapGesture(toView: bloodGroupTextView)
    }
    
    func loadContents() {
        loadProfileImageView()
        loadProfileDataCompletionLabel()
        loadProgressView()
        loadSaveView()
        loadSaveLabel()
        loadNameLabel()
        loadDateTextViewToolBar()
        loadAgeTextViewToolBar()
        loadHeightTextViewToolBar()
        loadWeightTextViewToolBar()
        loadDateTextView()
        loadDobLineView()
        
        loadAgeAndBloodTypeView()
        loadAgeAndBloodTypeVerticalLineView()
        loadAgeLabel()
        loadAgeTextView()
        loadCalendarImageView()
        loadBloodGroupLabel()
        loadBloodGroupTextView()
        loadBloodGroupImageView()
        loadAgeAndBloodTypeLineView()
        
        loadHeightAndWeightView()
        loadHeightAndWeightVerticalLineView()
        loadHeightLabel()
        loadHeightTextView()
        loadHeightImageView()
        loadWeightLabel()
        loadWeightTextView()
        loadWeightImageView()
        loadHeightAndWeightLineView()
        
        loadPreviousMedicationHistoryTableView()
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 100
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func requestRequirments() {
        let contactStore = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts){
        case .authorized:
              ()
        case .notDetermined:
            print("Not determined")
            contactStore.requestAccess(for: .contacts){succeeded, err in
                guard err == nil && succeeded else{
                  return
                }
            }
        default:
            print("Not handled")
        }
    }
    
    func getSaveBarButton() -> UIBarButtonItem {
        let barButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSaveButton))
        
        return barButton
    }
    
    func configureDelegates() {
        emergencyContactsTableView.delegate = self
        emergencyContactsTableView.dataSource = self
        
        dateTextView.delegate = self
        ageTextView.delegate = self
        bloodGroupTextView.delegate = self
        heightTextView.delegate = self
        weightTextView.delegate = self
        
        scrollView.delegate = self
        pickerView.delegate = self
        
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapPickerViewCancel))
        let nextBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapPickerViewNext))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelBarButton, flexibleSpace, nextBarButton], animated: true)
    }
    
    func configureEmergencyContactsTableView() {
        emergencyContactsTableView.separatorColor = .systemGray
        emergencyContactsTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        emergencyContactsTableView.sectionFooterHeight = 0.0
    }
    
    @objc func didTapPickerViewCancel(_ sender: UIBarButtonItem) {
        bloodGroupTextView.text = bloodGroupPreviousSelected
        dismissKeyboard()
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapPickerViewNext(_ sender: UIBarButtonItem) {
        dismissKeyboard()
    }
    
    func addTapGesture(toView: UIView){
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == saveView){
            tapGesture.addTarget(self, action: #selector(didTapSaveButton))
        }
        else if(toView == self.view) {
            tapGesture.addTarget(self, action: #selector(didTapDismissTextView))
        }
        else if(toView == ageLabel || toView == calendarImageView) {
            tapGesture.addTarget(self, action: #selector(didTapActivateAgeTextView))
        }
        else if(toView == bloodGroupLabel || toView == bloodGroupImageView) {
            tapGesture.addTarget(self, action: #selector(didTapActivateBloodGroupTextView))
        }
        else if(toView == heightLabel || toView == heightImageView) {
            tapGesture.addTarget(self, action: #selector(didTapActivateHeightTextView))
        }
        else if(toView == weightLabel || toView == weightImageView) {
            tapGesture.addTarget(self, action: #selector(didTapActivateWeightTextView))
        }
        else if(toView == bloodGroupTextView) {
            tapGesture.addTarget(self, action: #selector(didTapActivateBloodGroupTextView))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapDismissTextView(_ sender: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        if(dateTextView.isFirstResponder) {
            dateTextView.resignFirstResponder()
        }
        else if(ageTextView.isFirstResponder) {
            ageTextView.resignFirstResponder()
        }
        else if(bloodGroupTextView.isFirstResponder) {
            bloodGroupTextView.resignFirstResponder()
        }
        else if(heightTextView.isFirstResponder) {
            heightTextView.resignFirstResponder()
        }
        else if(weightTextView.isFirstResponder) {
            weightTextView.resignFirstResponder()
        }
        
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapActivateAgeTextView() {
        ageTextView.becomeFirstResponder()
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapActivateBloodGroupTextView() {
        if(ageTextView.isFirstResponder) {
            ageTextView.resignFirstResponder()
        }
        else if(heightTextView.isFirstResponder) {
            heightTextView.resignFirstResponder()
        }
        else if(weightTextView.isFirstResponder) {
            weightTextView.resignFirstResponder()
        }
        
        showViewForPickerView()
    }
    
    @objc func didTapActivateHeightTextView() {
        heightTextView.becomeFirstResponder()
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapActivateWeightTextView() {
        weightTextView.becomeFirstResponder()
        viewForPickerView.isHidden = true
    }
    
    func showViewForPickerView() {
        if(bloodGroupTextView.text == "-") {
            bloodGroupTextView.text = bloodGroups[0]
            bloodGroupPreviousSelected = "-"
        }
        else {
            bloodGroupPreviousSelected = bloodGroupTextView.text
        }
        viewForPickerView.isHidden = false
    }
    
    @objc func didTapSaveButton(_ sender: UIBarButtonItem){
        print("Save pressed")
        if((dateTextView.text == "DOB" || dateTextView.text.count == 0) ||
           (ageTextView.text == "-" || ageTextView.text.count == 0) ||
           (bloodGroupTextView.text == "-" || bloodGroupTextView.text.count == 0) ||
           (heightTextView.text == "-" || heightTextView.text.count == 0) ||
           (weightTextView.text == "-" || weightTextView.text.count == 0)){
            let alertView = UIAlertController(title: "Unfilled Data Fields", message: "Please make sure all fields are filled", preferredStyle: .alert)
            
            alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: .none))
            
            present(alertView, animated: true)
        }
        else{
            guard let name = nameLabel.text, let age = dateTextView.text, let bloodGroup = bloodGroupTextView.text, let height = heightTextView.text, let weight = weightTextView.text, let dob = ageTextView.text else{
                print("Failed to save details")
                return
            }
            
            let emergencyProfile = EmergencyProfile(
                name: name,
                dateOfBirth: dob,
                age: age,
                bloodGroup: bloodGroup,
                height: height,
                weight: weight)
            
            if let encoded = try? encoder.encode(emergencyProfile) {
                UserDefaults.standard.set(encoded, forKey: EmergencyProfile.key)
            }
            
            UserDefaults.standard.set(progress, forKey: "User-Progress")
            
            let alertView = UIAlertController(title: "", message: "Emergency Profile Details has been saved successfully", preferredStyle: .alert)
            
            alertView.addAction(UIAlertAction(title: "Okay", style: .default){ _ in
                self.navigationItem.rightBarButtonItem = nil
                
                self.navigationController?.popViewController(animated: true)
            })
            
            present(alertView, animated: true)
        }
    }
    
    func loadPickerView() {
        viewForPickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        var toolBarHeight = CGFloat(50)
        
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
            toolBar.heightAnchor.constraint(equalToConstant: toolBarHeight),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
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
    
    func loadProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UserDefaults.standard.image(forKey: "User Selected Image" + "-\(UserDefaults.standard.integer(forKey: "User - Id"))"){
            profileImageView.image = image
        }
        else{
            profileImageView.image = UserDefaults.standard.image(forKey: "Default Image")
        }
        
        if(view.frame.height < 800){
            NSLayoutConstraint.activate([
                profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
                profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
                profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 15)
            ])
        }
        else{
            NSLayoutConstraint.activate([
                profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.17),
                profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
                profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                profileImageView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0.05*view.frame.height)
            ])
        }
        
        profileImageView.layer.cornerRadius = 10
    }
    
    func loadProfileDataCompletionLabel() {
        profileDataCompletionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        profileDataCompletionLabel.text = "Profile status:"
        
        profileDataCompletionLabel.isHidden = true
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            NSLayoutConstraint.activate([
                profileDataCompletionLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
                profileDataCompletionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 0.08*view.frame.width)
            ])
        }
        else{
            NSLayoutConstraint.activate([
                profileDataCompletionLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
                profileDataCompletionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 15)
            ])
        }
    }
    
    func loadProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: profileDataCompletionLabel.bottomAnchor,constant: 2),
            progressView.leadingAnchor.constraint(equalTo: profileDataCompletionLabel.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: profileDataCompletionLabel.trailingAnchor,constant: -5),
            progressView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func loadSaveView() {
        saveView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            NSLayoutConstraint.activate([
                saveView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
                saveView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -0.08*view.frame.width),
                saveView.widthAnchor.constraint(equalToConstant: 0.2*view.frame.width),
                saveView.heightAnchor.constraint(equalToConstant: 0.04*view.frame.height)
            ])
        }
        else{
            NSLayoutConstraint.activate([
                saveView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
                saveView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15),
                saveView.widthAnchor.constraint(equalToConstant: 0.2*view.frame.width),
                saveView.heightAnchor.constraint(equalToConstant: 0.04*view.frame.height)
            ])
        }
    }
    
    func loadSaveLabel() {
        saveLabel.translatesAutoresizingMaskIntoConstraints = false
        
        saveLabel.textColor = .systemBlue
        
        NSLayoutConstraint.activate([
            saveLabel.topAnchor.constraint(equalTo: saveView.topAnchor),
            saveLabel.trailingAnchor.constraint(equalTo: saveView.trailingAnchor,constant: 0)
        ])
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = UserDefaults.standard.string(forKey: "User - Name")
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor)
        ])
    }
    
    func loadDateTextViewToolBar() {
        dateTextViewToolBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDonePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dateCancelPressed))
        
        dateTextViewToolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: true)
    }
    
    @objc func dateDonePressed(_ sender: UIBarButtonItem) {
        ageTextView.text = formatter.string(from: datePicker.date)
        ageTextView.endEditing(true)
        
        if(dateTextView.text != "DOB" && dateTextView.text.count > 3){
            emergencyProfileVCHelper.progressTracker["DOB"] = true
            progress += 0.2
            progressView.setProgress(progress, animated: true)
        }
        else {
            if(emergencyProfileVCHelper.progressTracker["DOB"] == true){
                if(progress > 0.0){
                    progress -= 0.2
                    progressView.setProgress(progress, animated: true)
                }
            }
        }
    }
    
    @objc func dateCancelPressed(_ sender: UIBarButtonItem) {
        ageTextView.endEditing(true)
    }
    
    func loadAgeTextViewToolBar() {
        ageToolBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ageDonePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        ageToolBar.setItems([flexibleSpace, doneButton], animated: true)
    }
    
    @objc func ageDonePressed(_ sender: UIBarButtonItem) {
        ageTextView.endEditing(true)
        
        if(ageTextView.text != "-" && ageTextView.text.count > 0){
            emergencyProfileVCHelper.progressTracker["age"] = true
            progress += 0.2
            progressView.setProgress(progress, animated: true)
        }
        else {
            if(emergencyProfileVCHelper.progressTracker["age"] == true){
                if(progress > 0.0){
                    progress -= 0.2
                    progressView.setProgress(progress, animated: true)
                }
            }
        }
    }
    
    @objc func bloodTypeDonePressed(_ sender: UIBarButtonItem) {
        bloodGroupTextView.endEditing(true)
        
        if(bloodGroupTextView.text != "-" && bloodGroupTextView.text.count > 0){
            emergencyProfileVCHelper.progressTracker["bloodGroup"] = true
            progress += 0.2
            progressView.setProgress(progress, animated: true)
        }
        else {
            if(emergencyProfileVCHelper.progressTracker["bloodGroup"] == true){
                if(progress > 0.0){
                    progress -= 0.2
                    progressView.setProgress(progress, animated: true)
                }
            }
        }
    }
    
    func loadHeightTextViewToolBar() {
        heightToolBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(heightDonePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        heightToolBar.setItems([flexibleSpace, doneButton], animated: true)
    }
    
    @objc func heightDonePressed(_ sender: UIBarButtonItem) {
        heightTextView.endEditing(true)
        
        if(heightTextView.text != "-" && heightTextView.text.count > 0){
            emergencyProfileVCHelper.progressTracker["height"] = true
            progress += 0.2
            progressView.setProgress(progress, animated: true)
        }
        else {
            if(emergencyProfileVCHelper.progressTracker["height"] == true){
                if(progress > 0.0){
                    progress -= 0.2
                    progressView.setProgress(progress, animated: true)
                }
            }
        }
    }
    
    func loadWeightTextViewToolBar() {
        weightToolBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(weightDonePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        weightToolBar.setItems([flexibleSpace, doneButton], animated: true)
    }
    
    @objc func weightDonePressed(_ sender: UIBarButtonItem) {
        weightTextView.endEditing(true)
        
        if(weightTextView.text != "-" && weightTextView.text.count > 0){
            emergencyProfileVCHelper.progressTracker["weight"] = true
            progress += 0.2
            progressView.setProgress(progress, animated: true)
        }
        else {
            if(emergencyProfileVCHelper.progressTracker["weight"] == true){
                if(progress > 0.0){
                    progress -= 0.2
                    progressView.setProgress(progress, animated: true)
                }
            }
        }
    }
    
    func loadDateTextView() {
        dateTextView.translatesAutoresizingMaskIntoConstraints = false
        
        if(previousEmergencyProfile != nil){
            dateTextView.text = previousEmergencyProfile?.age
        }
        else{
            dateTextView.text = "- years"
        }
        
        NSLayoutConstraint.activate([
            dateTextView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            dateTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            dateTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
    }
    
    
    func loadDobLineView() {
        dobLineView.translatesAutoresizingMaskIntoConstraints = false
        
        dobLineView.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            dobLineView.topAnchor.constraint(equalTo: dateTextView.bottomAnchor),
            dobLineView.leadingAnchor.constraint(equalTo: profileDataCompletionLabel.leadingAnchor,constant: 5),
            dobLineView.trailingAnchor.constraint(equalTo: saveView.trailingAnchor,constant: -5),
            dobLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func loadAgeAndBloodTypeView() {
        ageAndBloodTypeView.translatesAutoresizingMaskIntoConstraints = false
        
        if(view.frame.height < 800){
            NSLayoutConstraint.activate([
                ageAndBloodTypeView.topAnchor.constraint(equalTo: dobLineView.bottomAnchor),
                ageAndBloodTypeView.leadingAnchor.constraint(equalTo: dobLineView.leadingAnchor),
                ageAndBloodTypeView.trailingAnchor.constraint(equalTo: dobLineView.trailingAnchor),
                ageAndBloodTypeView.heightAnchor.constraint(equalToConstant: 0.15*view.frame.height)
            ])
        }
        else{
            NSLayoutConstraint.activate([
                ageAndBloodTypeView.topAnchor.constraint(equalTo: dobLineView.bottomAnchor),
                ageAndBloodTypeView.leadingAnchor.constraint(equalTo: dobLineView.leadingAnchor),
                ageAndBloodTypeView.trailingAnchor.constraint(equalTo: dobLineView.trailingAnchor),
                ageAndBloodTypeView.heightAnchor.constraint(equalToConstant: 0.13*view.frame.height)
            ])
        }
    }
    
    func loadAgeAndBloodTypeVerticalLineView() {
        ageAndBloodTypeVerticalLineView.translatesAutoresizingMaskIntoConstraints = false
        
        ageAndBloodTypeVerticalLineView.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            ageAndBloodTypeVerticalLineView.topAnchor.constraint(equalTo: ageAndBloodTypeView.topAnchor),
            ageAndBloodTypeVerticalLineView.bottomAnchor.constraint(equalTo: ageAndBloodTypeView.bottomAnchor),
            ageAndBloodTypeVerticalLineView.widthAnchor.constraint(equalToConstant: 1),
            ageAndBloodTypeVerticalLineView.centerXAnchor.constraint(equalTo: ageAndBloodTypeView.centerXAnchor)
        ])
    }
    
    func loadAgeLabel() {
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ageLabel.text = "DOB:"
        
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: ageAndBloodTypeView.topAnchor,constant: 10),
            ageLabel.leadingAnchor.constraint(equalTo: ageAndBloodTypeView.leadingAnchor,constant: 15),
        ])
    }
    
    func loadAgeTextView() {
        ageTextView.translatesAutoresizingMaskIntoConstraints = false
        
        if(previousEmergencyProfile != nil){
            ageTextView.text = previousEmergencyProfile?.dateOfBirth
        }
        else{
            ageTextView.text = "-"
        }
        
        ageTextView.inputView = datePicker
        ageTextView.inputAccessoryView = dateTextViewToolBar
        
        var constant = 0.0
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            constant = 0
        }
        else {
            constant = 10
        }
        
        NSLayoutConstraint.activate([
            ageTextView.leadingAnchor.constraint(equalTo: ageAndBloodTypeView.leadingAnchor, constant: 1),
            ageTextView.trailingAnchor.constraint(equalTo: ageAndBloodTypeVerticalLineView.leadingAnchor, constant: -1),
            ageTextView.centerYAnchor.constraint(equalTo: ageAndBloodTypeView.centerYAnchor, constant: constant),
            ageTextView.heightAnchor.constraint(equalTo: ageAndBloodTypeView.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func loadCalendarImageView() {
        calendarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysOriginal)
        
        calendarImageView.image = image?.withTintColor(.systemGreen)
        
        NSLayoutConstraint.activate([
            calendarImageView.topAnchor.constraint(equalTo: ageLabel.topAnchor,constant: 5),
            calendarImageView.trailingAnchor.constraint(equalTo: ageAndBloodTypeVerticalLineView.leadingAnchor,constant: -15),
            calendarImageView.heightAnchor.constraint(equalTo: ageLabel.heightAnchor, multiplier: 0.8),
            calendarImageView.widthAnchor.constraint(equalTo: calendarImageView.heightAnchor)
        ])
    }
    
    func loadBloodGroupLabel() {
        bloodGroupLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bloodGroupLabel.text = "Blood type:"
        
        NSLayoutConstraint.activate([
            bloodGroupLabel.topAnchor.constraint(equalTo: ageAndBloodTypeView.topAnchor,constant: 10),
            bloodGroupLabel.leadingAnchor.constraint(equalTo: ageAndBloodTypeVerticalLineView.leadingAnchor,constant: 15),
        ])
    }
    
    func loadBloodGroupTextView() {
        bloodGroupTextView.translatesAutoresizingMaskIntoConstraints = false
        
        if(previousEmergencyProfile != nil){
            bloodGroupTextView.text = previousEmergencyProfile?.bloodGroup
        }
        else{
            bloodGroupTextView.text = "-"
        }
        
        NSLayoutConstraint.activate([
            bloodGroupTextView.leadingAnchor.constraint(equalTo: ageAndBloodTypeVerticalLineView.leadingAnchor, constant: 3),
            bloodGroupTextView.trailingAnchor.constraint(equalTo: ageAndBloodTypeView.trailingAnchor, constant: -3),
            bloodGroupTextView.centerYAnchor.constraint(equalTo: ageAndBloodTypeView.centerYAnchor, constant: 10),
            bloodGroupTextView.heightAnchor.constraint(equalTo: ageAndBloodTypeView.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func loadBloodGroupImageView() {
        bloodGroupImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "drop")?.withRenderingMode(.alwaysOriginal)
        
        bloodGroupImageView.image = image?.withTintColor(.systemRed)
        
        NSLayoutConstraint.activate([
            bloodGroupImageView.topAnchor.constraint(equalTo: bloodGroupLabel.topAnchor, constant: 5),
            bloodGroupImageView.trailingAnchor.constraint(equalTo: ageAndBloodTypeView.trailingAnchor,constant: -15),
            bloodGroupImageView.heightAnchor.constraint(equalTo: bloodGroupLabel.heightAnchor,multiplier: 0.8),
            bloodGroupImageView.widthAnchor.constraint(equalTo: bloodGroupImageView.heightAnchor)
        ])
    }
    
    func loadAgeAndBloodTypeLineView() {
        ageAndBloodTypeLineView.translatesAutoresizingMaskIntoConstraints = false
        
        ageAndBloodTypeLineView.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            ageAndBloodTypeLineView.topAnchor.constraint(equalTo: ageAndBloodTypeView.bottomAnchor),
            ageAndBloodTypeLineView.leadingAnchor.constraint(equalTo: ageAndBloodTypeView.leadingAnchor),
            ageAndBloodTypeLineView.trailingAnchor.constraint(equalTo: ageAndBloodTypeView.trailingAnchor),
            ageAndBloodTypeLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func loadHeightAndWeightView() {
        heightAndWeightView.translatesAutoresizingMaskIntoConstraints = false
        
        if(view.frame.height < 800){
            NSLayoutConstraint.activate([
                heightAndWeightView.topAnchor.constraint(equalTo: ageAndBloodTypeLineView.bottomAnchor),
                heightAndWeightView.leadingAnchor.constraint(equalTo: ageAndBloodTypeLineView.leadingAnchor),
                heightAndWeightView.trailingAnchor.constraint(equalTo: ageAndBloodTypeLineView.trailingAnchor),
                heightAndWeightView.heightAnchor.constraint(equalToConstant: 0.15*view.frame.height)
            ])
        }
        else{
            NSLayoutConstraint.activate([
                heightAndWeightView.topAnchor.constraint(equalTo: ageAndBloodTypeLineView.bottomAnchor),
                heightAndWeightView.leadingAnchor.constraint(equalTo: ageAndBloodTypeLineView.leadingAnchor),
                heightAndWeightView.trailingAnchor.constraint(equalTo: ageAndBloodTypeLineView.trailingAnchor),
                heightAndWeightView.heightAnchor.constraint(equalToConstant: 0.13*view.frame.height)
            ])
        }
    }
    
    func loadHeightAndWeightVerticalLineView() {
        heightAndWeightVerticalLineView.translatesAutoresizingMaskIntoConstraints = false
        
        heightAndWeightVerticalLineView.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            heightAndWeightVerticalLineView.topAnchor.constraint(equalTo: heightAndWeightView.topAnchor),
            heightAndWeightVerticalLineView.bottomAnchor.constraint(equalTo: heightAndWeightView.bottomAnchor),
            heightAndWeightVerticalLineView.widthAnchor.constraint(equalToConstant: 1),
            heightAndWeightVerticalLineView.centerXAnchor.constraint(equalTo: heightAndWeightView.centerXAnchor)
        ])
    }
    
    func loadHeightLabel(){
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        heightLabel.text = "Height:"
        
        NSLayoutConstraint.activate([
            heightLabel.topAnchor.constraint(equalTo: heightAndWeightView.topAnchor,constant: 10),
            heightLabel.leadingAnchor.constraint(equalTo: heightAndWeightView.leadingAnchor,constant: 15)
        ])
    }
    
    func loadHeightTextView(){
        heightTextView.translatesAutoresizingMaskIntoConstraints = false
        
        if(previousEmergencyProfile != nil){
            heightTextView.text = previousEmergencyProfile?.height
        }
        else{
            heightTextView.text = "- cm"
        }
        
        heightTextView.inputAccessoryView = heightToolBar
        
        NSLayoutConstraint.activate([
            heightTextView.topAnchor.constraint(equalTo: heightLabel.bottomAnchor),
            heightTextView.leadingAnchor.constraint(equalTo: heightAndWeightView.leadingAnchor, constant: 3),
            heightTextView.trailingAnchor.constraint(equalTo: heightAndWeightVerticalLineView.leadingAnchor, constant: -3),
            heightTextView.centerYAnchor.constraint(equalTo: heightAndWeightView.centerYAnchor, constant: 10),
            heightTextView.heightAnchor.constraint(equalTo: heightAndWeightView.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func loadHeightImageView(){
        heightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "ruler")?.withRenderingMode(.alwaysOriginal)
        
        heightImageView.image = image?.withTintColor(UIColor(red: 58/255, green: 198/255, blue: 213/255, alpha: 1))
        
        heightImageView.transform = CGAffineTransform(rotationAngle: .pi)
        
        NSLayoutConstraint.activate([
            heightImageView.topAnchor.constraint(equalTo: heightLabel.topAnchor,constant: 3),
            heightImageView.trailingAnchor.constraint(equalTo: heightAndWeightVerticalLineView.leadingAnchor,constant: -15),
            heightImageView.heightAnchor.constraint(equalTo: heightLabel.heightAnchor, multiplier: 0.8),
            heightImageView.widthAnchor.constraint(equalTo: heightImageView.heightAnchor)
        ])
    }
    
    func loadWeightLabel(){
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        
        weightLabel.text = "Weight:"
        
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: heightAndWeightView.topAnchor,constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: heightAndWeightVerticalLineView.trailingAnchor, constant: 15)
        ])
    }
    
    func loadWeightTextView(){
        weightTextView.translatesAutoresizingMaskIntoConstraints = false
        
        if(previousEmergencyProfile != nil){
            weightTextView.text = previousEmergencyProfile?.weight
        }
        else{
            weightTextView.text = "- kg"
        }
        
        weightTextView.inputAccessoryView = weightToolBar
        
        NSLayoutConstraint.activate([
            weightTextView.topAnchor.constraint(equalTo: weightLabel.bottomAnchor),
            weightTextView.leadingAnchor.constraint(equalTo: heightAndWeightVerticalLineView.leadingAnchor, constant: 3),
            weightTextView.trailingAnchor.constraint(equalTo: heightAndWeightView.trailingAnchor, constant: -3),
            weightTextView.centerYAnchor.constraint(equalTo: heightAndWeightView.centerYAnchor, constant: 10),
            weightTextView.heightAnchor.constraint(equalTo: heightAndWeightView.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func loadWeightImageView(){
        weightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "scalemass")?.withRenderingMode(.alwaysOriginal)
        
        weightImageView.image = image?.withTintColor(.systemPurple)
        
        NSLayoutConstraint.activate([
            weightImageView.topAnchor.constraint(equalTo: weightLabel.topAnchor, constant: 3),
            weightImageView.trailingAnchor.constraint(equalTo: heightAndWeightView.trailingAnchor,constant: -15),
            weightImageView.heightAnchor.constraint(equalTo: weightLabel.heightAnchor, multiplier: 0.8),
            weightImageView.widthAnchor.constraint(equalTo: weightImageView.heightAnchor)
        ])
    }
    
    func loadHeightAndWeightLineView() {
        heightAndWeightLineView.translatesAutoresizingMaskIntoConstraints = false
        
        heightAndWeightLineView.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            heightAndWeightLineView.topAnchor.constraint(equalTo: heightAndWeightView.bottomAnchor),
            heightAndWeightLineView.leadingAnchor.constraint(equalTo: heightAndWeightView.leadingAnchor),
            heightAndWeightLineView.trailingAnchor.constraint(equalTo: heightAndWeightView.trailingAnchor),
            heightAndWeightLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func loadPreviousMedicationHistoryTableView(){
        emergencyContactsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        emergencyContactsTableView.backgroundColor = view.backgroundColor
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            
            let padding = CGFloat(16)
            
            let constraints = [
                emergencyContactsTableView.topAnchor.constraint(equalTo: heightAndWeightLineView.bottomAnchor,constant: 10),
                emergencyContactsTableView.leadingAnchor.constraint(equalTo: heightAndWeightLineView.leadingAnchor, constant: -padding),
                emergencyContactsTableView.trailingAnchor.constraint(equalTo: heightAndWeightLineView.trailingAnchor, constant: padding),
                emergencyContactsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -15),
                emergencyContactsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            var height = 0.24
            
            if(view.frame.height > 800) {
                height = 0.25
            }
            
            let padding = CGFloat(16)
            
            let constraints = [
                emergencyContactsTableView.topAnchor.constraint(equalTo: heightAndWeightLineView.bottomAnchor,constant: 10),
                emergencyContactsTableView.leadingAnchor.constraint(equalTo: heightAndWeightLineView.leadingAnchor, constant: -padding),
                emergencyContactsTableView.trailingAnchor.constraint(equalTo: heightAndWeightLineView.trailingAnchor, constant: padding),
                emergencyContactsTableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -15),
                emergencyContactsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        
        emergencyContactsTableView.layer.cornerRadius = 10
    }
    
    @objc func didTapAddContact(_ sender: UIButton) {
        print("Add previous medication pressed.")
        
        contactPickerViewController.delegate = self
        
        present(contactPickerViewController, animated: true)
    }
    
    @objc func didTapCancelBarButton(_ sender: UIBarButtonItem){
        
        guard let classGlobalContactViewController = classGlobalContactViewController else {
            return
        }
        
        contactViewController(classGlobalContactViewController, didCompleteWith: classGlobalContact)
    }
    
    func getCancelBarButton() -> UIBarButtonItem {
        let barButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelBarButton))
        
        return barButton
    }
}

extension EmergencyProfileVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emergencyProfileVCHelper.emergencyContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmergencyProfileTableViewCell.identifier, for: indexPath) as? EmergencyProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.contentView.backgroundColor = .systemGroupedBackground
        cell.emergencyContact = emergencyProfileVCHelper.emergencyContacts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let number = emergencyProfileVCHelper.emergencyContacts[indexPath.row].number

        let predicate = CNContact.predicateForContacts(matching: CNPhoneNumber(stringValue: number))
        
        let keysToFetch: [CNKeyDescriptor] = [CNContactIdentifierKey, CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataAvailableKey, CNContactImageDataKey, CNContactViewController.descriptorForRequiredKeys()] as! [CNKeyDescriptor]
        
        if let contact = try? contactStore.unifiedContacts(matching: predicate, keysToFetch: keysToFetch){
            print("Printing fetched contacts...")
            print(contact)
            let contactViewController = CNContactViewController(for: contact.first ?? CNContact())
            
            contactViewController.delegate = self
            
            classGlobalContactViewController = contactViewController
            classGlobalContact = contact.first ?? CNContact()
            
            let navVC = UINavigationController(rootViewController: contactViewController)
            
            navVC.navigationBar.topItem?.leftBarButtonItems = [getCancelBarButton()]
            
            present(navVC, animated: true)
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        view.addSubview(previousMedicationLabel)
        view.addSubview(addPreviousMedication)
        
        addPreviousMedication.translatesAutoresizingMaskIntoConstraints = false
        addPreviousMedication.addTarget(self, action: #selector(didTapAddContact), for: .touchUpInside)
        addPreviousMedication.tintColor = .systemBlue
        
        NSLayoutConstraint.activate([
            addPreviousMedication.topAnchor.constraint(equalTo: previousMedicationLabel.topAnchor,constant: 10),
            addPreviousMedication.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            addPreviousMedication.bottomAnchor.constraint(equalTo: previousMedicationLabel.bottomAnchor,constant: -5)
        ])
        
        previousMedicationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        previousMedicationLabel.text = "Emergency Contacts"
        
        NSLayoutConstraint.activate([
            previousMedicationLabel.topAnchor.constraint(equalTo: view.topAnchor),
            previousMedicationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previousMedicationLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.layer.cornerRadius = 10
        
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? EmergencyProfileTableViewCell else {
            return UISwipeActionsConfiguration()
        }
        
        let deleteContact = UIContextualAction(style: .destructive, title: "Remove Contact") { action, _, _ in
            
            self.emergencyContactsTableView.beginUpdates()
            
            self.emergencyProfileVCHelper.removeContact(cell.emergencyContact, index: indexPath.row)
            
            self.emergencyContactsTableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.emergencyContactsTableView.endUpdates()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteContact])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        0.0
    }
}

extension EmergencyProfileVC: CNContactViewControllerDelegate, CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let emergencyContact = EmergencyContact(
            firstName: contact.givenName,
            lastName: contact.familyName,
            number: (contact.phoneNumbers[0].value).value(forKey: "digits") as! String,
            identifier: contact.identifier,
            profileImage: contact.imageData)
        
        print(emergencyContact)
        if(!emergencyProfileVCHelper.isContactAlreadyPresent(emergencyContact)) {
            emergencyProfileVCHelper.addToEmergencyContactsToTable(emergencyContact)
        }
        else {
            picker.dismiss(animated: true)
            
            print("Terminating redundant emergency contact entry.")
            let alertView = UIAlertController(title: "Emergency contact already exists", message: "The attemp to enter emergency contact was terminated, since it already exists", preferredStyle: .alert)
            
            alertView.addAction(UIAlertAction(title: "Okay", style: .default))
            
            present(alertView, animated: true)
        }
    }
    
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        viewController.dismiss(animated: true)
    }
}

extension EmergencyProfileVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem = saveBarButton

        if(textView == heightTextView) {
            if(textView.text == "- cm"){
                textView.text = ""
            }
            else {
                guard let text = textView.text else {
                    return
                }
                
                let range = text.index(text.startIndex, offsetBy: 0)...text.index(text.endIndex, offsetBy: -3)
                
                textView.text = "\(text[range])".trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        else if(textView == weightTextView) {
            if(textView.text == "- kg"){
                textView.text = ""
            }
            else {
                guard let text = textView.text else {
                    return
                }
                
                let range = text.index(text.startIndex, offsetBy: 0)...text.index(text.endIndex, offsetBy: -3)
                
                textView.text = "\(text[range])".trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView == ageTextView) {
            guard let date = ageTextView.text, date != "-" else {
                return
            }
            
            let range = date.index(date.endIndex, offsetBy: -4)...date.index(date.endIndex, offsetBy: -1)
            
            let year = date[range]
            print(year)
            
            let currentYear = Calendar.current.component(.year, from: Date.now)
            
            print(currentYear)
            
            dateTextView.text = "\(currentYear - (Int("\(year)") ?? 0)) year(s)"
        }
        if(textView == heightTextView) {
            if(textView.text.count == 0){
                textView.text = "- cm"
                return
            }
            textView.text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines) + " cm"
        }
        else if(textView == weightTextView) {
            if(textView.text.count == 0){
                textView.text = "- kg"
                return
            }
            textView.text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines) + " kg"
        }
    }
}

extension EmergencyProfileVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}

extension EmergencyProfileVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        bloodGroups.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        bloodGroups[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        bloodGroupTextView.text = bloodGroups[row]
    }
}
