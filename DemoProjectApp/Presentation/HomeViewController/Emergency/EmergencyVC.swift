//
//  EmergencyVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 03/10/22.
//

import UIKit
import MessageUI

class EmergencyVC: UIViewController, EmergencyProtocol {

    lazy var profileAndLocationView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var firstAidImage:  UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    lazy var completeYourProfileLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    lazy var emergencyHelpLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()
    
    lazy var emergencyInfoLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    lazy var ambulanceImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var viewForImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var notSureLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    lazy var subjectLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var viewForCollectionView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var emergencyColletionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayoutProvider().getEmergencyLayout())
        
        collectionView.register(EmergencyCollectionViewCell.self, forCellWithReuseIdentifier: EmergencyCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let emergencyVCHelper: EmergencyVCHelper
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    init() {
        emergencyVCHelper = EmergencyVCHelper()
        
        super.init(nibName: nil, bundle: nil)
        
        emergencyVCHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "Emergency"
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(profileAndLocationView)
        profileAndLocationView.addSubview(firstAidImage)
        profileAndLocationView.addSubview(completeYourProfileLabel)
        
        scrollView.addSubview(emergencyHelpLabel)
        scrollView.addSubview(emergencyInfoLabel)
        scrollView.addSubview(viewForImage)
        
        viewForImage.addSubview(ambulanceImageView)
        
        scrollView.addSubview(notSureLabel)
        scrollView.addSubview(subjectLabel)
        scrollView.addSubview(viewForCollectionView)
        
        viewForCollectionView.addSubview(emergencyColletionView)
        
        configureDelegates()
        loadScrollView()
        loadContents()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewForImage.layer.cornerRadius = viewForImage.frame.width/2
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        loadContents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        loadContents()
    }
    
    func loadContents() {
        loadProfileAndLocationView()
        loadFirstAidImage()
        loadCompleteYourProfileLabel()
        loadEmergencyHelpLabel()
        loadEmergencyInfoLabel()
        loadImageForView()
        loadAmbulanceImageView()
        loadNotSureLabel()
        loadSubjectLabel()
        loadViewForCollectionView()
        loadCollectionView()
    }
    
    func configureDelegates() {
        emergencyColletionView.delegate = self
        emergencyColletionView.dataSource = self
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
    
    func loadProfileAndLocationView() {
        profileAndLocationView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let constraints = [
            profileAndLocationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
            profileAndLocationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15),
            profileAndLocationView.heightAnchor.constraint(equalToConstant: 0.07*view.frame.height),
            profileAndLocationView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadFirstAidImage() {
        firstAidImage.translatesAutoresizingMaskIntoConstraints = false
        
        firstAidImage.downloaded(from: "https://findicons.com/files/icons/1700/2d/512/first_aid.png")
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                firstAidImage.heightAnchor.constraint(equalTo: profileAndLocationView.heightAnchor, multiplier: 0.5),
                firstAidImage.widthAnchor.constraint(equalTo: firstAidImage.heightAnchor),
                firstAidImage.centerYAnchor.constraint(equalTo: profileAndLocationView.centerYAnchor),
                firstAidImage.trailingAnchor.constraint(equalTo: completeYourProfileLabel.leadingAnchor, constant: -5)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                firstAidImage.heightAnchor.constraint(equalTo: profileAndLocationView.heightAnchor, multiplier: 0.5),
                firstAidImage.widthAnchor.constraint(equalTo: firstAidImage.heightAnchor),
                firstAidImage.centerYAnchor.constraint(equalTo: profileAndLocationView.centerYAnchor),
                firstAidImage.trailingAnchor.constraint(equalTo: completeYourProfileLabel.leadingAnchor, constant: -5)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        
        firstAidImage.layer.cornerRadius = 10
    }
    
    func loadCompleteYourProfileLabel() {
        completeYourProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        
        completeYourProfileLabel.text = "Complete emergency profile"
        
        completeYourProfileLabel.textColor = .systemBlue
        
        addTapGesture(toView: completeYourProfileLabel)
        
        let constraints = [
            completeYourProfileLabel.centerXAnchor.constraint(equalTo: profileAndLocationView.centerXAnchor, constant: 10),
            completeYourProfileLabel.centerYAnchor.constraint(equalTo: profileAndLocationView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadEmergencyHelpLabel() {
        emergencyHelpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emergencyHelpLabel.text = "Emergency Help Needed?"
        
        let constraints = [
            emergencyHelpLabel.topAnchor.constraint(equalTo: profileAndLocationView.bottomAnchor,constant: 5),
            emergencyHelpLabel.leadingAnchor.constraint(equalTo: profileAndLocationView.leadingAnchor),
            emergencyHelpLabel.trailingAnchor.constraint(equalTo: profileAndLocationView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadEmergencyInfoLabel() {
        emergencyInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emergencyInfoLabel.text = "Double tap the button to call the Ambulance"
        
        let constraints = [
            emergencyInfoLabel.topAnchor.constraint(equalTo: emergencyHelpLabel.bottomAnchor,constant: 5),
            emergencyInfoLabel.leadingAnchor.constraint(equalTo: emergencyHelpLabel.leadingAnchor),
            emergencyInfoLabel.trailingAnchor.constraint(equalTo: emergencyHelpLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadImageForView() {
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForImage.backgroundColor = .systemRed
        
        var width: CGFloat = 0
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            width = 0.6*view.frame.width
            let constraints = [
                viewForImage.heightAnchor.constraint(equalTo: viewForImage.widthAnchor),
                viewForImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                viewForImage.topAnchor.constraint(equalTo: emergencyInfoLabel.bottomAnchor,constant: 5),
                viewForImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            ]
            
            width = 0.5*view.frame.width
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            if(view.frame.height > 800){
                let widthConstraint = viewForImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
                
                widthConstraint.isActive = true
                
                previousConstraintsToDeActivate.append(widthConstraint)
                
                width = 0.7*view.frame.width
            }
            else{
                let widthConstraint = viewForImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
                
                widthConstraint.isActive = true
                
                previousConstraintsToDeActivate.append(widthConstraint)
                width = 0.5*view.frame.width
            }
            
            let constraints = [
                viewForImage.heightAnchor.constraint(equalTo: viewForImage.widthAnchor),
                viewForImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                viewForImage.topAnchor.constraint(equalTo: emergencyInfoLabel.bottomAnchor,constant: 5)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        
        viewForImage.layer.cornerRadius = width/2
        
        viewForImage.layer.shadowColor = UIColor.systemRed.cgColor
        viewForImage.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewForImage.layer.shadowRadius = 8
        viewForImage.layer.shadowOpacity = 0.3
        viewForImage.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: width), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: width/2, height: width/2)).cgPath
    }
    
    func loadAmbulanceImageView() {
        ambulanceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "ambulance")?.withRenderingMode(.alwaysOriginal)
        
        ambulanceImageView.image = image?.withTintColor(.white)
        
        addTapGesture(toView: ambulanceImageView)
        
        let constraints = [
            ambulanceImageView.widthAnchor.constraint(equalTo: viewForImage.widthAnchor, multiplier: 0.7),
            ambulanceImageView.heightAnchor.constraint(equalTo: ambulanceImageView.widthAnchor),
            ambulanceImageView.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor),
            ambulanceImageView.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadNotSureLabel() {
        notSureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        notSureLabel.text = "Not sure what to do?"
        
        let constraints = [
            notSureLabel.topAnchor.constraint(equalTo: viewForImage.bottomAnchor,constant: 20),
            notSureLabel.leadingAnchor.constraint(equalTo: emergencyInfoLabel.leadingAnchor),
            notSureLabel.trailingAnchor.constraint(equalTo: emergencyInfoLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadSubjectLabel() {
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subjectLabel.text = "Pick the subject to inform the emergency contact"
        
        let constraints = [
            subjectLabel.topAnchor.constraint(equalTo: notSureLabel.bottomAnchor),
            subjectLabel.leadingAnchor.constraint(equalTo: notSureLabel.leadingAnchor),
            subjectLabel.trailingAnchor.constraint(equalTo: notSureLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadViewForCollectionView() {
        viewForCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        viewForCollectionView.backgroundColor = .systemBlue
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            
            var constraints: [NSLayoutConstraint] = []
            
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                constraints = [
                    viewForCollectionView.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor,constant: 25),
                    viewForCollectionView.leadingAnchor.constraint(equalTo: subjectLabel.leadingAnchor,constant: 50),
                    viewForCollectionView.trailingAnchor.constraint(equalTo: subjectLabel.trailingAnchor,constant: -50),
                    viewForCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -25),
                    viewForCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
                ]
            }
            else {
                constraints = [
                    viewForCollectionView.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor,constant: 25),
                    viewForCollectionView.leadingAnchor.constraint(equalTo: subjectLabel.leadingAnchor,constant: 50),
                    viewForCollectionView.trailingAnchor.constraint(equalTo: subjectLabel.trailingAnchor,constant: -50),
                    viewForCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -25),
                    viewForCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
                ]
            }
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            var height = 0.2
            
            if(view.frame.height > 800) {
                height = 0.17
            }
            
            let constraints = [
                viewForCollectionView.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor,constant: 10),
                viewForCollectionView.leadingAnchor.constraint(equalTo: subjectLabel.leadingAnchor),
                viewForCollectionView.trailingAnchor.constraint(equalTo: subjectLabel.trailingAnchor),
                viewForCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -15),
                viewForCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadCollectionView() {
        emergencyColletionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emergencyColletionView.topAnchor.constraint(equalTo: viewForCollectionView.topAnchor),
            emergencyColletionView.leadingAnchor.constraint(equalTo: viewForCollectionView.leadingAnchor),
            emergencyColletionView.trailingAnchor.constraint(equalTo: viewForCollectionView.trailingAnchor),
            emergencyColletionView.bottomAnchor.constraint(equalTo: viewForCollectionView.bottomAnchor),
        ])
    }
    
    @objc private func phoneCall(){
        print("Calling")
        if let phoneCallUrl = URL(string: "tel://+91\(108)"){
            let application = UIApplication.shared
            if(application.canOpenURL(phoneCallUrl)){
                application.open(phoneCallUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == completeYourProfileLabel){
            tapGesture.addTarget(self, action: #selector(completeProfileTapped))
        }
        else if(toView == ambulanceImageView){
            tapGesture.numberOfTouchesRequired = 1
            tapGesture.numberOfTapsRequired = 2
            tapGesture.addTarget(self, action: #selector(phoneCall))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func completeProfileTapped(_ sender: UITapGestureRecognizer) {
        print("Tapped")
        let viewController = EmergencyProfileVC()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func deliverMessage(toRecipients: [String], text: String) {
        if(MFMessageComposeViewController.canSendText() == false){
            return
        }
        
        let messageController = MFMessageComposeViewController()
        
        messageController.messageComposeDelegate = self
        
        messageController.recipients = toRecipients
        messageController.subject = "Emergency Help Needed."
        messageController.body = "Emergency Help Needed." + text
        
        self.present(messageController, animated: true, completion: nil)
    }
}

extension EmergencyVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emergencyVCHelper.imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmergencyCollectionViewCell.identifier, for: indexPath) as? EmergencyCollectionViewCell else {
            return EmergencyCollectionViewCell()
        }
        
        cell.imageLink = emergencyVCHelper.imageNames[indexPath.row]
        cell.contentText = emergencyVCHelper.reasons[indexPath.row]
        
        cell.layer.cornerRadius = 10
        
        cell.backgroundColor = .secondarySystemBackground
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? EmergencyCollectionViewCell else {
            return
        }
        
        print("Requesting for Messaging")
        
        emergencyVCHelper.updateStoredContactNumbers()
        let contacts = emergencyVCHelper.emergencyNumbers
        print(contacts)
        
        deliverMessage(toRecipients: contacts, text: cell.contentText ?? "")
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension EmergencyVC: MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}
