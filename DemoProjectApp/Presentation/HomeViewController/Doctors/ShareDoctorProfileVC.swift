//
//  ShareDoctorProfileVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/09/22.
//

import UIKit

class ShareDoctorProfileVC: UIViewController, UISheetPresentationControllerDelegate {

    override var sheetPresentationController: UISheetPresentationController {
        (presentationController as? UISheetPresentationController)!
    }
    
    let doctor: Doctor
    
    init(doctor: Doctor){
        self.doctor = doctor
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var doctorInfoView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var viewForImages: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        
        activity.startAnimating()
        
        return activity
    }()
    
    lazy var viewForProfileImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var doctorProfileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var videoImageView: UIImageView = {
        let image = UIImageView()
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var hospitalImageView: UIImageView = {
        let image = UIImageView()
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var videoImageLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalImageLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.clipsToBounds = true
        
        return label
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
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var designationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var experienceLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var ratingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var qualificationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
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
        label.lineBreakMode = .byTruncatingTail
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var doctorDescriptionLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var recommendationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var communicationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var profileLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray
        
        return view
    }()
    
    lazy var shareProfileButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Share Profile", for: .normal)
        button.configuration = UIButton.Configuration.borderedTinted()
        
        return button
    }()
    
    var previousConstraintsToDeactivate: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        view.addSubview(doctorInfoView)
        doctorInfoView.addSubview(viewForImages)
        
        viewForImages.addSubview(viewForProfileImage)
        viewForProfileImage.addSubview(activityIndicator)
        viewForProfileImage.addSubview(doctorProfileImageView)
        
        viewForImages.addSubview(videoImageView)
        viewForImages.addSubview(hospitalImageView)
        
        viewForImages.addSubview(videoImageLabel)
        viewForImages.addSubview(hospitalImageLabel)
        
        doctorInfoView.addSubview(nameLabel)
        doctorInfoView.addSubview(designationLabel)
        doctorInfoView.addSubview(experienceLabel)
        doctorInfoView.addSubview(ratingLabel)
        doctorInfoView.addSubview(qualificationLabel)
        doctorInfoView.addSubview(addressLabel)
        
        view.addSubview(profileLineView)
        view.addSubview(doctorDescriptionLabel)
        view.addSubview(recommendationLabel)
        view.addSubview(communicationLabel)
        
        view.addSubview(shareProfileButton)
        
        configureRequirments()
        loadContents()
    }
    
    func configureRequirments() {
        
        var height = CGFloat(350)
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            height = 0.4*view.frame.height
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                height = 0.6*view.frame.height
            }
        }
        
        let smallId = UISheetPresentationController.Detent.Identifier("small")
        if #available(iOS 16.0, *) {
            let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                return height
            }
            sheetPresentationController.delegate = self
            sheetPresentationController.detents = [smallDetent]
            sheetPresentationController.preferredCornerRadius = 10
            sheetPresentationController.prefersGrabberVisible = true
        } else {
            sheetPresentationController.delegate = self
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.preferredCornerRadius = 10
            sheetPresentationController.prefersGrabberVisible = true
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeactivate)
        previousConstraintsToDeactivate = []
        loadContents()
    }
    
    func loadContents() {
        
        loadDoctorInfoView()
        loadViewForImages()
        loadActivityIndicator()
        loadViewForProfileImage()
        loadDoctorProfileView()
        loadVideoImageView()
        loadHospitalImageView()
        loadVideoImageLabel()
        loadHospitalImageLabel()
        loadNameLabel()
        loadDesignationLabel()
        loadExperienceLabel()
        loadRatingLabel()
        loadQualificationLabel()
        loadAddressLabel()
        loadProfileLineView()
        loadDoctorDescriptionLabel()
        loadRecomendationLabel()
        loadShareProfileButton()
    }
    
    func loadDoctorInfoView() {
        doctorInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                doctorInfoView.heightAnchor.constraint(equalToConstant: 0.4*view.frame.height),
                doctorInfoView.widthAnchor.constraint(equalToConstant: 0.75*view.frame.width),
                doctorInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
                doctorInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
        else{
            if(view.frame.height > 400){
                let constraints = [
                    doctorInfoView.heightAnchor.constraint(equalToConstant: 0.32*view.frame.height),
                    doctorInfoView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
                    doctorInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
                    doctorInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previousConstraintsToDeactivate.append(constraint)
                }
            }
            else{
                let constraints = [
                    doctorInfoView.heightAnchor.constraint(equalToConstant: 0.4*view.frame.height),
                    doctorInfoView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
                    doctorInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
                    doctorInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previousConstraintsToDeactivate.append(constraint)
                }
            }
        }
    }
    
    func loadViewForImages() {
        viewForImages.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            viewForImages.heightAnchor.constraint(equalTo: doctorInfoView.heightAnchor),
            viewForImages.widthAnchor.constraint(equalTo: doctorInfoView.widthAnchor, multiplier: 0.37),
            viewForImages.leadingAnchor.constraint(equalTo: doctorInfoView.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
    }
    
    func loadActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: viewForProfileImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: viewForProfileImage.centerYAnchor)
        ])
    }
    
    func loadViewForProfileImage() {
        viewForProfileImage.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            viewForProfileImage.widthAnchor.constraint(equalTo: viewForImages.heightAnchor, multiplier: 0.7),
            viewForProfileImage.heightAnchor.constraint(equalTo: viewForProfileImage.widthAnchor),
            viewForProfileImage.topAnchor.constraint(equalTo: viewForImages.topAnchor),
            viewForProfileImage.centerXAnchor.constraint(equalTo: viewForImages.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
    }
    
    func loadDoctorProfileView() {
        doctorProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        doctorProfileImageView.downloaded(from: doctor.imageName)
        if(doctorProfileImageView.image != nil){
            activityIndicator.stopAnimating()
        }
        
        let constraints = [
            doctorProfileImageView.topAnchor.constraint(equalTo: viewForProfileImage.topAnchor),
            doctorProfileImageView.leadingAnchor.constraint(equalTo: viewForProfileImage.leadingAnchor),
            doctorProfileImageView.trailingAnchor.constraint(equalTo: viewForProfileImage.trailingAnchor),
            doctorProfileImageView.bottomAnchor.constraint(equalTo: viewForProfileImage.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }

        doctorProfileImageView.layer.cornerRadius = 10
    }
    
    func loadVideoImageView() {
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "video")?.withRenderingMode(.alwaysOriginal)
        
        videoImageView.image = image?.withTintColor(.secondaryLabel)
        
        let constraints = [
            videoImageView.leadingAnchor.constraint(equalTo: viewForProfileImage.leadingAnchor,constant: 10),
            videoImageView.topAnchor.constraint(equalTo: viewForProfileImage.bottomAnchor,constant: 5),
            videoImageView.widthAnchor.constraint(equalTo: viewForProfileImage.widthAnchor, multiplier: 0.2),
            videoImageView.heightAnchor.constraint(equalTo: videoImageView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
    }
    
    func loadHospitalImageView() {
        hospitalImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "building")?.withRenderingMode(.alwaysOriginal)
        
        hospitalImageView.image = image?.withTintColor(.secondaryLabel)
        
        NSLayoutConstraint.activate([
            hospitalImageView.trailingAnchor.constraint(equalTo: viewForProfileImage.trailingAnchor,constant: -10),
            hospitalImageView.topAnchor.constraint(equalTo: viewForProfileImage.bottomAnchor,constant: 5),
            hospitalImageView.widthAnchor.constraint(equalTo: viewForProfileImage.widthAnchor, multiplier: 0.2),
            hospitalImageView.heightAnchor.constraint(equalTo: videoImageView.widthAnchor)
        ])
    }
    
    func loadVideoImageLabel() {
        videoImageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoImageLabel.text = "Online"
        
        NSLayoutConstraint.activate([
            videoImageLabel.widthAnchor.constraint(equalTo: videoImageView.widthAnchor, multiplier: 1.5),
            videoImageLabel.topAnchor.constraint(equalTo: videoImageView.bottomAnchor,constant: -5),
            videoImageLabel.centerXAnchor.constraint(equalTo: videoImageView.centerXAnchor)
        ])
    }
    
    func loadHospitalImageLabel() {
        hospitalImageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalImageLabel.text = "In - Person"
        
        NSLayoutConstraint.activate([
            hospitalImageLabel.widthAnchor.constraint(equalTo: hospitalImageView.widthAnchor, multiplier: 2.5),
            hospitalImageLabel.topAnchor.constraint(equalTo: hospitalImageView.bottomAnchor,constant: -5),
            hospitalImageLabel.centerXAnchor.constraint(equalTo: hospitalImageView.centerXAnchor)
        ])
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = doctor.name
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            nameLabel.topAnchor.constraint(equalTo: doctorInfoView.topAnchor, constant: 15).isActive = true
        }
        else{
            nameLabel.topAnchor.constraint(equalTo: doctorInfoView.topAnchor, constant: -3).isActive = true
        }
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: viewForImages.trailingAnchor,constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: doctorInfoView.trailingAnchor),
        ])
    }
    
    func loadDesignationLabel() {
        designationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        designationLabel.text = doctor.designation.specializationType
        designationLabel.textColor = UIColor(red: 4/255, green: 132/255, blue: 179/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            designationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            designationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            designationLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
    }
    
    func loadExperienceLabel() {
        experienceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        experienceLabel.text = doctor.experience
        experienceLabel.textColor = UIColor(red: 4/255, green: 132/255, blue: 179/255, alpha: 1)
        
        experienceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            experienceLabel.topAnchor.constraint(equalTo: designationLabel.bottomAnchor),
            experienceLabel.leadingAnchor.constraint(equalTo: designationLabel.leadingAnchor),
            experienceLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
        ])
    }
    
    func loadRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let ratings = getRatedAttributedString(forRating: Int(doctor.ratings))
        
        ratings.append(NSMutableAttributedString(string: " \(doctor.ratings)"))
        
        ratingLabel.attributedText = ratings
        
        NSLayoutConstraint.activate([
            ratingLabel.trailingAnchor.constraint(equalTo: designationLabel.trailingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: experienceLabel.topAnchor)
        ])
    }
    
    func loadQualificationLabel() {
        qualificationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        qualificationLabel.text = doctor.qualification
        
        NSLayoutConstraint.activate([
            qualificationLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor),
            qualificationLabel.leadingAnchor.constraint(equalTo: experienceLabel.leadingAnchor),
//            qualificationLabel.trailingAnchor.constraint(equalTo: experienceLabel.trailingAnchor),
            qualificationLabel.trailingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
        ])
    }
    
    func loadAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addressLabel.text = doctor.location
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: qualificationLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: qualificationLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: qualificationLabel.trailingAnchor),
        ])
    }
    
    func loadProfileLineView() {
        profileLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileLineView.topAnchor.constraint(equalTo: doctorInfoView.bottomAnchor),
            profileLineView.leadingAnchor.constraint(equalTo: doctorInfoView.leadingAnchor),
            profileLineView.trailingAnchor.constraint(equalTo: doctorInfoView.trailingAnchor),
            profileLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func loadDoctorDescriptionLabel() {
        doctorDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        doctorDescriptionLabel.text = "\(doctor.name) from \(doctor.location) is one of the top \(doctor.designation.specializationType) in the country"
        
        if(view.frame.height < 600){
            doctorDescriptionLabel.font = .systemFont(ofSize: 14)
        }
        
        NSLayoutConstraint.activate([
            doctorDescriptionLabel.topAnchor.constraint(equalTo: profileLineView.bottomAnchor),
            doctorDescriptionLabel.leadingAnchor.constraint(equalTo: profileLineView.leadingAnchor),
            doctorDescriptionLabel.trailingAnchor.constraint(equalTo: profileLineView.trailingAnchor)
        ])
    }
    
    func loadRecomendationLabel() {
        recommendationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        recommendationLabel.text = "I strongly recommend him/her for any relevant health issues!"
        
        if(view.frame.height < 600){
            recommendationLabel.font = .systemFont(ofSize: 14)
        }
        
        NSLayoutConstraint.activate([
            recommendationLabel.topAnchor.constraint(equalTo: doctorDescriptionLabel.bottomAnchor),
            recommendationLabel.leadingAnchor.constraint(equalTo: doctorDescriptionLabel.leadingAnchor),
            recommendationLabel.trailingAnchor.constraint(equalTo: doctorDescriptionLabel.trailingAnchor)
        ])
    }
    
    func loadCommunicationLabel() {
        communicationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        communicationLabel.text = "You can easily consult with \(doctor.name) inline over the App and Website."
        
        if(view.frame.height < 600){
            communicationLabel.font = .systemFont(ofSize: 14)
        }
        
        NSLayoutConstraint.activate([
            communicationLabel.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor),
            communicationLabel.leadingAnchor.constraint(equalTo: recommendationLabel.leadingAnchor),
            communicationLabel.trailingAnchor.constraint(equalTo: recommendationLabel.trailingAnchor),
        ])
    }
    
    func loadShareProfileButton() {
        shareProfileButton.translatesAutoresizingMaskIntoConstraints = false
        
        shareProfileButton.addTarget(self, action: #selector(didTapShareProfileButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            shareProfileButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            shareProfileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15),
        ])
        
        if(view.frame.height < 600){
            let constraints = [
                shareProfileButton.heightAnchor.constraint(equalToConstant: shareProfileButton.intrinsicContentSize.height - 10),
                shareProfileButton.widthAnchor.constraint(equalToConstant: shareProfileButton.intrinsicContentSize.width - 10)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
        else if(view.frame.height < 800) {
            let heightAnchor = shareProfileButton.heightAnchor.constraint(equalToConstant: shareProfileButton.intrinsicContentSize.height - 10)
            
            heightAnchor.isActive = true
            
            previousConstraintsToDeactivate.append(heightAnchor)
        }
        else{
            let widthAnchor = shareProfileButton.widthAnchor.constraint(equalToConstant: shareProfileButton.intrinsicContentSize.width + 30)
            
            widthAnchor.isActive = true
            
            previousConstraintsToDeactivate.append(widthAnchor)
        }
    }
    
    @objc func didTapShareProfileButton(_ sender: UIButton) {
        let activityIndicatorView = UIActivityViewController(activityItems: [doctor.name, doctor.designation.specializationType, doctor.experience, doctor.qualification, doctor.location, "Rated as: \(doctor.ratings) out of 5"], applicationActivities: nil)
    
        present(activityIndicatorView, animated: true)
        
        if let popOver = activityIndicatorView.popoverPresentationController {
          popOver.sourceView = self.view
        }
    }
}

extension ShareDoctorProfileVC {
    func getRatedAttributedString(forRating: Int) -> NSMutableAttributedString {
        let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        
        let imageToAppend = NSTextAttachment()
        
        imageToAppend.image = image?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
        
        imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
        
        let mutableString = NSMutableAttributedString(attachment: imageToAppend)
        
        return mutableString
    }
}
