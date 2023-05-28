//
//  HospitalProfileVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/12/22.
//

import UIKit

class HospitalProfileVC: UIViewController {

    override var sheetPresentationController: UISheetPresentationController! {
        return presentationController as? UISheetPresentationController
    }
    
    lazy var imageView: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var thumbNailImageView: ImageLoader = {
        let imageView = ImageLoader()
        
        guard let url = URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZejv9yWWeQOZhd-OYDFQ8PbR_jo3968ILuA&usqp=CAU") else {
            return ImageLoader()
        }
        
        imageView.loadImageWithUrl(url)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        
        view.startAnimating()
        
        return view
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
        label.font = UIFont(name: "Helvetica", size: 15)
        
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
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()
    
    lazy var locationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()
    
    lazy var openForLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()
    
    lazy var addressLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()
    
    lazy var contactNowLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = true
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()
    
    lazy var hospitalImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "hospital")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        
        return imageView
    }()
    
    lazy var navigateButton: ResizedButton = {
        let button = ResizedButton()
        
        button.layer.cornerRadius = 10
        button.setTitle("Navigate to Hospital", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    var hospital: Hospital? {
        didSet {
            guard let hospital = hospital else {
                return
            }
            
            guard let url = URL(string: hospital.imageLink) else {
                return
            }
            
            imageView.loadImageWithUrl(url)
            
            nameLabel.text = "\(hospital.name) Hospital"
            
            let starAttributedString: NSMutableAttributedString = getRatedAttributedString(forRating: hospital.ratings)
            
            starAttributedString.append(NSAttributedString(string: " (\(hospital.ratings))"))
            
            ratingLabel.attributedText = starAttributedString
            
            addressLabel.text = hospital.address
            
            openForLabel.text = "Open \(hospital.openHours)"
            openForLabel.textColor = .systemGreen
            
            
            guard let image = UIImage(systemName: "mappin.and.ellipse")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal) else {
                return
            }
            
            let textAttchment = NSTextAttachment(image: image)
            
            let locationAttributedString = NSMutableAttributedString(attachment: textAttchment)
            
            locationAttributedString.append(NSAttributedString(string: " \(hospital.place.locationName)"))
            
            locationLabel.attributedText = locationAttributedString
            
            guard let imageToAttach = UIImage(systemName: "phone.and.waveform") else {
                return
            }
            
            let contactTextAttachment = NSTextAttachment(image: imageToAttach)
            let contactAttrString = NSAttributedString(string: " Contact Now")
            
            let contactAttributedString = NSMutableAttributedString(attachment: contactTextAttachment)
            contactAttributedString.append(contactAttrString)
            
            contactAttributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 0, length: 13))
            
            contactNowLabel.attributedText = contactAttributedString
            
            activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        view.addSubview(thumbNailImageView)
        view.addSubview(activityIndicator)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(openForLabel)
        view.addSubview(locationLabel)
        view.addSubview(ratingLabel)
        view.addSubview(hospitalImageView)
        view.addSubview(addressLabel)
        view.addSubview(navigateButton)
        view.addSubview(contactNowLabel)
        
        configureSheetPresentationController()
        
        loadContents()
        
        addTapGesture(toView: contactNowLabel)
    }
    
    func loadContents() {
        loadThumbNailImageView()
        loadActivityIndicator()
        loadImageView()
        loadNameLabel()
        loadOpenForLabel()
        loadLocationLabel()
        loadContactNowLabel()
        loadRatinglabel()
        loadHospitalImageView()
        loadAddressLabel()
        loadNavigateButton()
    }
    
    func configureSheetPresentationController() {
        let smallId = UISheetPresentationController.Detent.Identifier("small")
        if #available(iOS 16.0, *) {
            let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                return 300
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
    
    func loadThumbNailImageView() {
        thumbNailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbNailImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            thumbNailImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            thumbNailImageView.widthAnchor.constraint(equalTo: thumbNailImageView.heightAnchor),
            thumbNailImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        thumbNailImageView.layer.cornerRadius = 10
    }
    
    func loadActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: thumbNailImageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: thumbNailImageView.centerXAnchor)
        ])
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: thumbNailImageView.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: thumbNailImageView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.topAnchor.constraint(equalTo: thumbNailImageView.topAnchor)
        ])
        
        imageView.layer.cornerRadius = 10
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    func loadRatinglabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -2),
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    func loadOpenForLabel() {
        openForLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            openForLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: -2),
            openForLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            openForLabel.trailingAnchor.constraint(equalTo: ratingLabel.trailingAnchor)
        ])
    }
    
    func loadLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: openForLabel.bottomAnchor, constant: -2),
            locationLabel.leadingAnchor.constraint(equalTo: openForLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: openForLabel.trailingAnchor)
        ])
    }
    
    func loadContactNowLabel() {
        contactNowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactNowLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: -2),
            contactNowLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            contactNowLabel.trailingAnchor.constraint(equalTo: locationLabel.trailingAnchor)
        ])
    }
    
    func loadHospitalImageView() {
        hospitalImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hospitalImageView.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
            hospitalImageView.leadingAnchor.constraint(equalTo: thumbNailImageView.leadingAnchor, constant: 5),
            hospitalImageView.heightAnchor.constraint(equalToConstant: 30),
            hospitalImageView.widthAnchor.constraint(equalTo: hospitalImageView.heightAnchor)
        ])
    }
    
    func loadAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: thumbNailImageView.bottomAnchor, constant: 5),
            addressLabel.leadingAnchor.constraint(equalTo: hospitalImageView.trailingAnchor, constant: 10),
            addressLabel.trailingAnchor.constraint(equalTo: ratingLabel.trailingAnchor)
        ])
    }
    
    func loadNavigateButton() {
        navigateButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigateButton.addTarget(self, action: #selector(didTapNavigateToHospitalButton), for: .touchUpInside)
        
        var widthConstant = 0.0
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            widthConstant = 0.5
        }
        else{
            widthConstant = 0.8
        }
        
        NSLayoutConstraint.activate([
            navigateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            navigateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: view.frame.width * widthConstant),
            navigateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func didTapNavigateToHospitalButton(_ sender: UIButton) {
        openUrl(hospital?.directionLink ?? "")
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == contactNowLabel) {
            tapGesture.addTarget(self, action: #selector(didTapCallNow))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapCallNow(_ sender: UITapGestureRecognizer) {
        if let phoneCallUrl = URL(string: "tel://+91\(9445577156)"){
            let application = UIApplication.shared
            if(application.canOpenURL(phoneCallUrl)){
                application.open(phoneCallUrl, options: [:], completionHandler: nil)
            }
        }
    }
    
    func getRatedAttributedString(forRating: Double) -> NSMutableAttributedString {
        let fullStarImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        
        let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")?.withRenderingMode(.alwaysOriginal)
        
        let emptyStarImage = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        let fullStars = Int(forRating)
        
        let roundedValue = round(forRating)
        
        var starsAdded = 0
        
        let mutableString = NSMutableAttributedString()
        
        for _ in 0..<fullStars {
            let imageToAppend = NSTextAttachment()
            
            imageToAppend.image = fullStarImage?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
            
            imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
            
            mutableString.append(NSMutableAttributedString(attachment: imageToAppend))
            
            starsAdded+=1
        }
        
        if(Int(roundedValue) > fullStars) {
            
            let imageToAppend = NSTextAttachment()
            
            imageToAppend.image = halfStarImage?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
            
            imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
            
            mutableString.append(NSAttributedString(attachment: imageToAppend))
            
            starsAdded+=1
        }
        
        for _ in starsAdded..<5 {
            let imageToAppend = NSTextAttachment()
            
            imageToAppend.image = emptyStarImage?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
            
            imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
            
            mutableString.append(NSAttributedString(attachment: imageToAppend))
        }
        
        return mutableString
    }
    
    func openUrl(_ direction:  String) {
        guard let url = URL(string: "comgooglemaps://\(direction)") else {
            return
        }
        
        if(UIApplication.shared.canOpenURL(url)) {
            guard let url = URL(string: direction) else {
                return
            }
            
            UIApplication.shared.open(url)
        }
        else{
            guard let url = URL(string: "https://apps.apple.com/us/app/google-maps/id585027354") else {
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

extension HospitalProfileVC: UISheetPresentationControllerDelegate {
    
}
