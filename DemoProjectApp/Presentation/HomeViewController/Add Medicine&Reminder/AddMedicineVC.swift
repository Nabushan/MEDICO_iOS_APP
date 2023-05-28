//
//  AddMedicineVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 23/09/22.
//

import UIKit

class AddMedicineVC: UIViewController, AddMedicineVCProtocol {
    
    lazy var medImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "pill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    lazy var medicineNameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.textAlignment = .left
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var medicineNameField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.placeholder = "Enter Medicine Name"
        textField.clipsToBounds = true
        textField.tag = 0
        textField.returnKeyType = .done
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    lazy var medicineTypeLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.textAlignment = .left
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var medicineTypeView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var timeAndScheduleView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var timeIntervalSegmentedControl: UISegmentedControl = {
        
        var items: [String] = []
        
        for item in FoodInterval.allCases {
            items.append(item.intervalName)
        }
        
        let segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .systemBlue
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        return segmentedControl
    }()
    
    lazy var scheduleSegmentedControl: UISegmentedControl = {
        
        var items: [String] = []
        
        for item in Schedule.allCases {
            items.append(item.scheduleName)
        }
        
        let segmentedControl = UISegmentedControl(items: items)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .systemBlue
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        return segmentedControl
    }()
    
    lazy var scheduleLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.textAlignment = .left
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var intervalLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.textAlignment = .left
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var pillCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layoutProvider.getPillLayout())
        
        collectionView.register(AddMedicineCollectionViewCell.self, forCellWithReuseIdentifier: AddMedicineCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let layoutProvider = CollectionViewLayoutProvider()
    
    var toolBar: UIToolbar!
    
    var date: String!
    
    weak var delegate: ReminderProtocol?
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        
        datePicker.minimumDate = Date.now
        
        return datePicker
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMM, yyyy HH:mm a"
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        
        return formatter
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let addMedicineVCHelper = AddMedicineVCHelper()
    
    lazy var incompleteCredentialAlertView: UIAlertController = {
        let alertView = UIAlertController(title: "Incomplete Credentials", message: "Please make sure all fields are filled.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Okay", style: .default))
        
        return alertView
    }()
    
    lazy var repeatRemindersView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var dateTimeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.register(AddmedicineVCTableViewCell.self, forCellReuseIdentifier: AddmedicineVCTableViewCell.identifier)
        
        return tableView
    }()
    
    var reminderDateAndTime: [ReminderDateAndTime] = []
    var selectedRepeatState: ReminderRepeatPreference = .never
    
    var selectDateAndTimeLabel: ResizedLabel?
    
    var previouslySelectedCell: AddMedicineCollectionViewCell?
    
    let pillNames: [String] = [
        "pill",
        "tonic",
        "vaccine",
        "dental med",
        "capsule"
    ]
    
    var previousMedicineConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    var medicineType: String = "pill"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "New Reminder"
        
        toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        view.addSubview(scrollView)
        scrollView.addSubview(medImageView)
        scrollView.addSubview(medicineNameLabel)
        scrollView.addSubview(medicineNameField)
        scrollView.addSubview(medicineTypeLabel)
        scrollView.addSubview(medicineTypeView)
        medicineTypeView.addSubview(pillCollectionView)
        scrollView.addSubview(timeAndScheduleView)
        timeAndScheduleView.addSubview(timeIntervalSegmentedControl)
        timeAndScheduleView.addSubview(scheduleLabel)
        timeAndScheduleView.addSubview(scheduleSegmentedControl)
        timeAndScheduleView.addSubview(intervalLabel)
        timeAndScheduleView.addSubview(dateTimeTableView)
        
        view.bringSubviewToFront(medicineTypeView)
        view.bringSubviewToFront(dateTimeTableView)
        
        configureBarItems()
        configureTextfieldDelegates()
        configureCollectionViewDelegates()
        configureAddMedicineHelperDelegate()
        
        loadScrollView()
        loadComponents()
        configureTableView()
        
        addTapGesture(toView: medicineNameLabel)
        addTapGesture(toView: medicineTypeLabel)

        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
          }
      }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousMedicineConstraintsToDeActivate)
        previousMedicineConstraintsToDeActivate = []
        
        loadComponents()
        
        pillCollectionView.collectionViewLayout = layoutProvider.getPillLayout()
        pillCollectionView.reloadData()
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
        
        NSLayoutConstraint.deactivate(previousMedicineConstraintsToDeActivate)
        previousMedicineConstraintsToDeActivate = []
        
        loadComponents()
        
        pillCollectionView.collectionViewLayout = layoutProvider.getPillLayout()
        pillCollectionView.reloadData()
    }
    
    func configureTableView() {
        dateTimeTableView.delegate = self
        dateTimeTableView.dataSource = self
    }
    
    func loadScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.delegate = self
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func loadComponents() {
        loadMedImageView()
        loadMedicineNameLabel()
        loadMedicineNameField()
        loadMedicineTypeLabel()
        loadMedicineTypeView()
        loadPillCollectionView()
        loadTimeAndScheduleView()
        loadScheduleLabel()
        loadTimeIntervalSegmentedControl()
        loadIntervalLabel()
        loadScheduleSegmentedControl()
        loadDateTimeTableView()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        addTapGesture(toView: medicineNameLabel)
        addTapGesture(toView: medicineTypeLabel)
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                
                if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                    if(medicineNameField.isFirstResponder) {
                        return
                    }
                }
                self.view.frame.origin.y -= keyboardSize.height - 100
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        removeGestures()
    
        self.view.frame.origin.y = 0
    }
    
    func configureCollectionViewDelegates() {
        pillCollectionView.delegate = self
        pillCollectionView.dataSource = self
    }
    
    func configureAddMedicineHelperDelegate() {
        addMedicineVCHelper.delegate = self
    }
    
    func loadMedImageView() {
        medImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                let constraints = [
                    medImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
                    medImageView.widthAnchor.constraint(equalToConstant: 0.8*view.frame.height),
                    medImageView.heightAnchor.constraint(equalToConstant: 0.23*view.frame.width),
                    medImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previousMedicineConstraintsToDeActivate.append(constraint)
                }
            }
            else {
                let constraints = [
                    medImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
                    medImageView.widthAnchor.constraint(equalToConstant: 0.8*view.frame.width),
                    medImageView.heightAnchor.constraint(equalToConstant: 0.23*view.frame.height),
                    medImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previousMedicineConstraintsToDeActivate.append(constraint)
                }
            }
        }
        else{
            let constraints = [
                medImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
                medImageView.widthAnchor.constraint(equalToConstant: 0.9*view.frame.width),
                medImageView.heightAnchor.constraint(equalToConstant: 0.23*view.frame.height),
                medImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousMedicineConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadMedicineNameLabel() {
        medicineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        medicineNameLabel.text = "Medicine Name"
        
        let constraints = [
            medicineNameLabel.topAnchor.constraint(equalTo: medImageView.bottomAnchor,constant: 0),
            medicineNameLabel.leadingAnchor.constraint(equalTo: medImageView.leadingAnchor),
            medicineNameLabel.trailingAnchor.constraint(equalTo: medImageView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousMedicineConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMedicineNameField() {
        medicineNameField.translatesAutoresizingMaskIntoConstraints = false
        
        medicineNameField.layer.borderColor = UIColor.systemGray.cgColor
        medicineNameField.layer.borderWidth = 2
        
        NSLayoutConstraint.activate([
            medicineNameField.topAnchor.constraint(equalTo: medicineNameLabel.bottomAnchor,constant: 0),
            medicineNameField.leadingAnchor.constraint(equalTo: medicineNameLabel.leadingAnchor),
            medicineNameField.trailingAnchor.constraint(equalTo: medicineNameLabel.trailingAnchor)
        ])
    }
    
    func loadMedicineTypeLabel() {
        medicineTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        medicineTypeLabel.text = "Type"
        
        NSLayoutConstraint.activate([
            medicineTypeLabel.topAnchor.constraint(equalTo: medicineNameField.bottomAnchor,constant: 10),
            medicineTypeLabel.leadingAnchor.constraint(equalTo: medicineNameField.leadingAnchor),
            medicineTypeLabel.trailingAnchor.constraint(equalTo: medicineNameField.trailingAnchor)
        ])
    }
    
    func loadMedicineTypeView() {
        medicineTypeView.translatesAutoresizingMaskIntoConstraints = false
    
        var heightAnchor: NSLayoutConstraint?
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                heightAnchor = medicineTypeView.heightAnchor.constraint(equalToConstant: 0.2*view.frame.height)
            }
            else {
                heightAnchor = medicineTypeView.heightAnchor.constraint(equalToConstant: 0.4*view.frame.height)
            }
        }
        else{
            heightAnchor = medicineTypeView.heightAnchor.constraint(equalToConstant: 0.17*view.frame.height)
        }
        
        guard let heightAnchor = heightAnchor else {
            return
        }
        
        let constraints = [
            heightAnchor,
            medicineTypeView.topAnchor.constraint(equalTo: medicineTypeLabel.bottomAnchor,constant: 0),
            medicineTypeView.leadingAnchor.constraint(equalTo: medicineTypeLabel.leadingAnchor),
            medicineTypeView.trailingAnchor.constraint(equalTo: medicineTypeLabel.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousMedicineConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPillCollectionView() {
        pillCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            pillCollectionView.isScrollEnabled = false
        }
        
        NSLayoutConstraint.activate([
            pillCollectionView.topAnchor.constraint(equalTo: medicineTypeView.topAnchor),
            pillCollectionView.leadingAnchor.constraint(equalTo: medicineTypeView.leadingAnchor),
            pillCollectionView.trailingAnchor.constraint(equalTo: medicineTypeView.trailingAnchor),
            pillCollectionView.bottomAnchor.constraint(equalTo: medicineTypeView.bottomAnchor)
        ])
    }
    
    func loadTimeAndScheduleView() {
        timeAndScheduleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeAndScheduleView.topAnchor.constraint(equalTo: medicineTypeView.bottomAnchor,constant: 0),
            timeAndScheduleView.leadingAnchor.constraint(equalTo: medicineTypeView.leadingAnchor),
            timeAndScheduleView.trailingAnchor.constraint(equalTo: medicineTypeView.trailingAnchor),
            timeAndScheduleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            timeAndScheduleView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -10)
        ])
    }
    
    func loadIntervalLabel() {
        intervalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        intervalLabel.text = "Medicine to be taken "
        
        NSLayoutConstraint.activate([
            intervalLabel.topAnchor.constraint(equalTo: timeAndScheduleView.topAnchor,constant: 12),
            intervalLabel.leadingAnchor.constraint(equalTo: timeAndScheduleView.leadingAnchor),
        ])
    }
    
    func loadScheduleSegmentedControl(){
        scheduleSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scheduleSegmentedControl.topAnchor.constraint(equalTo: timeAndScheduleView.topAnchor,constant: 10),
            scheduleSegmentedControl.trailingAnchor.constraint(equalTo: timeAndScheduleView.trailingAnchor)
        ])
    }
    
    func loadScheduleLabel() {
        scheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scheduleLabel.text = "Interval "
        
        NSLayoutConstraint.activate([
            scheduleLabel.topAnchor.constraint(equalTo: intervalLabel.bottomAnchor,constant: 12),
            scheduleLabel.leadingAnchor.constraint(equalTo: intervalLabel.leadingAnchor),
            scheduleLabel.trailingAnchor.constraint(equalTo: timeIntervalSegmentedControl.leadingAnchor)
        ])
    }
    
    func loadTimeIntervalSegmentedControl() {
        timeIntervalSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeIntervalSegmentedControl.topAnchor.constraint(equalTo: scheduleSegmentedControl.bottomAnchor,constant: 10),
            timeIntervalSegmentedControl.trailingAnchor.constraint(equalTo: timeAndScheduleView.trailingAnchor),
        ])
    }
    
    func loadDateTimeTableView() {
        dateTimeTableView.translatesAutoresizingMaskIntoConstraints = false
        
        dateTimeTableView.backgroundColor = view.backgroundColor
        
        var padding = CGFloat.zero
        var multiply = 0.0
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            multiply = 0.97
            
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                padding = ((view.frame.height - (multiply*view.frame.height))/2)
            }
            else {
                padding = ((view.frame.width - (multiply*view.frame.width))/2)
            }
            
            let constraints = [
                dateTimeTableView.topAnchor.constraint(equalTo: timeIntervalSegmentedControl.bottomAnchor, constant: 10),
                dateTimeTableView.leadingAnchor.constraint(equalTo: timeAndScheduleView.leadingAnchor, constant: -padding),
                dateTimeTableView.trailingAnchor.constraint(equalTo: timeAndScheduleView.trailingAnchor, constant: padding),
                dateTimeTableView.bottomAnchor.constraint(equalTo: timeAndScheduleView.bottomAnchor, constant: -10)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousMedicineConstraintsToDeActivate.append(constraint)
            }
            
            return
        }
        else{
            multiply = 0.9
            padding = ((view.frame.width - (multiply*view.frame.width))/2) - 5
        }
        
        let constraints = [
            dateTimeTableView.topAnchor.constraint(equalTo: timeIntervalSegmentedControl.bottomAnchor, constant: 10),
            dateTimeTableView.leadingAnchor.constraint(equalTo: timeAndScheduleView.leadingAnchor, constant: -padding),
            dateTimeTableView.trailingAnchor.constraint(equalTo: timeAndScheduleView.trailingAnchor, constant: padding),
            dateTimeTableView.bottomAnchor.constraint(equalTo: timeAndScheduleView.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousMedicineConstraintsToDeActivate.append(constraint)
        }
        
        dateTimeTableView.layer.cornerRadius = 10
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == self.view || toView == medicineNameLabel || toView == medicineTypeLabel) {
            tapGesture.addTarget(self, action: #selector(didTapToDismissKeyboard))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    func removeGestures() {
        guard let gestureRecogniser = self.view.gestureRecognizers?.first else {
            return
        }
        
        self.view.removeGestureRecognizer(gestureRecogniser)
    }
    
    @objc func didTapToDismissKeyboard(_ sender: UITapGestureRecognizer) {
        medicineNameField.resignFirstResponder()
    }
    
    func configureBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
    }
    
    @objc func didTapDone(_ sender: UIBarButtonItem){
        
        medicineNameField.resignFirstResponder()
        
        if(reminderDateAndTime.count != 0 && scheduleReminders()) {
            let completionMessage = UIAlertController(title: "Updation Details", message: "Reminder has been added successfully.", preferredStyle: .alert)
            completionMessage.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { (action) -> () in
                print("Done Tapped.")
                
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(completionMessage, animated: true)
        }
        else{
            self.present(incompleteCredentialAlertView, animated: true)
        }
    }
    
    func scheduleReminders() -> Bool {
        let beforeOrAfter = Schedule(rawValue: scheduleSegmentedControl.selectedSegmentIndex)!
        let mealTime = FoodInterval(rawValue: timeIntervalSegmentedControl.selectedSegmentIndex)!
        let medicineName = medicineNameField.text
        let medicineBody = "This is a gentle reminder for you to take \(medicineName ?? "") \(beforeOrAfter.scheduleName) \(mealTime.intervalName)"
        
        var reminder: Reminder!
        var reminderDate: Date!
        
        if(medicineName?.count != 0 && medicineBody.count != 0 && reminderDateAndTime.count != 0){
            
            for reminderDateAndTime in reminderDateAndTime {
                let date = reminderDateAndTime.date
                let time = reminderDateAndTime.time
                
                print("Date is : ",date)
                print("Time is : ",time)
                
                guard let foorIntervalToTakeMed = FoodInterval(rawValue: timeIntervalSegmentedControl.selectedSegmentIndex),
                      let scheduleToTakeMed = Schedule(rawValue: scheduleSegmentedControl.selectedSegmentIndex) else {
                    print("Reminder Entry Failed")
                    return false
                }
                
                reminder = Reminder(date: date,
                                    time: time,
                                    medicineName: medicineName!,
                                    medicineBody: medicineBody,
                                    medicineType: medicineType,
                                    foodIntervalToTake: foorIntervalToTakeMed,
                                    schedule: scheduleToTakeMed,
                                    userId: UserDefaults.standard.integer(forKey: "User - Id"))
                
                DBManager.sharedInstance.addRowToReminder(reminder)
            
                reminderDate = datePicker.date.addingTimeInterval(TimeInterval(((5 * 60) + 30)*60))
                
                print("Date from reminderDateAndTime : ",reminderDate)
                
                delegate?.updateReminderTable(forDate: date, medName: medicineName!)
                delegate?.completion(reminder: reminder)
            }
        }
        else{
            return false
        }
        
        return true
    }
    
    @objc func configureTextfieldDelegates(){
        medicineNameField.delegate = self
    }
    
    func updateSelectDateAndTimeLabel() {
        
        var text = ""
        var time = ""
        var reminderTime: ReminderDateAndTime = ReminderDateAndTime(date: "", time: "")
        
        if(reminderDateAndTime.count <= 0) {
            return
        }
        else{
            reminderTime = reminderDateAndTime[0]
        }
        
        if(reminderTime.time.count < 4) {
            return
        }
        else{
            let referenceReminder = reminderTime.time
            let timeRange = referenceReminder.index(referenceReminder.startIndex, offsetBy: 0)...referenceReminder.index(referenceReminder.startIndex, offsetBy: 4)
            
            time = "\(referenceReminder[timeRange])"
        }
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: reminderTime.date) else {
            return
        }
        
        formatter.dateFormat = "EEEE"
        
        guard let day = DoctorWeekSlotsAvailability(rawValue: formatter.string(from: date)) else {
            return
        }
        
        switch(selectedRepeatState){
        case .never:
            text = "Reminds only once at \(time) on \(reminderTime.date)"
        case .daily:
            text = "Reminds daily at \(time) upto a year"
        case .weekdays:
            text = "Reminds during weekdays at \(time) upto a year"
        case .weekends:
            text = "Reminds during weekends at \(time) upto a year"
        case .weekly:
            text = "Reminds only once at \(day.rawValue) \(time) every weak upto a year"
        case .biweekly:
            text = "Reminds only once at \(day.rawValue) \(time) once in two weaks upto a year"
        case .monthly:
            text = "Reminds only once at \(day.rawValue) \(time) every month upto a year"
        case .every2Months:
            text = "Reminds only once at \(day.rawValue) \(time) once in two months upto a year"
        case .every3Months:
            text = "Reminds only once at \(day.rawValue) \(time) once in three months upto a year"
        }
        
        selectDateAndTimeLabel?.text = text
        
        dateTimeTableView.reloadData()
    }
}

extension AddMedicineVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddMedicineVC: SelectDateAndTimeForReminderProtocol {
    func loadDateAndTime(for array: [ReminderDateAndTime], selectedRepeatState: ReminderRepeatPreference) {
        reminderDateAndTime = array
        self.selectedRepeatState = selectedRepeatState
        
        updateSelectDateAndTimeLabel()
    }
}

extension AddMedicineVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddmedicineVCTableViewCell.identifier, for: indexPath) as? AddmedicineVCTableViewCell else {
            return UITableViewCell()
        }
        
        selectDateAndTimeLabel = cell.label
        
        cell.backgroundColor = Theme.lightMode.subViewBackGroundColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectDateAndTimeVC = SelectDateAndTimeTableVC(style: .insetGrouped, selectedReminderRepeatPreference: selectedRepeatState)
        selectDateAndTimeVC.delegate = self
        
        let navSelectDateAndTimeVC = UINavigationController(rootViewController: selectDateAndTimeVC)
        
        self.present(navSelectDateAndTimeVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        lazy var label: ResizedLabel = {
            let label = ResizedLabel()
            
            label.numberOfLines = 1
            label.contentMode = .left
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 15, weight: .semibold)
            label.text = "Schedule Reminder"
            
            return label
        }()
        
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
        
        return view
    }
}

extension AddMedicineVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pillNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddMedicineCollectionViewCell.identifier, for: indexPath) as? AddMedicineCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = view.backgroundColor
        cell.imageName = pillNames[indexPath.row]
        
        cell.layer.cornerRadius = 10
        
        if(previouslySelectedCell == nil && indexPath.row == 0) {
            previouslySelectedCell = cell
            previouslySelectedCell?.isCellSelected(true)
        }
        else if (previouslySelectedCell != nil) {
            if(cell.imageName == previouslySelectedCell?.imageName) {
                previouslySelectedCell?.isCellSelected(false)
                previouslySelectedCell = cell
                previouslySelectedCell?.isCellSelected(true)
            }
        }
        else{
            cell.isCellSelected(false)
        }
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        medImageView.image = UIImage(named: pillNames[indexPath.row])
        medicineType = pillNames[indexPath.row]
        
        if(previouslySelectedCell != nil) {
            previouslySelectedCell?.isCellSelected(false)
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? AddMedicineCollectionViewCell else {
                return
            }
            
            previouslySelectedCell = cell
            previouslySelectedCell?.isCellSelected(true)
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension AddMedicineVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        medicineNameField.resignFirstResponder()
    }
}

extension NSDate {
    var localTime: String {
        return description(with: NSLocale.current)
    }
}
