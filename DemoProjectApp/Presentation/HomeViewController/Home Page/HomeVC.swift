//
//  HomeVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/09/22.
//

import UIKit
import UserNotifications
import Network

class HomeVC: UIViewController, HomeVCDelegate {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.isScrollEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .always
        
        return scrollView
    }()
    
    var nameView: UIView!
    
    var customisedCollectionView: UIView!
    
    var reminderView: UIView!
    
    var medicalArticleView: UIView!
    
    lazy var medicalArticleEmptyImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.image = UIImage(named: "No data")?.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        return imageView
    }()
    
    lazy var medicalArticleEmptyLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = false
        label.font = UIFont(name: "Helvetica", size: 15)
        
        label.text = "Please check your Internet Connection Again."
        
        return label
    }()
    
    var labTestView: UIView!
    
    var greetingLabel: ResizedLabel!
    
    lazy var reminderLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = false
        label.font = UIFont(name: "Helvetica", size: 15)
        
        label.text = "Please check your Internet Connection Again."
        
        return label
    }()
    
    lazy var addMedicineButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    lazy var refreshMedicineButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    lazy var viewForProfile: UIView = {
        let view = UIView()
        
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var profileView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var profileEditLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .white
        label.backgroundColor = .black
        label.numberOfLines = 1
        label.contentMode = .top
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = false
        label.font = UIFont(name: "Helvetica", size: 13)
        
        label.text = "Edit"
        
        return label
    }()
    
    var dayLabel: ResizedLabel!
    
    var nowLabel: ResizedLabel!
    
    var zeroReminderLabel: ResizedLabel!
    
    var noRemindersImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "No Reminders")?.withTintColor(.label, renderingMode: .alwaysOriginal))
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var reminderTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        
        table.register(HomeViewTableViewCell.self,
                       forCellReuseIdentifier: HomeViewTableViewCell.identifier)
        table.layer.cornerRadius = 10
        
        return table
    }()
    
    lazy var customCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayoutProvider().getCollectionViewCustomisedLayout())
        
        collectionView.register(CustomisedCollectionViewCell.self, forCellWithReuseIdentifier: CustomisedCollectionViewCell.identifier)
        
        collectionView.register(SectionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: SectionHeaderCollectionReusableView.identifier)
        
        return collectionView
    }()
    
    lazy var imagePickerView = UIImagePickerController()
    
    var consultationBookingLabel: ResizedLabel!
    var labTestBookingLabel: ResizedLabel!
    
    let themeColor: UIColor = UIColor(red: 50/255, green: 130/255, blue: 255/255, alpha: 1)
    
    let colors: [UIColor] = [
        .systemBlue,
        UIColor(red: 5/255, green: 196/255, blue: 229/255, alpha: 1),
        UIColor(red: 194/255, green: 220/255, blue: 129/255, alpha: 1),
        UIColor(red: 150/255, green: 155/255, blue: 167/255, alpha: 1),
    ]
    
    lazy var medicalArticleCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayoutProvider.getArticleCollectionViewLayout())
        
        collectionView.register(MedicalArticleCollectionViewCell.self, forCellWithReuseIdentifier: MedicalArticleCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        formatter.timeZone = TimeZone.current
        
        return formatter
    }()
    
    var articleView: UIView!
    var articleLabel: ResizedLabel!
    
    let collectionViewLayoutProvider = CollectionViewLayoutProvider()
    
    lazy var homeVCHelper = HomeVCHelper()
    
    var previouslySelectedConstraintsToDeActivate: [NSLayoutConstraint] = []
    var previouslySelectedCustomisedCollectionViewCell: CustomisedCollectionViewCell?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(isProfileImageChaged),
                                               name: NSNotification.Name("Profile-ImageChange-From-ProfileVC"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(isUserNameChanged), name: NSNotification.Name("Profile-UserName-Changed-From-ProfileInfoValueChangeVC"), object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name("Profile-ImageChange-From-ProfileVC"),
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Profile-UserName-Changed-From-ProfileInfoValueChangeVC"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        self.title = "Home"
        
        nameView = getView()
        customisedCollectionView = getView()
        reminderView = getView()
        medicalArticleView = getView()
        labTestView = getView()
        articleView = getView()
        
        greetingLabel = getLabel()
        dayLabel = getLabel()
        nowLabel = getLabel()
        reminderLabel = getLabel()
        consultationBookingLabel = getLabel()
        labTestBookingLabel = getLabel()
        zeroReminderLabel = getLabel()
        articleLabel = getLabel()
                
        view.addSubview(scrollView)
        
        scrollView.addSubview(nameView)
        nameView.addSubview(greetingLabel)
        nameView.addSubview(viewForProfile)
        viewForProfile.addSubview(profileView)
        viewForProfile.addSubview(profileEditLabel)
        nameView.addSubview(dayLabel)
        
        scrollView.addSubview(customisedCollectionView)
        customisedCollectionView.addSubview(customCollectionView)
    
        scrollView.addSubview(reminderLabel)
        scrollView.addSubview(addMedicineButton)
        scrollView.addSubview(refreshMedicineButton)
        scrollView.addSubview(reminderView)
        reminderView.addSubview(reminderTableView)
        reminderView.addSubview(zeroReminderLabel)
        reminderView.addSubview(noRemindersImageView)
        
        scrollView.addSubview(articleView)
        articleView.addSubview(articleLabel)
        
        scrollView.addSubview(medicalArticleView)
        medicalArticleView.addSubview(medicalArticleEmptyImageView)
        medicalArticleView.addSubview(medicalArticleEmptyLabel)
        medicalArticleView.addSubview(medicalArticleCollectionView)
        
        medicalArticleCollectionView.collectionViewLayout = collectionViewLayoutProvider.getArticleCollectionViewLayout()
        
        loadScrollView()
        loadComponents()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            viewForProfile.layer.cornerRadius = (0.1*view.frame.height)/2
        }
        else {
            viewForProfile.layer.cornerRadius = (0.09*view.frame.height)/2
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previouslySelectedConstraintsToDeActivate)
        medicalArticleCollectionView.collectionViewLayout = collectionViewLayoutProvider.getArticleCollectionViewLayout()
        loadComponents()
        medicalArticleCollectionView.reloadData()
    }
    
    func loadComponents() {
        configureImagePicker()
        configureHomeVCDelegate()

        loadNameView()
        loadViewForProfileView()
        loadProfileView()
        loadProfileEditLabel()
        loadDayLabel()
        loadGreetingLabel()

        loadCustomisedCollectionView()
        configureCollectionView()
        loadCollectionView()

        loadReminderLabel()
        loadAddMedicineButton()
        loadRefreshMedicineButton()
        loadReminderView()
//        loadReminderLabel()
        loadNoRemindersImageView()
        loadZeroReminderLabel()
        configureTableView()
        loadReminderTableView()

        loadArticleView()
        loadArticleLabel()

        loadMedicalArticleView()
        loadMedicalArticleEmptyImageView()
        loadMedicalArticleEmptyLabel()
        loadMedicalArticleCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            NSLayoutConstraint.deactivate(previouslySelectedConstraintsToDeActivate)
            previouslySelectedConstraintsToDeActivate = []
            
            medicalArticleCollectionView.collectionViewLayout = collectionViewLayoutProvider.getArticleCollectionViewLayout()
            loadComponents()
            medicalArticleCollectionView.reloadData()
        }
        else{
            NSLayoutConstraint.deactivate(previouslySelectedConstraintsToDeActivate)
            previouslySelectedConstraintsToDeActivate = []
            
            medicalArticleCollectionView.collectionViewLayout = collectionViewLayoutProvider.getArticleCollectionViewLayout()
            loadComponents()
            medicalArticleCollectionView.reloadData()
        }
    }
    
    func getView() -> UIView {
        let view: UIView = {
            let view = UIView()
            
            return view
        }()
        
        return view
    }
    
    func getLabel() -> ResizedLabel {
        let label: ResizedLabel = {
            let label = ResizedLabel()
            
            label.textColor = .label
            label.numberOfLines = 1
            label.contentMode = .left
            label.textAlignment = .center
            label.clipsToBounds = true
            label.layer.masksToBounds = true
            label.adjustsFontSizeToFitWidth = true
            label.isUserInteractionEnabled = false
            
            return label
        }()
        
        return label
    }
    
    func configureHomeVCDelegate() {
        homeVCHelper.delegate = self
    }
    
    func configureImagePicker() {
        imagePickerView.delegate = self
        imagePickerView.sourceType = .photoLibrary
        imagePickerView.allowsEditing = true
    }
    
    func addTapGesture(toView: UIView){
        var tapGesture: UITapGestureRecognizer!
        
        if (toView == viewForProfile) {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        }
        else if (toView == reminderView) {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapReminderView))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func isProfileImageChaged(_ sender: Notification){
        guard let userInfo = sender.userInfo as? [String: UIImage],
              let image = userInfo["selected-Image"]  else {
            return
        }
        
        profileView.image = image
    }
    
    @objc func isUserNameChanged(_ sender: Notification) {
        greetingLabel.text = "Hi, \(UserDefaults.standard.string(forKey: "User - Name") ?? "")"
    }
    
    @objc func didTapProfileImage(_ sender: UITapGestureRecognizer){
        present(imagePickerView, animated: true)
    }
    
    @objc func didTapReminderView(_ sender: UITapGestureRecognizer) {
        homeVCHelper.updateMedicineStates()
        
        navigationController?.pushViewController(RemiderListVC(style: .insetGrouped), animated: true)
        self.tabBarController?.tabBar.isHidden = true
        print("Reminder View Tapped")
    }
    
    func getChevronRightImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
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
    
    func loadGreetingLabel() {
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        greetingLabel.text = "Hi, \(UserDefaults.standard.string(forKey: "User - Name") ?? "")"
        greetingLabel.textAlignment = .left
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            greetingLabel.font = UIFont(name: "Helvetica", size: 25)
            
            let constraints = [
                greetingLabel.topAnchor.constraint(equalTo: nameView.topAnchor,constant: 20),
                greetingLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor,constant: 10),
                greetingLabel.trailingAnchor.constraint(equalTo: profileView.leadingAnchor,constant: -10)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            greetingLabel.font = UIFont(name: "Helvetica", size: 25)
            
            greetingLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            greetingLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            
            let constraints = [
                greetingLabel.topAnchor.constraint(equalTo: nameView.topAnchor,constant: 10),
                greetingLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor,constant: 15),
                greetingLabel.trailingAnchor.constraint(equalTo: profileView.leadingAnchor,constant: -5)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadViewForProfileView() {
        viewForProfile.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                viewForProfile.topAnchor.constraint(equalTo: nameView.topAnchor,constant: view.frame.height * 0.015),
                viewForProfile.trailingAnchor.constraint(equalTo: nameView.trailingAnchor,constant: -15),
                viewForProfile.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
                viewForProfile.widthAnchor.constraint(equalTo: profileView.heightAnchor, multiplier: 1)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
            
            viewForProfile.layer.cornerRadius = (0.1*view.frame.height)/2
        }
        else{
            if(view.frame.width < 400){
                let constraints = [
                    viewForProfile.topAnchor.constraint(equalTo: nameView.topAnchor,constant: 5),
                    viewForProfile.trailingAnchor.constraint(equalTo: nameView.trailingAnchor,constant: -15),
                    viewForProfile.heightAnchor.constraint(equalToConstant: 0.1*view.frame.height),
                    viewForProfile.widthAnchor.constraint(equalToConstant: 0.1*view.frame.height)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previouslySelectedConstraintsToDeActivate.append(constraint)
                }
                
                viewForProfile.layer.cornerRadius = (0.1*view.frame.height)/2
            }
            else{
                let constraints = [
                    viewForProfile.topAnchor.constraint(equalTo: nameView.topAnchor,constant: 5),
                    viewForProfile.trailingAnchor.constraint(equalTo: nameView.trailingAnchor,constant: -15),
                    viewForProfile.heightAnchor.constraint(equalToConstant: 0.09*view.frame.height),
                    viewForProfile.widthAnchor.constraint(equalToConstant: 0.09*view.frame.height)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previouslySelectedConstraintsToDeActivate.append(constraint)
                }
                
                viewForProfile.layer.cornerRadius = (0.09*view.frame.height)/2
            }
        }
        
        addTapGesture(toView: viewForProfile)
    }
    
    func loadProfileView() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UserDefaults.standard.image(forKey: "User Selected Image" + "-\(UserDefaults.standard.integer(forKey: "User - Id"))"){
            profileView.image = image
        }
        else{
            profileView.image = UserDefaults.standard.image(forKey: "Default Image")
        }
        
        let constraints = [
            profileView.heightAnchor.constraint(equalTo: viewForProfile.heightAnchor),
            profileView.widthAnchor.constraint(equalTo: viewForProfile.widthAnchor),
            profileView.centerYAnchor.constraint(equalTo: viewForProfile.centerYAnchor),
            profileView.centerXAnchor.constraint(equalTo: viewForProfile.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previouslySelectedConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadProfileEditLabel() {
        profileEditLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            profileEditLabel.widthAnchor.constraint(equalTo: viewForProfile.widthAnchor),
            profileEditLabel.centerXAnchor.constraint(equalTo: viewForProfile.centerXAnchor),
            profileEditLabel.bottomAnchor.constraint(equalTo: viewForProfile.bottomAnchor, constant: 5)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previouslySelectedConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadDayLabel() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dayLabel.textAlignment = .left
        dayLabel.textColor = .label
        
        dayLabel.text = formatter.string(from: Date.now)
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            dayLabel.font = UIFont(name: "Helvetica", size: 15)
            let constraints = [
                dayLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor,constant: 0),
                dayLabel.bottomAnchor.constraint(equalTo: nameView.bottomAnchor,constant: 0),
                dayLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor,constant: 15),
                dayLabel.trailingAnchor.constraint(equalTo: profileView.leadingAnchor,constant: -5)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
        else if(view.frame.width < 400){
            dayLabel.font = UIFont(name: "Helvetica", size: 15)
            
            let constraints = [
                dayLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor,constant: 0),
                dayLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor,constant: 15),
                dayLabel.trailingAnchor.constraint(equalTo: profileView.leadingAnchor,constant: -5)
            ]
                                        
            NSLayoutConstraint.activate(constraints)
                                        
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            dayLabel.font = UIFont(name: "Helvetica", size: 15)
            
            let constraints = [
                dayLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor,constant: 0),
                dayLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor,constant: 15),
                dayLabel.trailingAnchor.constraint(equalTo: profileView.leadingAnchor,constant: -5)
            ]
            
            NSLayoutConstraint.activate(constraints)
                                        
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadNameView() {
        nameView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            
            var height = CGFloat.zero
            
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                height = 0.125*UIScreen.main.bounds.width
            }
            else {
                height = 0.125*UIScreen.main.bounds.height
            }
            
            let constraints = [
                nameView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 10),
                nameView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                nameView.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8),
                nameView.heightAnchor.constraint(equalToConstant: height),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                nameView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 10),
                nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
                nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
                nameView.heightAnchor.constraint(equalToConstant: 0.1*view.frame.height),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadCustomisedCollectionView() {
        customisedCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        customisedCollectionView.backgroundColor = .systemRed
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            let constraints = [
                customisedCollectionView.topAnchor.constraint(equalTo: nameView.bottomAnchor,constant: 5),
                customisedCollectionView.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
                customisedCollectionView.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
                customisedCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
            return
        }
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            print(view.frame.width * 0.7)
            let constraints = [
                customisedCollectionView.topAnchor.constraint(equalTo: nameView.bottomAnchor,constant: 5),
                customisedCollectionView.leadingAnchor.constraint(equalTo: nameView.leadingAnchor),
                customisedCollectionView.trailingAnchor.constraint(equalTo: nameView.trailingAnchor),
                customisedCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            if(view.frame.width < 800 && view.frame.height > 800){
                let constraints = [
                    customisedCollectionView.topAnchor.constraint(equalTo: nameView.bottomAnchor,constant: 5),
                    customisedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
                    customisedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
                    customisedCollectionView.heightAnchor.constraint(equalToConstant: 0.6*view.frame.height)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previouslySelectedConstraintsToDeActivate.append(constraint)
                }
            }
            else{
                let constraints = [
                    customisedCollectionView.topAnchor.constraint(equalTo: nameView.bottomAnchor,constant: 5),
                    customisedCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
                    customisedCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
                    customisedCollectionView.heightAnchor.constraint(equalToConstant: 0.7*view.frame.height)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previouslySelectedConstraintsToDeActivate.append(constraint)
                }
            }
        }
    }
    
    func loadCollectionView() {
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customCollectionView.topAnchor.constraint(equalTo: customisedCollectionView.topAnchor),
            customCollectionView.leadingAnchor.constraint(equalTo: customisedCollectionView.leadingAnchor),
            customCollectionView.trailingAnchor.constraint(equalTo: customisedCollectionView.trailingAnchor),
            customCollectionView.bottomAnchor.constraint(equalTo: customisedCollectionView.bottomAnchor),
        ])
    }
    
    func loadZeroReminderLabel() {
        zeroReminderLabel.translatesAutoresizingMaskIntoConstraints = false
        zeroReminderLabel.text = "No more reminders set."
        
        if(homeVCHelper.reminderMedicines.count != 0){
            zeroReminderLabel.alpha = 0
        }
        else{
            zeroReminderLabel.alpha = 1
        }
        
        zeroReminderLabel.font = UIFont(name: "Helvetica", size: 15)
        zeroReminderLabel.textColor = .label
        
        NSLayoutConstraint.activate([
            zeroReminderLabel.centerXAnchor.constraint(equalTo: reminderView.centerXAnchor),
            zeroReminderLabel.topAnchor.constraint(equalTo: noRemindersImageView.bottomAnchor, constant: 5)
        ])
    }
    
    func loadNoRemindersImageView() {
        noRemindersImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if(homeVCHelper.reminderMedicines.count != 0){
            noRemindersImageView.alpha = 0
        }
        else{
            noRemindersImageView.alpha = 1
        }
        
        NSLayoutConstraint.activate([
            noRemindersImageView.centerXAnchor.constraint(equalTo: reminderView.centerXAnchor),
            noRemindersImageView.centerYAnchor.constraint(equalTo: reminderView.centerYAnchor, constant: -15),
            noRemindersImageView.heightAnchor.constraint(equalToConstant: 70),
            noRemindersImageView.widthAnchor.constraint(equalTo: noRemindersImageView.heightAnchor)
        ])
    }
    
    func configureTableView() {
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        reminderTableView.separatorInset = UIEdgeInsets(top: 0,
                                                        left: 5,
                                                        bottom: 0,
                                                        right: 5)
        reminderTableView.separatorStyle = .none
    }
    
    func configureCollectionView() {
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
        medicalArticleCollectionView.delegate = self
        medicalArticleCollectionView.dataSource = self
        
        customCollectionView.backgroundColor = view.backgroundColor
    }
    
    func loadReminderLabel() {
        reminderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        reminderLabel.text = "Reminders"
        reminderLabel.alpha = 1
        reminderLabel.font = UIFont(name: "Helvetica", size: 25)
        
        reminderLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            reminderLabel.topAnchor.constraint(equalTo: customisedCollectionView.bottomAnchor, constant: -5),
            reminderLabel.leadingAnchor.constraint(equalTo: customisedCollectionView.leadingAnchor, constant: 15)
        ])
    }
    
    func loadAddMedicineButton() {
        addMedicineButton.translatesAutoresizingMaskIntoConstraints = false
        
        addMedicineButton.addTarget(self, action: #selector(didTapAddMedicinesToReminderButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addMedicineButton.trailingAnchor.constraint(equalTo: customisedCollectionView.trailingAnchor, constant: -10),
            addMedicineButton.topAnchor.constraint(equalTo: reminderLabel.topAnchor),
            addMedicineButton.bottomAnchor.constraint(equalTo: reminderLabel.bottomAnchor),
            addMedicineButton.widthAnchor.constraint(equalTo: addMedicineButton.heightAnchor)
        ])
    }
    
    func loadRefreshMedicineButton() {
        refreshMedicineButton.translatesAutoresizingMaskIntoConstraints = false
        
        refreshMedicineButton.addTarget(self, action: #selector(didTapRefreshMedicineTableViewButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            refreshMedicineButton.topAnchor.constraint(equalTo: addMedicineButton.topAnchor),
            refreshMedicineButton.bottomAnchor.constraint(equalTo: addMedicineButton.bottomAnchor),
            refreshMedicineButton.widthAnchor.constraint(equalTo: addMedicineButton.widthAnchor),
            refreshMedicineButton.trailingAnchor.constraint(equalTo: addMedicineButton.leadingAnchor, constant: 0)
        ])
    }
    
    func loadReminderTableView() {
        reminderTableView.translatesAutoresizingMaskIntoConstraints = false
        
        reminderTableView.backgroundColor = .secondarySystemGroupedBackground
        
        NSLayoutConstraint.activate([
            reminderTableView.topAnchor.constraint(equalTo: reminderView.topAnchor),
            reminderTableView.leadingAnchor.constraint(equalTo: reminderView.leadingAnchor),
            reminderTableView.trailingAnchor.constraint(equalTo: reminderView.trailingAnchor),
            reminderTableView.bottomAnchor.constraint(equalTo: reminderView.bottomAnchor),
        ])
    }
    
    func loadReminderView() {
        reminderView.translatesAutoresizingMaskIntoConstraints = false
        
        addTapGesture(toView: reminderView)
        
        if(UIDevice.current.orientation == .landscapeRight || UIDevice.current.orientation == .landscapeLeft) {
            let constraints = [
                reminderView.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 15),
                reminderView.trailingAnchor.constraint(equalTo: customisedCollectionView.trailingAnchor),
                reminderView.leadingAnchor.constraint(equalTo: customisedCollectionView.leadingAnchor),
                reminderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
            return
        }
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            
            let constraints = [
                reminderView.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 15),
                reminderView.trailingAnchor.constraint(equalTo: customisedCollectionView.trailingAnchor),
                reminderView.leadingAnchor.constraint(equalTo: customisedCollectionView.leadingAnchor),
                reminderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            if(view.frame.width > 800){
                let constraints = [
                    reminderView.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 15),
                    reminderView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 0.07*view.frame.width),
                    reminderView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -0.07*view.frame.width),
                    reminderView.heightAnchor.constraint(equalToConstant: 0.3*view.frame.height)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previouslySelectedConstraintsToDeActivate.append(constraint)
                }
            }
            else{
                let constraints = [
                    reminderView.topAnchor.constraint(equalTo: reminderLabel.bottomAnchor, constant: 15),
                    reminderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    reminderView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
                    reminderView.heightAnchor.constraint(equalToConstant: 0.3*view.frame.height)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previouslySelectedConstraintsToDeActivate.append(constraint)
                }
            }
            
        }
        
        reminderView.layer.cornerRadius = 10
        
        reminderView.backgroundColor = .secondarySystemGroupedBackground
        
    }
    
    func loadArticleView() {
        articleView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                articleView.topAnchor.constraint(equalTo: reminderView.bottomAnchor,constant: 10),
                articleView.leadingAnchor.constraint(equalTo: reminderView.leadingAnchor),
                articleView.trailingAnchor.constraint(equalTo: reminderView.trailingAnchor),
                articleView.heightAnchor.constraint(equalToConstant: 0.05*view.frame.height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                articleView.topAnchor.constraint(equalTo: reminderView.bottomAnchor,constant: 10),
                articleView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                articleView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                articleView.heightAnchor.constraint(equalToConstant: 0.05*view.frame.height)
            ]
                
            NSLayoutConstraint.activate(constraints)
                
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadArticleLabel() {
        articleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        articleLabel.text = "Today's Health News"
        articleLabel.textAlignment = .left
        
        articleLabel.font = UIFont(name: "Helvetica", size: 25)
        
        NSLayoutConstraint.activate([
            articleLabel.centerYAnchor.constraint(equalTo: articleView.centerYAnchor),
            articleLabel.leadingAnchor.constraint(equalTo: articleView.leadingAnchor,constant: 15)
        ])
    }
    
    func loadMedicalArticleView() {
        medicalArticleView.translatesAutoresizingMaskIntoConstraints = false
        
        medicalArticleView.backgroundColor = .clear
        
        var shadowWidth: CGFloat
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                medicalArticleView.topAnchor.constraint(equalTo: articleView.bottomAnchor,constant: 10),
                medicalArticleView.leadingAnchor.constraint(equalTo: articleView.leadingAnchor),
                medicalArticleView.trailingAnchor.constraint(equalTo: articleView.trailingAnchor),
                medicalArticleView.heightAnchor.constraint(equalToConstant: 0.3*view.frame.height),
                medicalArticleView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -50)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
            
            shadowWidth = CGFloat(articleView.frame.width)
        }
        else{
            let constraints = [
                medicalArticleView.topAnchor.constraint(equalTo: articleView.bottomAnchor,constant: 10),
                medicalArticleView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
                medicalArticleView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
                medicalArticleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
                medicalArticleView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -50)
                
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraintsToDeActivate.append(constraint)
            }
            
            shadowWidth = CGFloat(view.frame.width - 40)
        }
    }
    
    func loadMedicalArticleEmptyImageView() {
        medicalArticleEmptyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            medicalArticleEmptyImageView.centerXAnchor.constraint(equalTo: medicalArticleView.centerXAnchor),
            medicalArticleEmptyImageView.centerYAnchor.constraint(equalTo: medicalArticleView.centerYAnchor, constant: -15),
            medicalArticleEmptyImageView.heightAnchor.constraint(equalToConstant: 70),
            medicalArticleEmptyImageView.widthAnchor.constraint(equalTo: medicalArticleEmptyImageView.heightAnchor)
        ])
    }
    
    func loadMedicalArticleEmptyLabel() {
        medicalArticleEmptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            medicalArticleEmptyLabel.topAnchor.constraint(equalTo: medicalArticleEmptyImageView.bottomAnchor, constant: 10),
            medicalArticleEmptyLabel.leadingAnchor.constraint(equalTo: medicalArticleView.leadingAnchor),
            medicalArticleEmptyLabel.trailingAnchor.constraint(equalTo: medicalArticleView.trailingAnchor)
        ])
    }
    
    func loadMedicalArticleCollectionView() {
        medicalArticleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        medicalArticleCollectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            medicalArticleCollectionView.topAnchor.constraint(equalTo: medicalArticleView.topAnchor),
            medicalArticleCollectionView.leadingAnchor.constraint(equalTo: medicalArticleView.leadingAnchor),
            medicalArticleCollectionView.trailingAnchor.constraint(equalTo: medicalArticleView.trailingAnchor),
            medicalArticleCollectionView.bottomAnchor.constraint(equalTo: medicalArticleView.bottomAnchor),
        ])
    }
    
    @objc func didTapAddMedicinesToReminderButton(_ sender: UIButton){
        let addMedVC = AddMedicineVC()
        
        addMedVC.delegate = homeVCHelper
        
        navigationController?.pushViewController(addMedVC, animated: true)
        
    }
    
    @objc func didTapRefreshMedicineTableViewButton(_ sender: UIButton) {
        print("Refresh medicines tapped")
        reloadReminderTableView()
    }
    
    func reloadReminderTableView() {
        homeVCHelper.fetchCurrentReminderMedicines()
        reminderTableView.reloadData()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(homeVCHelper.reminderMedicines.count > 0){
            zeroReminderLabel.text = ""
            noRemindersImageView.alpha = 0
        }
        else if(homeVCHelper.reminderMedicines.count == 0){
            zeroReminderLabel.text = "No Reminders set for Today."
            noRemindersImageView.alpha = 1
        }
        
        return homeVCHelper.reminderMedicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier, for: indexPath) as? HomeViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.reminder = homeVCHelper.reminderMedicines[indexPath.row]
        
        if(indexPath.row == 0){
            homeVCHelper.startTimeForReminderTable = cell.reminder.time
        }
        cell.previousTime = homeVCHelper.startTimeForReminderTable
        cell.backgroundColor = view.backgroundColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(collectionView == medicalArticleCollectionView){
            return 1
        }
        else if(collectionView == customCollectionView){
            return 2
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == customCollectionView){
            if(section == 0){
                return homeVCHelper.medicalSolution.count
            }
            return homeVCHelper.specialists.count
        }
        else if(collectionView == medicalArticleCollectionView){
            
            let count = homeVCHelper.medArticleData.count
            
            if(count == 0){
                medicalArticleEmptyImageView.alpha = 1
                medicalArticleEmptyLabel.alpha = 1
                medicalArticleView.backgroundColor = reminderView.backgroundColor
                medicalArticleView.layer.cornerRadius = reminderView.layer.cornerRadius
            }
            else{
                medicalArticleEmptyImageView.alpha = 0
                medicalArticleEmptyLabel.alpha = 0
                medicalArticleView.backgroundColor = .clear
            }
            
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == customCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomisedCollectionViewCell.identifier, for: indexPath) as? CustomisedCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if(indexPath.section == 0){
                cell.medicalSolutionContainer = homeVCHelper.medicalSolution[indexPath.row]
            }
            else{
                cell.specialistsContainer = homeVCHelper.specialists[indexPath.row]
            }
            
            if(indexPath.section == 0){
                if(indexPath.row == 0){
                    
                    previouslySelectedCustomisedCollectionViewCell = cell
                    previouslySelectedCustomisedCollectionViewCell?.isCellSelected(true)
                }
                else{
                    cell.isCellSelected(false)
                }
            }
            else{
                let index = indexPath.row % colors.count
                cell.backgroundColor = colors[index]
                
                cell.imageView.tintColor = .white
                cell.label.textColor = .white
            }

            cell.layer.cornerRadius = 10
            
            if(view.frame.width > 800){
                cell.label.font = UIFont(name: "Helvetica", size: 25)
            }
            
            return cell
        }
        else if (collectionView == medicalArticleCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicalArticleCollectionViewCell.identifier, for: indexPath) as? MedicalArticleCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            cell.backgroundColor = .secondarySystemGroupedBackground
            cell.article = homeVCHelper.medArticleData[indexPath.row]
            cell.contentView.layer.cornerRadius = 20
            
            cell.layer.shadowColor = UIColor.label.cgColor
                    
            cell.layer.cornerRadius = 5
            cell.layer.shadowOffset = CGSize(width: 0, height: 0.0)
            cell.layer.shadowRadius = 0.5
            cell.layer.shadowOpacity = 0.1
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            print(homeVCHelper.medArticleData[indexPath.row].description)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if(collectionView == medicalArticleCollectionView){
            let vc = MedicalNewsVC()
            
            modalPresentationStyle = .fullScreen
            vc.article = homeVCHelper.medArticleData[indexPath.row]
            
            present(vc, animated: true)
        }
        else if(collectionView == customCollectionView){
            if(indexPath.section == 0){
                var viewController: UIViewController?
                
                guard let cell = collectionView.cellForItem(at: indexPath) as? CustomisedCollectionViewCell,
                      let _ = previouslySelectedCustomisedCollectionViewCell else {
                    return
                }
                
                previouslySelectedCustomisedCollectionViewCell?.isCellSelected(false)
                previouslySelectedCustomisedCollectionViewCell = cell
                previouslySelectedCustomisedCollectionViewCell?.isCellSelected(true)
                
                switch(indexPath.row){
                case 0:
                    self.tabBarController?.tabBar.isHidden = true
                    viewController = DoctorsListVC(selectedState: .all)
                case 1:
                    self.tabBarController?.tabBar.isHidden = true
                    viewController = HospitalsListVC()
                case 2:
                    scrollView.setContentOffset(CGPoint(x: 0, y: customCollectionView.contentSize.height), animated: true)
                case 3:
                    self.tabBarController?.tabBar.isHidden = true
                    viewController = EmergencyVC()
                case 4:
                    self.tabBarController?.tabBar.isHidden = true
                    homeVCHelper.updateMedicineStates()
                    
                    viewController = RemiderListVC(style: .insetGrouped)
                    
                case 5:
                    self.tabBarController?.tabBar.isHidden = true
                    viewController = PharmacyListVC()
                default:
                    ()
                }
                
                guard let viewController = viewController else {
                    return
                }
                
                navigationController?.pushViewController(viewController, animated: true)
            }
            else {
                self.tabBarController?.tabBar.isHidden = true
                var selectedState: DoctorSpecialization?
                switch(indexPath.row){
                case 0:
                    selectedState = .cardiologist
                case 1:
                    selectedState = .nephrologist
                case 2:
                    selectedState = .immunologists
                case 3:
                    selectedState = .gastroenterologist
                case 4:
                    selectedState = .dentist
                case 5:
                    selectedState = .neurologist
                case 6:
                    selectedState = .orthopaedics
                case 7:
                    selectedState = .dermatologist
                case 8:
                    selectedState = .trichologist
                case 9:
                    selectedState = .gynacologist
                default:
                    selectedState = .all
                }
                
                let vc = DoctorsListVC(selectedState: selectedState ?? .all)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if(kind == "header"){
            guard let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderCollectionReusableView.identifier,
                for: indexPath) as? SectionHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            if(indexPath.section == 0){
                if(collectionView == customCollectionView){
                    view.sectionHeading = "Find Your Medical Solution!"
                }
                
                view.fontSize = 25
            }
            else {
                view.sectionHeading = "Specialists"
                view.fontSize = 25
            }
            
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(collectionView == medicalArticleCollectionView){
            if(indexPath.row == homeVCHelper.medArticleData.count - 1){
                homeVCHelper.fetchData(forUrl: homeVCHelper.apiUrl)
            }
        }
    }
}

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else{
            return
        }
        
        UserDefaults.standard.setImage(image, forKey: "User Selected Image" + "-\(UserDefaults.standard.integer(forKey: "User - Id"))")
        
        profileView.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name("Profile-ImageChange-From-HomeVC"),
                                        object: nil,
                                        userInfo: ["selected-Image" : profileView.image as Any])
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension HomeVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.backgroundColor = .secondarySystemGroupedBackground
        navigationItem.largeTitleDisplayMode = .always
        
        reloadReminderTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
}
