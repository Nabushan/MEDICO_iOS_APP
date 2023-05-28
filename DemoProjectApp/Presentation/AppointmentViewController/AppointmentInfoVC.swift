//
//  AppointmentInfoVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 26/10/22.
//

import UIKit

class AppointmentInfoVC: UIViewController, AppointmentRequirmentProtocol {
    
    var consultation: ConsultationGetter?
    let appointmentInfoHelperVC: AppointmentInfoHelperVC?
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
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
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var designationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var addressLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var viewForProfile: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.isScrollEnabled = true
        
        return scrollView
    }()
    
    lazy var scheduleAppointmentLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var scheduleDate: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var scheduleTime: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var patientInformation: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var patientName: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var patientNameValue: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var gender: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var genderValue: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var age: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var ageValue: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var problem: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var problemValue: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.lineBreakMode = .byTruncatingTail
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var packageInformation: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var viewMoreButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("view more", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .light)
        
        return button
    }()
    
    lazy var viewForPackage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var viewForPackageImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var packageImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var packageTypeLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 3
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.lineBreakMode = .byTruncatingTail
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var packageInfoBelowLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 3
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.lineBreakMode = .byTruncatingTail
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .light)
        
        return label
    }()
    
    lazy var packageCostLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 3
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.lineBreakMode = .byTruncatingTail
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var packagePaidLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 3
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.lineBreakMode = .byTruncatingTail
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var markAsCompletedButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Mark as Completed", for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    lazy var cancelAppointmentButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Cancel Appointment", for: .normal)
        button.backgroundColor = .systemRed
        
        return button
    }()
    
    lazy var noAppointmentImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "No Appointment")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var noAppointmentHeader: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy var noAppointmentBody: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd MMM, yyyy HH:mm a"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        
        return formatter
    }()
    
    var isViewMoreTapped: Bool = false
    var shouldShowContents: Bool = true
    var isFromSearch: Bool = false
    var isFromPayment: Bool = false
    
    var delegateForSugue: SegueToParentProtocol?
    
    var completionAndCancellingDelegate: AppointmentMarkingCompletedAndCancellingProtocol?
    var viewMoreButtonConstraint: NSLayoutConstraint?
    var previousContraintsToDeActivate: [NSLayoutConstraint] = []
    
    init(consultation: ConsultationGetter, isFromPayment: Bool){
        self.consultation = consultation
        appointmentInfoHelperVC = AppointmentInfoHelperVC(doctorId: consultation.doctorId ?? 1)
        shouldShowContents = true
        self.isFromPayment = isFromPayment
        
        super.init(nibName: nil, bundle: nil)
        
        appointmentInfoHelperVC?.delegate = self
    }
    
    init(){

        appointmentInfoHelperVC = AppointmentInfoHelperVC()
        shouldShowContents = false
        isFromPayment = false
        
        super.init(nibName: nil, bundle: nil)
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            self.view.alpha = 0
        }
        self.navigationItem.hidesBackButton = true
        self.title = ""
    }
    
    init(isSearchActive: Bool){

        appointmentInfoHelperVC = AppointmentInfoHelperVC()
        shouldShowContents = false
        isFromSearch = isSearchActive
        
        super.init(nibName: nil, bundle: nil)
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            self.view.alpha = 0
        }
        self.navigationItem.hidesBackButton = true
        self.title = ""
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "Appointments"
        
        loadViews()
        
        loadComponents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousContraintsToDeActivate)
        previousContraintsToDeActivate = []
        
        loadComponents()
    }
    
    func loadViews() {
        view.addSubview(scrollView)
        
        if(shouldShowContents) {
            loadContentViews()
        }
        else{
            loadZeroContentViews()
        }
    }
    
    func loadComponents() {
        loadScrollView()
        if(shouldShowContents){
            loadContents()
        }
        else {
            loadZeroContents()
        }
    }
    
    func loadContentViews() {
        scrollView.addSubview(viewForProfile)
        viewForProfile.addSubview(profileImageView)
        viewForProfile.addSubview(nameLabel)
        viewForProfile.addSubview(lineView)
        viewForProfile.addSubview(designationLabel)
        viewForProfile.addSubview(addressLabel)
        scrollView.addSubview(scheduleAppointmentLabel)
        scrollView.addSubview(scheduleDate)
        scrollView.addSubview(scheduleTime)
        scrollView.addSubview(patientInformation)
        scrollView.addSubview(patientName)
        scrollView.addSubview(patientNameValue)
        scrollView.addSubview(gender)
        scrollView.addSubview(genderValue)
        scrollView.addSubview(age)
        scrollView.addSubview(ageValue)
        scrollView.addSubview(problem)
        scrollView.addSubview(problemValue)
        scrollView.addSubview(packageInformation)
        scrollView.addSubview(viewMoreButton)
        scrollView.addSubview(viewForPackage)
        viewForPackage.addSubview(viewForPackageImage)
        viewForPackageImage.addSubview(packageImageView)
        viewForPackage.addSubview(packageTypeLabel)
        viewForPackage.addSubview(packageInfoBelowLabel)
        viewForPackage.addSubview(packageCostLabel)
        viewForPackage.addSubview(packagePaidLabel)
        
        switch(consultation?.status){
        case .upcoming:
            scrollView.addSubview(markAsCompletedButton)
            scrollView.addSubview(cancelAppointmentButton)
        case .completed:
            scrollView.addSubview(markAsCompletedButton)
        case .cancelled:
            scrollView.addSubview(cancelAppointmentButton)
        default:
            ()
        }
    }
    
    func loadZeroContentViews() {
        scrollView.addSubview(noAppointmentImageView)
        scrollView.addSubview(noAppointmentHeader)
        scrollView.addSubview(noAppointmentBody)
    }
    
    func loadScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadContents() {
        loadViewForProfile()
        loadProfileImageView()
        loadNameLabel()
        loadLineView()
        loadDesignationLabel()
        loadAddressLabel()
        loadScheduleAppointmentLabel()
        loadScheduleDate()
        loadScheduleTime()
        loadPatientInformation()
        loadPatientNameLabel()
        loadPatientNameValueLabel()
        loadGenderLabel()
        loadGenderNameLabel()
        loadAgeLabel()
        loadAgeValueLabel()
        loadProblemLabel()
        loadProblemValueLabel()
        loadPackageInformation()
        loadViewMoreButton()
        loadViewForPackage()
        loadViewForPackageImage()
        loadPackageImageView()
        loadPackageTypeLabel()
        loadPackageInfoBelowLabel()
        loadPackageCostLabel()
        loadPackagePaidLabel()
        
        switch(consultation?.status){
        case .upcoming:
            loadMarkAsCompletedButton()
            loadCancelAppointmentButton()
        case .completed:
            loadMarkAsCompletedButton()
        case .cancelled:
            loadCancelAppointmentButton()
        default:
            ()
        }
    }
    
    func loadZeroContents() {
        loadNoAppointmentImageView()
        loadNoAppointmentHeader()
        loadNoAppointmentBody()
    }
    
    func loadNoAppointmentImageView() {
        noAppointmentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if(isFromSearch){
            noAppointmentImageView.image = UIImage(named: "No Search Result")
        }
        
        if(view.frame.height > 800){
            let constraints = [
                noAppointmentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
                noAppointmentImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                noAppointmentImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousContraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                noAppointmentImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                noAppointmentImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                noAppointmentImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousContraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadNoAppointmentHeader() {
        noAppointmentHeader.translatesAutoresizingMaskIntoConstraints = false
        
        if(isFromSearch){
            noAppointmentHeader.text = "We couldn't find what you searched for."
        }
        else{
            noAppointmentHeader.text = "You don't have an appointment yet."
        }
        
        let constraints = [
            noAppointmentHeader.bottomAnchor.constraint(equalTo: noAppointmentBody.topAnchor, constant: -5),
            noAppointmentHeader.leadingAnchor.constraint(equalTo: noAppointmentBody.leadingAnchor),
            noAppointmentHeader.trailingAnchor.constraint(equalTo: noAppointmentBody.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadNoAppointmentBody() {
        noAppointmentBody.translatesAutoresizingMaskIntoConstraints = false
        
        if(isFromSearch){
            noAppointmentBody.text = "Try searching again."
        }
        else{
            noAppointmentBody.text = "You don't have a doctor's appointment scheduled at the moment."
        }
        
        let constraints = [
            noAppointmentBody.bottomAnchor.constraint(equalTo: noAppointmentImageView.bottomAnchor, constant: -5),
            noAppointmentBody.leadingAnchor.constraint(equalTo: noAppointmentImageView.leadingAnchor),
            noAppointmentBody.trailingAnchor.constraint(equalTo: noAppointmentImageView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadViewForProfile() {
        viewForProfile.translatesAutoresizingMaskIntoConstraints = false
        
        viewForProfile.backgroundColor = Theme.lightMode.subViewBackGroundColor
        viewForProfile.layer.cornerRadius = 10
        
        let constraints = [
            viewForProfile.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            viewForProfile.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            viewForProfile.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
        
        if(view.frame.height > 800){
            let heightAchor = viewForProfile.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
            heightAchor.isActive = true
            
            previousContraintsToDeActivate.append(heightAchor)
        }
        else{
            let heightAnchor = viewForProfile.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
            heightAnchor.isActive = true
            
            previousContraintsToDeActivate.append(heightAnchor)
        }
    }
    
    func loadProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

        profileImageView.downloaded(from: appointmentInfoHelperVC?.doctorDetails.imageName ?? "")

        let constraints = [
            profileImageView.centerYAnchor.constraint(equalTo: viewForProfile.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: viewForProfile.leadingAnchor,constant: 10),
            profileImageView.widthAnchor.constraint(equalTo: viewForProfile.heightAnchor, multiplier: 0.85),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }

        profileImageView.layer.cornerRadius = 10
    }

    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.text = appointmentInfoHelperVC?.doctorDetails.name

        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: viewForProfile.topAnchor,constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: viewForProfile.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }

    func loadLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false

        lineView.backgroundColor = .systemGray5

        let constraints = [
            lineView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }

        lineView.layer.cornerRadius = 0.5
    }

    func loadDesignationLabel() {
        designationLabel.translatesAutoresizingMaskIntoConstraints = false

        designationLabel.text = appointmentInfoHelperVC?.doctorDetails.designation.specializationType

        let constraints = [
            designationLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            designationLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            designationLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }

    func loadAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false

        addressLabel.text = appointmentInfoHelperVC?.doctorDetails.locationAddress

        let constraints = [
            addressLabel.topAnchor.constraint(equalTo: designationLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: designationLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: designationLabel.trailingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: viewForProfile.bottomAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadScheduleAppointmentLabel() {
        scheduleAppointmentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        scheduleAppointmentLabel.text = "Scheduled Appointment"
        
        let constraints = [
            scheduleAppointmentLabel.topAnchor.constraint(equalTo: viewForProfile.bottomAnchor, constant: 10),
            scheduleAppointmentLabel.leadingAnchor.constraint(equalTo: viewForProfile.leadingAnchor),
            scheduleAppointmentLabel.trailingAnchor.constraint(equalTo: viewForProfile.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadScheduleDate() {
        scheduleDate.translatesAutoresizingMaskIntoConstraints = false
        
        scheduleDate.text = consultation?.consultationDate
        
        let constraints = [
            scheduleDate.topAnchor.constraint(equalTo: scheduleAppointmentLabel.bottomAnchor, constant: 5),
            scheduleDate.leadingAnchor.constraint(equalTo: scheduleAppointmentLabel.leadingAnchor),
            scheduleDate.trailingAnchor.constraint(equalTo: scheduleAppointmentLabel.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadScheduleTime() {
        scheduleTime.translatesAutoresizingMaskIntoConstraints = false
        
        guard let time = consultation?.consultationTime else{
            return
        }
        
        let amOrPm = time[time.index(time.endIndex, offsetBy: -2)...time.index(time.endIndex, offsetBy: -1)]
        
        let fromTime = time[time.index(time.startIndex, offsetBy: 0)...time.index(time.startIndex, offsetBy: 4)]
        
        var toTime = ""
        
        if(fromTime[fromTime.index(fromTime.endIndex, offsetBy: -2)...fromTime.index(fromTime.endIndex, offsetBy: -1)] == "00"){
            toTime = fromTime[fromTime.index(fromTime.startIndex, offsetBy: 0)...fromTime.index(fromTime.startIndex, offsetBy: 2)] + "30"
        }
        else{
            guard var val = Int(fromTime[fromTime.index(fromTime.startIndex, offsetBy: 0)...fromTime.index(fromTime.startIndex, offsetBy: 1)]) else {
                return
            }
            
            val+=1
            
            var stringVal = "\(val)"
            
            if(stringVal.count == 1){
                stringVal = "0" + stringVal
            }
            
            toTime = stringVal + ":00"
        }
        
        let finalTime = "\(fromTime) - \(toTime) \(amOrPm)"
        
        scheduleTime.text = finalTime
        
        let constraints = [
            scheduleTime.topAnchor.constraint(equalTo: scheduleDate.bottomAnchor, constant: 5),
            scheduleTime.leadingAnchor.constraint(equalTo: scheduleDate.leadingAnchor),
            scheduleTime.trailingAnchor.constraint(equalTo: scheduleDate.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPatientInformation() {
        patientInformation.translatesAutoresizingMaskIntoConstraints = false
        
        patientInformation.text = "Patient Information"
        
        let constraints = [
            patientInformation.topAnchor.constraint(equalTo: scheduleTime.bottomAnchor, constant: 5),
            patientInformation.leadingAnchor.constraint(equalTo: scheduleTime.leadingAnchor),
            patientInformation.trailingAnchor.constraint(equalTo: scheduleTime.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPatientNameLabel() {
        patientName.translatesAutoresizingMaskIntoConstraints = false
        
        patientName.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        patientName.text = "Full Name"
        
        let constraints = [
            patientName.topAnchor.constraint(equalTo: patientInformation.bottomAnchor, constant: 5),
            patientName.leadingAnchor.constraint(equalTo: patientInformation.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPatientNameValueLabel() {
        patientNameValue.translatesAutoresizingMaskIntoConstraints = false
        
        patientNameValue.text = ":  \(consultation?.patientName ?? "")"
        
        let constraints = [
            patientNameValue.topAnchor.constraint(equalTo: patientName.topAnchor),
            patientNameValue.leadingAnchor.constraint(equalTo: patientName.trailingAnchor),
            patientNameValue.trailingAnchor.constraint(equalTo: scheduleTime.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadGenderLabel() {
        gender.translatesAutoresizingMaskIntoConstraints = false
        
        gender.text = "Gender"
        
        let constraints = [
            gender.topAnchor.constraint(equalTo: patientName.bottomAnchor, constant: 5),
            gender.leadingAnchor.constraint(equalTo: patientName.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadGenderNameLabel() {
        genderValue.translatesAutoresizingMaskIntoConstraints = false
        
        genderValue.text = ":  \(consultation?.patientGender ?? "")"
        
        let constraints = [
            genderValue.topAnchor.constraint(equalTo: gender.topAnchor),
            genderValue.leadingAnchor.constraint(equalTo: patientNameValue.leadingAnchor),
            genderValue.trailingAnchor.constraint(equalTo: patientNameValue.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadAgeLabel() {
        age.translatesAutoresizingMaskIntoConstraints = false
        
        age.text = "Age"
        
        let constraints = [
            age.topAnchor.constraint(equalTo: gender.bottomAnchor, constant: 5),
            age.leadingAnchor.constraint(equalTo: gender.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadAgeValueLabel() {
        ageValue.translatesAutoresizingMaskIntoConstraints = false
        
        ageValue.text = ":  \(consultation?.patientAge ?? "")"
        
        let constraints = [
            ageValue.topAnchor.constraint(equalTo: age.topAnchor),
            ageValue.leadingAnchor.constraint(equalTo: genderValue.leadingAnchor),
            ageValue.trailingAnchor.constraint(equalTo: genderValue.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadProblemLabel() {
        problem.translatesAutoresizingMaskIntoConstraints = false
        
        problem.text = "Problem"
        
        let constraints = [
            problem.topAnchor.constraint(equalTo: age.bottomAnchor, constant: 5),
            problem.leadingAnchor.constraint(equalTo: age.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadProblemValueLabel() {
        problemValue.translatesAutoresizingMaskIntoConstraints = false
        
        problemValue.text = ": " + (consultation?.patientProblem ?? "")
        
        if(view.frame.height > 800) {
            problemValue.numberOfLines = 4
        }
        
        let constraints = [
            problemValue.topAnchor.constraint(equalTo: problem.topAnchor),
            problemValue.leadingAnchor.constraint(equalTo: genderValue.leadingAnchor),
            problemValue.trailingAnchor.constraint(equalTo: genderValue.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
        
        print(problemValue.isTruncated)
    }
    
    func loadPackageInformation() {
        packageInformation.translatesAutoresizingMaskIntoConstraints = false
        
        packageInformation.text = "Your Package"
        
        let constraints = [
            packageInformation.topAnchor.constraint(equalTo: problemValue.bottomAnchor, constant: 5),
            packageInformation.leadingAnchor.constraint(equalTo: problem.leadingAnchor),
            packageInformation.trailingAnchor.constraint(equalTo: problemValue.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadViewMoreButton() {
        viewMoreButton.translatesAutoresizingMaskIntoConstraints = false

        viewMoreButton.backgroundColor = view.backgroundColor
        viewMoreButton.alpha = 0
        
        print("The number of line is \(problemValue.countLines()), is truncated \(problemValue.isTruncated)")
        
        if(problemValue.countLines() > 2){
            viewMoreButton.addTarget(self, action: #selector(didTapViewMore), for: .touchUpInside)
            viewMoreButton.alpha = 1
        }
        
        viewMoreButtonConstraint = viewMoreButton.bottomAnchor.constraint(equalTo: problemValue.bottomAnchor, constant: -5)
        
        let constraints = [
            viewMoreButton.trailingAnchor.constraint(equalTo: problemValue.trailingAnchor),
            viewMoreButtonConstraint!,
            viewMoreButton.heightAnchor.constraint(equalToConstant: viewMoreButton.intrinsicContentSize.height - 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    @objc func didTapViewMore(_ sender: UIButton){
        isViewMoreTapped = !isViewMoreTapped
        
        if(isViewMoreTapped){
            viewMoreButtonConstraint?.isActive = false
            viewMoreButtonConstraint = viewMoreButton.topAnchor.constraint(equalTo: problemValue.bottomAnchor, constant: 0)
            viewMoreButtonConstraint?.isActive = true
            problemValue.numberOfLines = 0
            viewMoreButton.setTitle("view less", for: .normal)
        }
        else{
            problemValue.numberOfLines = 2
            viewMoreButton.setTitle("view more", for: .normal)
            viewMoreButtonConstraint?.isActive = false
            viewMoreButtonConstraint = viewMoreButton.bottomAnchor.constraint(equalTo: problemValue.bottomAnchor, constant: -5)
            viewMoreButtonConstraint?.isActive = true
        }
    }
    
    func loadViewForPackage() {
        viewForPackage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForPackage.backgroundColor = .secondarySystemBackground
        viewForPackage.layer.cornerRadius = 10
        
        let constraints = [
            viewForPackage.topAnchor.constraint(equalTo: packageInformation.bottomAnchor, constant: 5),
            viewForPackage.leadingAnchor.constraint(equalTo: packageInformation.leadingAnchor),
            viewForPackage.trailingAnchor.constraint(equalTo: packageInformation.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
        
        if(view.frame.height > 800){
            let heightAnchor = viewForPackage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
            heightAnchor.isActive = true
            
            previousContraintsToDeActivate.append(heightAnchor)
        }
        else{
            let heightAnchor = viewForPackage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12)
            heightAnchor.isActive = true
            
            previousContraintsToDeActivate.append(heightAnchor)
        }
    }
    
    func loadViewForPackageImage() {
        viewForPackageImage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForPackageImage.backgroundColor = .systemBackground
        
        let constraints = [
            viewForPackageImage.centerYAnchor.constraint(equalTo: viewForPackage.centerYAnchor),
            viewForPackageImage.heightAnchor.constraint(equalTo: viewForPackage.heightAnchor, multiplier: 0.7),
            viewForPackageImage.widthAnchor.constraint(equalTo: viewForPackageImage.heightAnchor),
            viewForPackageImage.leadingAnchor.constraint(equalTo: viewForPackage.leadingAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
        
        if(view.frame.height > 800){
            viewForPackageImage.layer.cornerRadius = (0.7*0.1*view.frame.height)/2
        }
        else{
            viewForPackageImage.layer.cornerRadius = (0.7*0.12*view.frame.height)/2
        }
    }
    
    func loadPackageImageView() {
        packageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if(consultation?.packageInfomation == .videoConsultation){
            packageImageView.image = UIImage(systemName: "video.bubble.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
            
        }
        else{
            packageImageView.image = UIImage(systemName: "building")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
        }
        
        packageImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let constraints = [
            packageImageView.centerYAnchor.constraint(equalTo: viewForPackageImage.centerYAnchor),
            packageImageView.centerXAnchor.constraint(equalTo: viewForPackageImage.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPackageTypeLabel() {
        packageTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        packageTypeLabel.text = consultation?.packageInfomation?.consultationType
        
        let constraints = [
            packageTypeLabel.centerYAnchor.constraint(equalTo: viewForPackage.centerYAnchor, constant: -10),
            packageTypeLabel.leadingAnchor.constraint(equalTo: viewForPackageImage.trailingAnchor, constant: 15),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPackageInfoBelowLabel() {
        packageInfoBelowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if(consultation?.packageInfomation == .videoConsultation){
            packageInfoBelowLabel.text = "Video call with the Doctor"
        }
        else{
            packageInfoBelowLabel.text = "Meet the Doctor"
        }
        
        let constraints = [
            packageInfoBelowLabel.centerYAnchor.constraint(equalTo: viewForPackage.centerYAnchor, constant: 10),
            packageInfoBelowLabel.leadingAnchor.constraint(equalTo: packageTypeLabel.leadingAnchor),
            packageInfoBelowLabel.trailingAnchor.constraint(equalTo: packagePaidLabel.leadingAnchor, constant: -5)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPackageCostLabel() {
        packageCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        packageCostLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        packageCostLabel.text = consultation?.cost
        
        let constraints = [
            packageCostLabel.topAnchor.constraint(equalTo: packageTypeLabel.topAnchor),
            packageCostLabel.trailingAnchor.constraint(equalTo: viewForPackage.trailingAnchor, constant: -15),
            packageCostLabel.leadingAnchor.constraint(equalTo: packageTypeLabel.trailingAnchor, constant: 5)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPackagePaidLabel() {
        packagePaidLabel.translatesAutoresizingMaskIntoConstraints = false
        
        packagePaidLabel.text = "(paid)"
        
        let constraints = [
            packagePaidLabel.centerYAnchor.constraint(equalTo: packageInfoBelowLabel.centerYAnchor),
            packagePaidLabel.trailingAnchor.constraint(equalTo: packageCostLabel.trailingAnchor),
            packagePaidLabel.leadingAnchor.constraint(equalTo: packageCostLabel.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMarkAsCompletedButton() {
        markAsCompletedButton.translatesAutoresizingMaskIntoConstraints = false
        
        markAsCompletedButton.backgroundColor = .systemBlue
        
        let constraints = [
            markAsCompletedButton.topAnchor.constraint(equalTo: viewForPackage.bottomAnchor,constant: 10),
            markAsCompletedButton.leadingAnchor.constraint(equalTo: viewForPackage.leadingAnchor),
            markAsCompletedButton.trailingAnchor.constraint(equalTo: viewForPackage.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousContraintsToDeActivate.append(constraint)
        }
        
        switch(consultation?.status){
        case .completed:
            let bottomAnchor = markAsCompletedButton.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -15)
            bottomAnchor.isActive = true
            
            previousContraintsToDeActivate.append(bottomAnchor)
            
            markAsCompletedButton.setTitle("Marked as Completed", for: .normal)
            markAsCompletedButton.backgroundColor = .systemGray4
            markAsCompletedButton.isHidden = true
            
        case .upcoming:
            markAsCompletedButton.addTarget(self, action: #selector(markAsCompleted), for: .touchUpInside)
            
        default:
            ()
        }
        
        markAsCompletedButton.layer.cornerRadius = markAsCompletedButton.intrinsicContentSize.height / 2
    }
    
    func loadCancelAppointmentButton() {
        cancelAppointmentButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelAppointmentButton.layer.cornerRadius = cancelAppointmentButton.intrinsicContentSize.height / 2
        
        switch(consultation?.status){
        case .cancelled:
            let constraints = [
                cancelAppointmentButton.topAnchor.constraint(equalTo: viewForPackage.bottomAnchor, constant: 10),
                cancelAppointmentButton.leadingAnchor.constraint(equalTo: viewForPackage.leadingAnchor),
                cancelAppointmentButton.trailingAnchor.constraint(equalTo: viewForPackage.trailingAnchor),
                cancelAppointmentButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousContraintsToDeActivate.append(constraint)
            }
            
            cancelAppointmentButton.setTitle("Appointment Cancelled", for: .normal)
            cancelAppointmentButton.backgroundColor = .systemGray4
            cancelAppointmentButton.isHidden = true
        default:
            cancelAppointmentButton.addTarget(self, action: #selector(cancelAppointment), for: .touchUpInside)
            
            let constraints = [
                cancelAppointmentButton.topAnchor.constraint(equalTo: markAsCompletedButton.bottomAnchor, constant: 5),
                cancelAppointmentButton.leadingAnchor.constraint(equalTo: markAsCompletedButton.leadingAnchor),
                cancelAppointmentButton.trailingAnchor.constraint(equalTo: markAsCompletedButton.trailingAnchor),
                cancelAppointmentButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousContraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func shouldShowPrompt() -> Bool {
        let dateAndTime = formatter.string(from: Date.now)
        
        let scheduledDate = scheduleDate.text ?? ""
        let scheduledTime = scheduleTime.text ?? ""
        
        let scheduledTimeSplits = scheduledTime.split(separator: " ")
        
        let scheduledTimeMode = scheduledTimeSplits[scheduledTimeSplits.count-1]
        
        let formedDateString = scheduledDate + " " + scheduledTimeSplits[0]+" "+scheduledTimeSplits[scheduledTimeSplits.count-1]
        
        print(dateAndTime)
        print(formedDateString)
        print(formatter.string(from: Date.now))
        
        guard let currentDate = formatter.date(from: dateAndTime),
              let formedDate = formatter.date(from: formedDateString) else {
            return false
        }
        
        if(currentDate > formedDate){
            return false
        }
        
        return true
    }
    
    @objc func markAsCompleted(_ sender: UIButton) {
        print("Marking Appointment as Completed")
        
        let alertController = UIAlertController(title: "Mark As Completed", message: "Are you sure, to mark this appointment as completed.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        alertController.addAction(UIAlertAction(title: "Mark As Completed", style: .cancel){ _ in
            self.markAsCompletedButton.setTitle("Marked as Completed", for: .normal)
            self.markAsCompletedButton.backgroundColor = .systemGray4
            self.cancelAppointmentButton.alpha = 0
            
            guard let consultation = self.consultation else {
                return
            }
            
            self.markAsCompletedButton.removeTarget(self, action: #selector(self.markAsCompleted), for: .touchUpInside)
            
            self.appointmentInfoHelperVC?.updateState(to: .completed, for: consultation)
            
            self.completionAndCancellingDelegate?.fetchAndReloadCollectionView()
        })
        
        if(shouldShowPrompt()){
            present(alertController, animated: true)
        }
        else{
            self.markAsCompletedButton.setTitle("Marked as Completed", for: .normal)
            self.markAsCompletedButton.backgroundColor = .systemGray4
            self.cancelAppointmentButton.alpha = 0
            
            guard let consultation = self.consultation else {
                return
            }

            self.markAsCompletedButton.removeTarget(self, action: #selector(self.markAsCompleted), for: .touchUpInside)

            self.appointmentInfoHelperVC?.updateState(to: .completed, for: consultation)

            self.completionAndCancellingDelegate?.fetchAndReloadCollectionView()
        }
    }
    
    @objc func cancelAppointment(_ sender: UIButton) {
        print("Cancelling Appointment")
        
        guard let consultation = consultation else {
            return
        }
        
        let cancelAppointmentVC = CancelAppointmentConfirmationVC(consultation)
        cancelAppointmentVC.delegate = self
        
        present(cancelAppointmentVC, animated: true)
    }
}

extension AppointmentInfoVC: AppointmentCancellingProtocol {
    func confirmCancelAppointment(_ consultation: ConsultationGetter) {
        markAsCompletedButton.removeTarget(self, action: #selector(markAsCompleted), for: .touchUpInside)
        markAsCompletedButton.setTitle("Appointment Cancelled", for: .normal)
        markAsCompletedButton.backgroundColor = .systemGray4
        cancelAppointmentButton.alpha = 0
        
        appointmentInfoHelperVC?.updateState(to: .cancelled, for: consultation)
        
        completionAndCancellingDelegate?.fetchAndReloadCollectionView()
    }
    
    func showCancelReason(_ consultation: ConsultationGetter) {
        let changeAppointmentVC = ChangeAppointmentVC(consultation, shouldCancel: true, isFromPayment: isFromPayment)
        
        changeAppointmentVC.delegate = self
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad && !isFromPayment){
            splitViewController?.showDetailViewController(changeAppointmentVC, sender: self)
        }
        else{
            let delegate = delegateForSugue
            delegateForSugue = nil
            navigationController?.pushViewController(changeAppointmentVC, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.delegateForSugue = delegate
            }
        }
    }
}

extension AppointmentInfoVC {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let delegate = delegateForSugue {
            delegate.segueToParent()
        }
    }
}
