//
//  BookAppointmentVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 14/10/22.
//

import UIKit

class BookAppointmentVC: UIViewController {

    var doctorDetails: Doctor?
    
    lazy var selectDateLabel: ResizedLabel = {
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
    
    let calendar = Calendar.current
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.sizeToFit()
        datePicker.minimumDate = Date.now
        
        var dateComponent = DateComponents()
        dateComponent.day = 30
        
        datePicker.maximumDate = calendar.date(byAdding: dateComponent, to: Date.now)
        datePicker.clipsToBounds = true
        datePicker.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        return datePicker
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "d MMM, yyyy"
        
        return formatter
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutProvider.getHourLayout())
        
        collectionView.register(BookAppointmentHourCollectionViewCell.self, forCellWithReuseIdentifier: BookAppointmentHourCollectionViewCell.identifier)
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    lazy var noSlotsAvailableLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        label.text = "No Slots Available"
        
        return label
    }()
    
    let layoutProvider = CollectionViewLayoutProvider()
    
    lazy var selectHourLabel: ResizedLabel = {
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
    
    lazy var nextButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = button.intrinsicContentSize.height/2
        
        return button
    }()
    
    var previouslySelectedCell: BookAppointmentHourCollectionViewCell?
    var previouslySelectedTiming: String = ""
    var reviewSummary: ReviewSummary?
    var consultation: ConsultationGetter?
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    var isFormConsultation: Bool = false
    var bookAppointmentHelperVC: BookAppointmentHelperVC?
    
    var packageType: ConsultationPackageType?
    
    var date = Date.now
    var calender = Calendar.current
    
    init(doctorDetails: Doctor, packageType: ConsultationPackageType) {
        self.doctorDetails = doctorDetails
        self.packageType = packageType
        
        var amount = 0.0
        
        switch(packageType){
        case .videoConsultation:
            amount = Double(doctorDetails.vedioConsultationCost)
        case .hospitalVisit:
            amount = Double(doctorDetails.hospitalVisitCost)
        }
        
        self.bookAppointmentHelperVC = BookAppointmentHelperVC()
        
        reviewSummary = ReviewSummary(
            doctorId: doctorDetails.id,
            docImage: doctorDetails.imageName,
            docName: doctorDetails.name,
            docDesignation: doctorDetails.designation,
            docAddress: doctorDetails.locationAddress,
            package: packageType.consultationType,
            duration: "30 min",
            amount: amount,
            date: nil,
            hourSlot: nil,
            selectedCardType: nil)

        super.init(nibName: nil, bundle: nil)
    }
    
    init(_ consultation: ConsultationGetter){
        isFormConsultation = true
        self.consultation = consultation
        self.packageType = consultation.packageInfomation
        self.bookAppointmentHelperVC = BookAppointmentHelperVC()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        view.addSubview(selectDateLabel)
        view.addSubview(datePicker)
        view.addSubview(selectHourLabel)
        view.addSubview(collectionView)
        view.addSubview(noSlotsAvailableLabel)
        view.addSubview(nextButton)
        
        configureDelegates()
        loadComponents()
    }
    
    func configureDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        collectionView.collectionViewLayout = layoutProvider.getHourLayout()
        
        loadComponents()
        collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        collectionView.collectionViewLayout = layoutProvider.getHourLayout()
        
        loadComponents()
        collectionView.reloadData()
    }
    
    func loadComponents() {
        loadDataRequirments(forDate: date)
        loadSelectDateLabel()
        loadDatePicker()
        loadSelectHourLabel()
        loadCollectionView()
        loadNoSlotsAvailableLabel()
        loadNextButton()
    }
    
    func restoreDateFormatterFormat() {
        formatter.dateFormat = "d MMM, yyyy"
    }
    
    func loadDataRequirments(forDate: Date) {
        
        var id = -1
        var name = ""
        
        if(isFormConsultation) {
            id = consultation?.doctorId ?? -1
            name = consultation?.doctorName ?? ""
        }
        else {
            id = doctorDetails?.id ?? -1
            name = doctorDetails?.name ?? ""
        }
        
        formatter.dateFormat = "EEEE"
        
        let todayString = formatter.string(from: forDate)
        
        guard let packageType = packageType,
              let today = DoctorWeekSlotsAvailability(rawValue: todayString) else {
            return
        }
        
        
        bookAppointmentHelperVC?.loadData(packageType: packageType, doctorId: id, doctorName: name, forDay: today)
        
        restoreDateFormatterFormat()
    }
    
    func loadSelectDateLabel() {
        selectDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        selectDateLabel.text = "Select Date"
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                selectDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                selectDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.1*view.frame.width),
                selectDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0.1*view.frame.width)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            var leftPadding = 0
            
            if(view.frame.height > 800) {
                leftPadding = 15
            }
            else{
                leftPadding = 15
            }
            
            let constraints = [
                selectDateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                selectDateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: CGFloat(leftPadding)),
                selectDateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.layer.cornerRadius = 25
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: selectDateLabel.bottomAnchor, constant: 5),
            datePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.41),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        if(view.frame.height > 800){
            datePicker.widthAnchor.constraint(equalTo: datePicker.heightAnchor, multiplier: 1.1).isActive = true
        }
        else{
            datePicker.widthAnchor.constraint(equalTo: datePicker.heightAnchor, multiplier: 1.2).isActive = true
        }
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        loadDataRequirments(forDate: sender.date)
        
        previouslySelectedCell?.isCellSelected(false)
        previouslySelectedCell = nil
        collectionView.reloadData()
    }
    
    func loadSelectHourLabel(){
        selectHourLabel.translatesAutoresizingMaskIntoConstraints = false
        
        selectHourLabel.text = "Select Hour"
        
        NSLayoutConstraint.activate([
            selectHourLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 5),
            selectHourLabel.leadingAnchor.constraint(equalTo: selectDateLabel.leadingAnchor),
            selectHourLabel.trailingAnchor.constraint(equalTo: selectDateLabel.trailingAnchor),
        ])
    }
    
    func loadCollectionView(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: selectHourLabel.bottomAnchor, constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: selectHourLabel.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: selectHourLabel.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10),
        ])
    }
    
    func loadNoSlotsAvailableLabel() {
        noSlotsAvailableLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noSlotsAvailableLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            noSlotsAvailableLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
    }
    
    func loadNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        let window = UIApplication.shared.keyWindow
        
        var bottomPadding = CGFloat.zero
        
        if let value = window?.safeAreaInsets.bottom, value != .zero {
            bottomPadding = value
        }
        else{
            bottomPadding = 10
        }
        
        let constraints = [
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomPadding)),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        if(view.frame.height > 800){
            let heightAnchor = nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065)
            heightAnchor.isActive = true
            
            previousConstraintsToDeActivate.append(heightAnchor)
            nextButton.layer.cornerRadius = 10
        }
        
        nextButton.layer.cornerRadius = 10
        
        if(isFormConsultation){
            nextButton.setTitle("Submit", for: .normal)
        }
    }
    
    @objc func didTapNextButton(_ sender: UIButton){
        print("nextButton tapped")
        
        formatter.dateFormat = "d MMM, yyyy"
        
        print("selected Date: ", formatter.string(from: datePicker.date))
        print("selected Time Slot: ", previouslySelectedCell?.timeLabel.text ?? "")
        
        if(isFormConsultation){
            let date = formatter.string(from: datePicker.date)
            guard let hourSlot = previouslySelectedCell?.timeLabel.text,
                  let consultation = consultation else {
                return
            }
            
            bookAppointmentHelperVC?.updateConsutation(date: date, time: hourSlot, for: consultation)
            
            consultation.consultationDate = date
            consultation.consultationTime = hourSlot
            
            let successVC = SuccessResultVC(isSuccess: true, resultTitle: "Rescheduling Success!", message: "Appointment successfully changed. You will recieve a notification and the doctor you selected will constact you.", consultation: consultation, isFromPayments: true)
            
            successVC.delegateForSegue = self
            
            let navSuccessVC = UINavigationController(rootViewController: successVC)
            
            self.present(navSuccessVC, animated: true)
            
        }
        else{
            reviewSummary?.date = formatter.string(from: datePicker.date)
            reviewSummary?.hourSlot = previouslySelectedCell?.timeLabel.text ?? ""
            
            if(reviewSummary?.hourSlot?.count == 0){
                let alertViewController = UIAlertController(title: "Insufficient Details", message: "Please make sure that you've selected the Respective Slot.", preferredStyle: .alert)
                
                if(bookAppointmentHelperVC?.hours.count == 0 || bookAppointmentHelperVC?.tabHours.count == 0) {
                    alertViewController.title = "No Slots Avaialble"
                    alertViewController.message = "Please select some other date since there are no slots available for this selected date."
                }
                
                alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
                
                present(alertViewController, animated: true)
            }
            else{
                
                guard let reviewSummary = reviewSummary else {
                    return
                }
                
                let patientDetailsVC = BookAppointmentPatientDetailsVC(reviewSummary: reviewSummary)
                
                navigationController?.pushViewController(patientDetailsVC, animated: true)
            }
        }
    }
}

extension BookAppointmentVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        var section = 0
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            section = bookAppointmentHelperVC?.tabHours.count ?? 0
        }
        else{
            section = bookAppointmentHelperVC?.hours.count ?? 0
        }
         
        if(section == 0) {
            noSlotsAvailableLabel.alpha = 1
        }
        else{
            noSlotsAvailableLabel.alpha = 0
        }
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            return bookAppointmentHelperVC?.tabHours[section].count ?? 0
        }
        return bookAppointmentHelperVC?.hours[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookAppointmentHourCollectionViewCell.identifier, for: indexPath) as? BookAppointmentHourCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = view.backgroundColor
        
        cell.layer.cornerRadius = cell.frame.height/2
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            
            guard let tabHours = bookAppointmentHelperVC?.tabHours else {
                return UICollectionViewCell()
            }
            
            if(indexPath.section < tabHours.count && indexPath.row < tabHours[0].count) {
                cell.timeLabel.text = tabHours[indexPath.section][indexPath.row]
            }
        }
        else{
            
            guard let hours = bookAppointmentHelperVC?.hours else {
                return UICollectionViewCell()
            }
            
            if(indexPath.section < hours.count && indexPath.row < hours[0].count) {
                cell.timeLabel.text = hours[indexPath.section][indexPath.row]
            }
        }
        
        guard let time = cell.timeLabel.text else {
            return cell
        }
        
        formatter.dateFormat = "yyyy-dd-MM"
        
        let today = formatter.string(from: Date.now)
        let selectedDate = formatter.string(from: datePicker.date)
        
        if(today == selectedDate) {
            var currentTime = ""
            
            if(calendar.component(.hour, from: date) < 10) {
                currentTime = "0\(calender.component(.hour, from: date)):\(calender.component(.minute, from: date))"
                
                if(calendar.component(.minute, from: date) < 10) {
                    currentTime = "0\(calender.component(.hour, from: date)):0\(calender.component(.minute, from: date))"
                }
            }
            else{
                currentTime = "\(calender.component(.hour, from: date)):\(calender.component(.minute, from: date))"
                if(calendar.component(.minute, from: date) < 10) {
                    currentTime = "\(calender.component(.hour, from: date)):0\(calender.component(.minute, from: date))"
                }
            }
            
            print("Stored Time : ",time[time.index(time.startIndex, offsetBy: 0)...time.index(time.startIndex, offsetBy: 4)])
            print("Current Time : ",currentTime)
            
            if(time[time.index(time.startIndex, offsetBy: 0)...time.index(time.startIndex, offsetBy: 4)] <= currentTime) {
                cell.isCellDisabled = true
            }
        }
        
        if(previouslySelectedTiming == cell.timeLabel.text! && !cell.isCellDisabled){
            cell.isCellSelected(true)
            previouslySelectedCell = cell
        }
        
        cell.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        cell.layer.borderWidth = 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(previouslySelectedCell == nil){
            previouslySelectedCell = collectionView.cellForItem(at: indexPath) as? BookAppointmentHourCollectionViewCell
            
            if(previouslySelectedCell?.isCellDisabled ?? false){
                previouslySelectedCell = nil
                return
            }
            previouslySelectedCell?.isCellSelected(true)
        }
        else{
            let cell = collectionView.cellForItem(at: indexPath) as? BookAppointmentHourCollectionViewCell
            
            if(cell?.isCellDisabled ?? false) {
                previouslySelectedCell?.isCellSelected(false)
                previouslySelectedCell = nil
                return
            }
            previouslySelectedCell?.isCellSelected(false)
            
            previouslySelectedCell = cell
            previouslySelectedCell?.isCellSelected(true)
        }
        
        guard let timing = previouslySelectedCell?.timeLabel.text else {
            return
        }
        
        previouslySelectedTiming = timing
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension BookAppointmentVC: SegueToParentProtocol {
    func segueToParent() {
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_StarRating_Updated"), object: nil)
        guard let vc = self.navigationController?.viewControllers.filter({$0 is AppointmentsListVC}).first else {
            return
        }
        
        self.navigationController?.popToViewController(vc, animated: true)
    }
}

extension BookAppointmentVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
    }
}
