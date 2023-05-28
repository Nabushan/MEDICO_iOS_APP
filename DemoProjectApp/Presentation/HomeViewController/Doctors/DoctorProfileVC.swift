//
//  DoctorProfileVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/09/22.
//

import UIKit

class DoctorProfileVC: UIViewController, DoctorProfileVCProtocol {

    let doctorProfileVCHelper: DoctorProfileVCHelper
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.isScrollEnabled = true
        scrollView.contentInsetAdjustmentBehavior = .always
        
        return scrollView
    }()
    
    lazy var viewForProfileImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    lazy var profileImageView: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    lazy var viewForNameAndShareButton: UIView = {
        let view = UIView()
        
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
        label.font = .systemFont(ofSize: 15, weight: .medium)
            
        return label
    }()
    
    lazy var shareProfileView: UIView = {
        let view = UIView()
        
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var shareLabel: ResizedLabel = {
        let label = ResizedLabel()
            
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var shareImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        
        return imageView
    }()
    
    lazy var profileAndShareLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray
        
        return view
    }()
    
    lazy var designationAndExperienceLabel: ResizedLabel = {
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
    
    lazy var ratingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var viewForQualification: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var qualificationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var qualificationLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray
        
        return view
    }()
    
    lazy var viewForLocation: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var viewForLanguagesKnown: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var locationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var languagesKnownImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var languagesLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var languagesKnownLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray
        
        return view
    }()
    
    lazy var viewForAvailability: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var availabilityImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var availabilityLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .topLeft
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var costView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var videoConsultView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var verticalLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var hospitalConsultView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var videoConsultLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var hospitalConsultLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var videoConsultCostLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var hospitalConsultCostLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var videoConsultAvailableAtLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var hospitalConsultAvailableAtLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var informationView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var inAppAudioVideoLabel: ResizedLabel = {
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
        label.textColor = .label
        
        return label
    }()
    
    lazy var costLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    lazy var availableInLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
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
    
    lazy var informationLineView: UIView =  {
        let view = UIView()
        
        view.backgroundColor = .systemGray
        
        return view
    }()
    
    lazy var questionLabel: ResizedLabel = {
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
        label.textColor = .label
        
        return label
    }()
    
    lazy var doctorImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    lazy var infoViewDoctorLabel: ResizedLabel = {
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
        label.textColor = .label
        
        return label
    }()
    
    lazy var slotImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    lazy var infoViewSlotLabel: ResizedLabel = {
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
        label.textColor = .label
        
        return label
    }()
    
    lazy var creditCardImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    lazy var infoViewCreditCardLabel: ResizedLabel = {
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
        label.textColor = .label
        
        return label
    }()
    
    lazy var appImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    lazy var infoViewAppLabel: ResizedLabel = {
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
        label.textColor = .label
        
        return label
    }()
    
    lazy var cameraImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    lazy var infoViewCameraLabel: ResizedLabel = {
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
        label.textColor = .label
        
        return label
    }()
    
    lazy var prescriptionImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    lazy var infoViewPrescriptionLabel: ResizedLabel = {
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
        label.textColor = .label
        
        return label
    }()
    
    lazy var followUpImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    lazy var infoViewFollowUpLabel: ResizedLabel = {
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
    
    lazy var physicalLocationLabel: ResizedLabel = {
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
    
    lazy var physicalLocationView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var physicalLocationImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode  = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var physicalLocationAddressLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var timingsView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var timingsLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var timingsVideoConsultLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultMondayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultMondayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultTuesdayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultTuesdayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultWednesdayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultWednesdayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultThursdayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultThursdayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultFridayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultFridayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultSaturdayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultSaturdayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultSundayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var videoConsultSundayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var timingsHospitalVisitLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitMondayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitMondayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitTuesdayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitTuesdayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitWednesdayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitWednesdayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitThursdayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitThursdayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitFridayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitFridayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitSaturdayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitSaturdayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitSundayLabel: ResizedLabel = {
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
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitSundayTimingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var verticalButtonSeparator: UIView = {
        let view = UIView()
        
        view.isUserInteractionEnabled = false
        
        return view
    }()
    
    lazy var videoConsultButtonView: UIView = {
        let view = UIView()
        
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var videoConsultButtonImageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    lazy var videoConsultButtonLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var hospitalVisitButtonView: UIView = {
        let view = UIView()
        
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var hospitalVisitButtonImageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    lazy var hospitalVisitButtonLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = Theme.lightMode.subViewBackGroundColor
        
        return view
    }()
    
    lazy var seeAllDoctorReviewsButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("See All Reviews", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    var previousConstraintsToDeactivate: [NSLayoutConstraint] = []
    let doctor: Doctor
    weak var reBookDelegate: ReBookingProtocol?
    var isFromConsultation: Bool = false
    var isFromBookAgain: Bool = false
    
    var bottomViewHeight = CGFloat.zero
    
    init(doctor: Doctor, isFromBookAgain: Bool?) {
        self.doctor = doctor
        self.doctorProfileVCHelper = DoctorProfileVCHelper(doctor: doctor)
        
        super.init(nibName: nil, bundle: nil)
        
        guard let isFromBookAgain = isFromBookAgain else {
            return
        }
        
        self.isFromBookAgain = isFromBookAgain
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        print(doctor)
        
        view.addSubview(scrollView)
        view.addSubview(bottomView)
        
        bottomView.addSubview(videoConsultButtonView)
        bottomView.addSubview(verticalButtonSeparator)
        bottomView.addSubview(hospitalVisitButtonView)
        
        videoConsultButtonView.addSubview(videoConsultButtonImageView)
        videoConsultButtonView.addSubview(videoConsultButtonLabel)
        hospitalVisitButtonView.addSubview(hospitalVisitButtonImageView)
        hospitalVisitButtonView.addSubview(hospitalVisitButtonLabel)
        
        scrollView.addSubview(viewForProfileImage)
        viewForProfileImage.addSubview(activityIndicator)
        viewForProfileImage.addSubview(profileImageView)
        
        scrollView.addSubview(viewForNameAndShareButton)
        viewForNameAndShareButton.addSubview(nameLabel)
        viewForNameAndShareButton.addSubview(shareProfileView)
        shareProfileView.addSubview(shareLabel)
        shareProfileView.addSubview(shareImageView)
        
        scrollView.addSubview(profileAndShareLineView)
        scrollView.addSubview(designationAndExperienceLabel)
        scrollView.addSubview(ratingLabel)
        scrollView.addSubview(viewForQualification)
        viewForQualification.addSubview(qualificationLabel)
        
        scrollView.addSubview(qualificationLineView)
        scrollView.addSubview(viewForLocation)
        viewForLocation.addSubview(locationImageView)
        viewForLocation.addSubview(locationLabel)
        
        scrollView.addSubview(viewForLanguagesKnown)
        viewForLanguagesKnown.addSubview(languagesKnownImageView)
        viewForLanguagesKnown.addSubview(languagesLabel)
        
        scrollView.addSubview(languagesKnownLineView)
        scrollView.addSubview(viewForAvailability)
        viewForAvailability.addSubview(availabilityImageView)
        viewForAvailability.addSubview(availabilityLabel)
        
        scrollView.addSubview(costView)
        costView.addSubview(videoConsultView)
        videoConsultView.addSubview(videoConsultLabel)
        videoConsultView.addSubview(videoConsultCostLabel)
        videoConsultView.addSubview(videoConsultAvailableAtLabel)
        
        costView.addSubview(verticalLineView)
        costView.addSubview(hospitalConsultView)
        hospitalConsultView.addSubview(hospitalConsultLabel)
        hospitalConsultView.addSubview(hospitalConsultCostLabel)
        hospitalConsultView.addSubview(hospitalConsultAvailableAtLabel)
        
        scrollView.addSubview(seeAllDoctorReviewsButton)
        
        scrollView.addSubview(informationView)
        informationView.addSubview(inAppAudioVideoLabel)
        informationView.addSubview(costLabel)
        informationView.addSubview(availableInLabel)
        informationView.addSubview(informationLineView)
        informationView.addSubview(questionLabel)
        informationView.addSubview(doctorImageView)
        informationView.addSubview(infoViewDoctorLabel)
        informationView.addSubview(slotImageView)
        informationView.addSubview(infoViewSlotLabel)
        informationView.addSubview(creditCardImageView)
        informationView.addSubview(infoViewCreditCardLabel)
        informationView.addSubview(appImageView)
        informationView.addSubview(infoViewAppLabel)
        informationView.addSubview(cameraImageView)
        informationView.addSubview(infoViewCameraLabel)
        informationView.addSubview(prescriptionImageView)
        informationView.addSubview(infoViewPrescriptionLabel)
        informationView.addSubview(followUpImageView)
        informationView.addSubview(infoViewFollowUpLabel)
        
        scrollView.addSubview(physicalLocationLabel)
        
        scrollView.addSubview(physicalLocationView)
        physicalLocationView.addSubview(physicalLocationImageView)
        physicalLocationView.addSubview(physicalLocationAddressLabel)
        
        scrollView.addSubview(timingsView)
        timingsView.addSubview(timingsLabel)
        timingsView.addSubview(timingsVideoConsultLabel)
        timingsView.addSubview(videoConsultMondayLabel)
        timingsView.addSubview(videoConsultMondayTimingLabel)
        timingsView.addSubview(videoConsultTuesdayLabel)
        timingsView.addSubview(videoConsultTuesdayTimingLabel)
        timingsView.addSubview(videoConsultWednesdayLabel)
        timingsView.addSubview(videoConsultWednesdayTimingLabel)
        timingsView.addSubview(videoConsultThursdayLabel)
        timingsView.addSubview(videoConsultThursdayTimingLabel)
        timingsView.addSubview(videoConsultFridayLabel)
        timingsView.addSubview(videoConsultFridayTimingLabel)
        timingsView.addSubview(videoConsultSaturdayLabel)
        timingsView.addSubview(videoConsultSaturdayTimingLabel)
        timingsView.addSubview(videoConsultSundayLabel)
        timingsView.addSubview(videoConsultSundayTimingLabel)
        timingsView.addSubview(timingsHospitalVisitLabel)
        timingsView.addSubview(hospitalVisitMondayLabel)
        timingsView.addSubview(hospitalVisitMondayTimingLabel)
        timingsView.addSubview(hospitalVisitTuesdayLabel)
        timingsView.addSubview(hospitalVisitTuesdayTimingLabel)
        timingsView.addSubview(hospitalVisitWednesdayLabel)
        timingsView.addSubview(hospitalVisitWednesdayTimingLabel)
        timingsView.addSubview(hospitalVisitThursdayLabel)
        timingsView.addSubview(hospitalVisitThursdayTimingLabel)
        timingsView.addSubview(hospitalVisitFridayLabel)
        timingsView.addSubview(hospitalVisitFridayTimingLabel)
        timingsView.addSubview(hospitalVisitSaturdayLabel)
        timingsView.addSubview(hospitalVisitSaturdayTimingLabel)
        timingsView.addSubview(hospitalVisitSundayLabel)
        timingsView.addSubview(hospitalVisitSundayTimingLabel)
        
        scrollView.addSubview(seperatorView)
        
        configureDelegates()
        
        loadScrollView()
        loadContents()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if(UIDevice.current.orientation != .landscapeLeft && UIDevice.current.orientation != .landscapeRight) {
            loadInformationViewShadow()
            loadBottomViewShadow()
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeactivate)
        previousConstraintsToDeactivate = []
        loadContents()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeactivate)
        previousConstraintsToDeactivate = []
        loadContents()
    }
    
    func loadContents() {
        loadBottomView()
        loadVedioConsultButtonView()
        loadVideoConsultButtonImageView()
        loadVideoConsultButtonLabel()
        loadVerticalButtonSeparator()
        loadHospitalVisitButtonView()
        loadHospitalVisitButtonImageView()
        loadHospitalVisitButtonLabel()
        loadViewForImage()
        loadActivityIndicator()
        loadProfileImageView()
        loadViewForNameAndShareButton()
        loadNameLabel()
        loadShareProfileView()
        loadSharelabel()
        loadShareImageView()
        loadProfileAndShareLineView()
        loadQualificationAndExperienceLabel()
        loadRatingLabel()
        loadViewForQualification()
        loadQualificationLabel()
        loadQualificationLineView()
        loadViewForLocation()
        loadLocationImageView()
        loadLocationLabel()
        loadViewForLanguagesKnown()
        loadLanguagesKnownImageView()
        loadLanguagesKnownLabel()
        loadLanguagesKnownLineView()
        loadViewForAvailability()
        loadAvailabilityImageView()
        loadAvailabilityLabel()
        loadCostView()
        loadVideoConsultView()
        loadVideoConsultLabel()
        loadVideoConsultCostLabel()
        loadVideoConsultAvailableAtLabel()
        loadVerticalView()
        loadHospitalConsultView()
        loadHospitalConsultLabel()
        loadHospitalConsultCostLabel()
        loadHospitalConsultAvailableAtLabel()
        loadSeeAllDoctorReviews()
        loadInformationView()
        loadInAppAudioVedioLabel()
        loadCostLabel()
        loadAvailableInLabel()
        loadInformationLineView()
        loadInformationQusetionLabel()
        loadDoctorImageView()
        loadInfoViewDoctorLabel()
        loadSlotImageView()
        loadInfoViewSlotLabel()
        loadCardImageView()
        loadInfoViewCardLabel()
        loadAppImageView()
        loadInfoViewAppLabel()
        loadCameraImageView()
        loadInfoViewCameraLabel()
        loadPrescriptionImageView()
        loadInfoViewPrescriptionLabel()
        loadFollowUpImageView()
        loadInfoViewFollowUpLabel()
        loadPhysicalLocationLabel()
        loadPhysicalLocationView()
        loadPhysicalLocationImageView()
        loadPhysicalLocationAddressLabel()
        loadTimingsView()
        loadTimingsLabel()
        loadTimingsVideoConsultLabel()
        loadVideoConsultMondayLabel()
        loadVideoConsultMondayTimingLabel()
        loadVideoConsultTuesdayLabel()
        loadVideoConsultTuesdayTimingLabel()
        loadVideoConsultWednesdayLabel()
        loadVideoConsultWednesdayTimingLabel()
        loadVideoConsultThursdayLabel()
        loadVideoConsultThursdayTimingLabel()
        loadVideoConsultFridayLabel()
        loadVideoConsultFridayTimingLabel()
        loadVideoConsultSaturdayLabel()
        loadVideoConsultSaturdayTimingLabel()
        loadVideoConsultSundayLabel()
        loadVideoConsultSundayTimingLabel()
        loadTimingsHospitalVisitLabel()
        loadHospitalVisitMondayLabel()
        loadHospitalVisitMondayTimingLabel()
        loadHospitalVisitTuesdayLabel()
        loadHospitalVisitTuesdayTimingLabel()
        loadHospitalVisitWednesdayLabel()
        loadHospitalVisitWednesdayTimingLabel()
        loadHospitalVisitThursdayLabel()
        loadHospitalVisitThursdayTimingLabel()
        loadHospitalVisitFridayLabel()
        loadHospitalVisitFridayTimingLabel()
        loadHospitalVisitSaturdayLabel()
        loadHospitalVisitSaturdayTimingLabel()
        loadHospitalVisitSundayLabel()
        loadHospitalVisitSundayTimingLabel()
        loadSeperatorView()
    }
    
    func loadInformationViewShadow() {
        var width = CGFloat.zero

        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular  && isFromBookAgain == false){
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
                width = 0.46*view.frame.height
            }
            else{
                width = 0.46*view.frame.width
            }
        }
        else{
            width = view.frame.width - 40
        }

        informationView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: 0.3*view.frame.height), cornerRadius: costView.layer.cornerRadius).cgPath
    }
    
    func loadBottomViewShadow() {
        bottomView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        bottomView.layer.shadowPath = UIBezierPath(rect: CGRect(x: -5, y: -7, width: view.frame.height, height: bottomViewHeight)).cgPath
        bottomView.layer.shadowRadius = 20
        bottomView.layer.shadowOpacity = 0.5
        bottomView.layer.shadowOffset = .zero
    }
    
    func configureDelegates() {
        doctorProfileVCHelper.delegate = self
    }
    
    func loadScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.delegate = self
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func loadBottomView() {
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.backgroundColor = view.backgroundColor
        
        var bottomPadding = view.safeAreaInsets.bottom
        
        if(view.frame.height > 750) {
            bottomPadding+=30
        }
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            bottomPadding-=10
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                bottomPadding-=20
            }
        }
                
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            bottomViewHeight = 0.08*view.frame.height
        }
        else{
            if(bottomView.safeAreaInsets.bottom == 0) {
                bottomViewHeight = 0.1*view.frame.height
            }
            else {
                bottomViewHeight = 0.12*view.frame.height
            }
        }
        
        let constraints = [
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: bottomViewHeight),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
    }
    
    func loadVedioConsultButtonView() {
        videoConsultButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultButtonView.backgroundColor = .systemYellow
        
        var width = 0.45
        let height = 0.6
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            width = 0.3
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        if(window.safeAreaInsets.bottom == 0) {
            constraints = [
                videoConsultButtonView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: width),
                videoConsultButtonView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: height),
                videoConsultButtonView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
                videoConsultButtonView.trailingAnchor.constraint(equalTo: verticalButtonSeparator.leadingAnchor)
            ]
        }
        else{
            constraints = [
                videoConsultButtonView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: width),
                videoConsultButtonView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: height),
                videoConsultButtonView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
                videoConsultButtonView.trailingAnchor.constraint(equalTo: verticalButtonSeparator.leadingAnchor)
            ]
        }
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            
            var val = 0.0
            
            if(bottomView.safeAreaInsets.bottom == 0) {
                val = 0.1
            }
            else {
                val = 0.12
            }
            
            let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width*view.frame.width, height: val*height*view.frame.height), byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
            
            let maskLayer = CAShapeLayer()
            
            maskLayer.path = path.cgPath
            
            videoConsultButtonView.layer.mask = maskLayer
        }
        else{
            videoConsultButtonView.layer.cornerRadius = 10
        }
        
        addTapGesture(toView: videoConsultButtonView)
    }
    
    func loadVerticalButtonSeparator() {
        verticalButtonSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        verticalButtonSeparator.backgroundColor = view.backgroundColor
        
        NSLayoutConstraint.activate([
            verticalButtonSeparator.heightAnchor.constraint(equalTo: bottomView.heightAnchor),
            verticalButtonSeparator.widthAnchor.constraint(equalToConstant: 10),
            verticalButtonSeparator.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
        ])
    }
    
    func loadHospitalVisitButtonView() {
        hospitalVisitButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitButtonView.backgroundColor = .systemBlue
        
        var width = 0.45
        let height = 0.6
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            width = 0.3
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        if(window.safeAreaInsets.bottom == 0) {
            constraints = [
                hospitalVisitButtonView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: width),
                hospitalVisitButtonView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: height),
                hospitalVisitButtonView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
                hospitalVisitButtonView.leadingAnchor.constraint(equalTo: verticalButtonSeparator.trailingAnchor)
            ]
        }
        else {
            constraints = [
                hospitalVisitButtonView.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: width),
                hospitalVisitButtonView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: height),
                hospitalVisitButtonView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
                hospitalVisitButtonView.leadingAnchor.constraint(equalTo: verticalButtonSeparator.trailingAnchor)
            ]
        }
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            
            var val = 0.0
            
            if(bottomView.safeAreaInsets.bottom == 0) {
                val = 0.1
            }
            else {
                val = 0.12
            }
            
            let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width*view.frame.width, height: val*height*view.frame.height), byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
            
            let maskLayer = CAShapeLayer()
            
            maskLayer.path = path.cgPath
            
            hospitalVisitButtonView.layer.mask = maskLayer
        }
        else{
            hospitalVisitButtonView.layer.cornerRadius = 10
        }
        
        addTapGesture(toView: hospitalVisitButtonView)
    }
    
    @objc func bookVideoConsultTapped(_ sender: UITapGestureRecognizer) {
        
        print("bookVideoConsultTapped")
        
        let appointmentVC = BookAppointmentVC(doctorDetails: doctor, packageType: .videoConsultation)
        appointmentVC.title = "Book Video Consultation"
        
        navigationController?.pushViewController(appointmentVC, animated: true)
    }
    
    @objc func bookHospitalVisitTapped(_ sender: UITapGestureRecognizer) {
        print("bookHospitalVisitTapped")
        
        let appointmentVC = BookAppointmentVC(doctorDetails: doctor, packageType: .hospitalVisit)
        appointmentVC.title = "Book Hospital Visit"
        
        navigationController?.pushViewController(appointmentVC, animated: true)
    }
    
    func loadHospitalVisitButtonImageView() {
        hospitalVisitButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "building")?.withRenderingMode(.alwaysOriginal)
        
        hospitalVisitButtonImageView.image = image?.withTintColor(.white)
        
        hospitalVisitButtonImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        hospitalVisitButtonImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            hospitalVisitButtonImageView.centerYAnchor.constraint(equalTo: hospitalVisitButtonView.centerYAnchor),
            hospitalVisitButtonImageView.trailingAnchor.constraint(equalTo: hospitalVisitButtonLabel.leadingAnchor, constant: -3)
        ])
    }
    
    func loadHospitalVisitButtonLabel() {
        hospitalVisitButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitButtonLabel.text = "Book Hospital Visit"
        hospitalVisitButtonLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            hospitalVisitButtonLabel.centerYAnchor.constraint(equalTo: hospitalVisitButtonView.centerYAnchor),
            hospitalVisitButtonLabel.centerXAnchor.constraint(equalTo: hospitalVisitButtonView.centerXAnchor, constant: 10)
        ])
    }
    
    func loadVideoConsultButtonImageView() {
        videoConsultButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "video")?.withRenderingMode(.alwaysOriginal)
        
        videoConsultButtonImageView.image = image?.withTintColor(.white)
        
        videoConsultButtonImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        videoConsultButtonImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            videoConsultButtonImageView.centerYAnchor.constraint(equalTo: videoConsultButtonView.centerYAnchor),
            videoConsultButtonImageView.trailingAnchor.constraint(equalTo: videoConsultButtonLabel.leadingAnchor, constant: -3)
        ])
    }
    
    func loadVideoConsultButtonLabel() {
        videoConsultButtonLabel.translatesAutoresizingMaskIntoConstraints = false

        videoConsultButtonLabel.text = "Book Video Consult"
        videoConsultButtonLabel.textColor = .white

        NSLayoutConstraint.activate([
            videoConsultButtonLabel.centerYAnchor.constraint(equalTo: videoConsultButtonView.centerYAnchor),
            videoConsultButtonLabel.centerXAnchor.constraint(equalTo: videoConsultButtonView.centerXAnchor, constant: 10)
        ])
    }
    
    func loadViewForImage(){
        viewForProfileImage.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular && isFromBookAgain == false){
            constraints = [
                viewForProfileImage.heightAnchor.constraint(equalToConstant: 0.2*view.frame.height),
                viewForProfileImage.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 10),
                viewForProfileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
                viewForProfileImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.46)
            ]
        }
        else{
            constraints = [
                viewForProfileImage.heightAnchor.constraint(equalToConstant: 0.2*view.frame.height),
                viewForProfileImage.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 10),
                viewForProfileImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
                viewForProfileImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            ]
        }
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
    }
    
    func loadActivityIndicator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: viewForProfileImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: viewForProfileImage.centerYAnchor)
        ])
    }
    
    func loadProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let url = URL(string: doctor.imageName) else {
            return
        }
        
        profileImageView.loadImageWithUrl(url)
        
        if(profileImageView.image != nil){
            activityIndicator.stopAnimating()
        }
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalTo: viewForProfileImage.heightAnchor),
            profileImageView.widthAnchor.constraint(equalTo: viewForProfileImage.heightAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: viewForProfileImage.centerXAnchor)
        ])
        
        print(profileImageView.frame.height/2)
        profileImageView.layer.cornerRadius = 0.2*view.frame.height/2
    }
    
    func loadViewForNameAndShareButton() {
        viewForNameAndShareButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewForNameAndShareButton.heightAnchor.constraint(equalToConstant: 0.05*view.frame.height),
            viewForNameAndShareButton.topAnchor.constraint(equalTo: viewForProfileImage.bottomAnchor),
            viewForNameAndShareButton.leadingAnchor.constraint(equalTo: viewForProfileImage.leadingAnchor),
            viewForNameAndShareButton.trailingAnchor.constraint(equalTo: viewForProfileImage.trailingAnchor),
        ])
    }
    
    func loadNameLabel(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = doctor.name
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: viewForNameAndShareButton.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: viewForNameAndShareButton.leadingAnchor),
        ])
    }
    
    func loadShareProfileView(){
        shareProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        shareProfileView.contentMode = .right
        
        addTapGesture(toView: shareProfileView)
        
        if(view.frame.height < 600){
            NSLayoutConstraint.activate([
                shareProfileView.widthAnchor.constraint(equalToConstant: 0.3*view.frame.width),
                shareProfileView.heightAnchor.constraint(equalTo: viewForNameAndShareButton.heightAnchor),
                shareProfileView.trailingAnchor.constraint(equalTo: viewForNameAndShareButton.trailingAnchor)
            ])
        }
        else{
            NSLayoutConstraint.activate([
                shareProfileView.widthAnchor.constraint(equalToConstant: 0.35*view.frame.width),
                shareProfileView.heightAnchor.constraint(equalTo: viewForNameAndShareButton.heightAnchor),
                shareProfileView.trailingAnchor.constraint(equalTo: viewForNameAndShareButton.trailingAnchor)
            ])
        }
    }
    
    func loadSharelabel() {
        shareLabel.translatesAutoresizingMaskIntoConstraints = false
        
        shareLabel.textColor = .systemBlue
        
        NSLayoutConstraint.activate([
            shareLabel.widthAnchor.constraint(equalTo: shareProfileView.widthAnchor, multiplier: 0.7),
            shareLabel.bottomAnchor.constraint(equalTo: shareImageView.bottomAnchor,constant: 7)
        ])
    }
    
    func loadShareImageView() {
        shareImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shareImageView.trailingAnchor.constraint(equalTo: shareProfileView.trailingAnchor),
            shareImageView.leadingAnchor.constraint(equalTo: shareLabel.trailingAnchor,constant: 5),
            shareImageView.centerYAnchor.constraint(equalTo: shareProfileView.centerYAnchor)
        ])
    }
    
    func loadProfileAndShareLineView() {
        profileAndShareLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileAndShareLineView.topAnchor.constraint(equalTo: viewForNameAndShareButton.bottomAnchor),
            profileAndShareLineView.leadingAnchor.constraint(equalTo: viewForNameAndShareButton.leadingAnchor),
            profileAndShareLineView.trailingAnchor.constraint(equalTo: viewForNameAndShareButton.trailingAnchor),
            profileAndShareLineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func addTapGesture(toView: UIView){
        let tapGesture = UITapGestureRecognizer()
        
        if toView == shareProfileView {
            tapGesture.addTarget(self, action: #selector(shareProfileTapped))
        }
        else if(toView == videoConsultButtonView){
            tapGesture.addTarget(self, action: #selector(bookVideoConsultTapped))
        }
        else if(toView == hospitalVisitButtonView) {
            tapGesture.addTarget(self, action: #selector(bookHospitalVisitTapped))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func shareProfileTapped(_ sender: UITapGestureRecognizer){
        let vc = ShareDoctorProfileVC(doctor: doctor)
        
        present(vc, animated: true, completion: nil)
    }
    
    func loadQualificationAndExperienceLabel(){
        designationAndExperienceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        designationAndExperienceLabel.text = "\(doctor.designation.specializationType.uppercased()) | \(doctor.experience)"
        
        designationAndExperienceLabel.textColor = .label
        
        NSLayoutConstraint.activate([
            designationAndExperienceLabel.topAnchor.constraint(equalTo: viewForNameAndShareButton.bottomAnchor),
            designationAndExperienceLabel.leadingAnchor.constraint(equalTo: viewForNameAndShareButton.leadingAnchor),
            designationAndExperienceLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
        ])
    }
    
    func loadRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let ratings = getRatedAttributedString(forRating: Int(doctor.ratings))
        
        ratings.append(NSMutableAttributedString(string: " \(doctor.ratings)"))
        
        ratingLabel.attributedText = ratings
        
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: designationAndExperienceLabel.topAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: viewForNameAndShareButton.trailingAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: designationAndExperienceLabel.trailingAnchor)
        ])
    }
    
    func loadViewForQualification() {
        viewForQualification.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewForQualification.heightAnchor.constraint(equalToConstant: 0.06*view.frame.height),
            viewForQualification.topAnchor.constraint(equalTo: designationAndExperienceLabel.bottomAnchor),
            viewForQualification.leadingAnchor.constraint(equalTo: designationAndExperienceLabel.leadingAnchor),
            viewForQualification.trailingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
        ])
    }
    
    func loadQualificationLabel() {
        qualificationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        qualificationLabel.text = doctor.qualification
        
        qualificationLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            qualificationLabel.topAnchor.constraint(equalTo: viewForQualification.topAnchor),
            qualificationLabel.leadingAnchor.constraint(equalTo: viewForQualification.leadingAnchor),
            qualificationLabel.trailingAnchor.constraint(equalTo: viewForQualification.trailingAnchor),
            qualificationLabel.bottomAnchor.constraint(equalTo: viewForQualification.bottomAnchor),
        ])
    }
    
    func loadQualificationLineView() {
        qualificationLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            qualificationLineView.topAnchor.constraint(equalTo: viewForQualification.bottomAnchor, constant: 5),
            qualificationLineView.leadingAnchor.constraint(equalTo: viewForQualification.leadingAnchor),
            qualificationLineView.trailingAnchor.constraint(equalTo: viewForQualification.trailingAnchor),
            qualificationLineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func loadViewForLocation() {
        viewForLocation.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewForLocation.topAnchor.constraint(equalTo: qualificationLineView.bottomAnchor, constant: -5),
            viewForLocation.leadingAnchor.constraint(equalTo: qualificationLineView.leadingAnchor),
            viewForLocation.trailingAnchor.constraint(equalTo: qualificationLineView.trailingAnchor),
            viewForLocation.heightAnchor.constraint(equalToConstant: 0.08*view.frame.height),
        ])
    }
    
    func loadLocationImageView() {
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "location.circle")?.withRenderingMode(.alwaysOriginal)
        
        locationImageView.image = image?.withTintColor(.secondaryLabel)
        
        NSLayoutConstraint.activate([
            locationImageView.centerYAnchor.constraint(equalTo: viewForLocation.centerYAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: viewForLocation.leadingAnchor)
        ])
    }
    
    func loadLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.text = doctor.location
        locationLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: viewForLocation.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor,constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: viewForLocation.trailingAnchor)
        ])
    }
    
    func loadViewForLanguagesKnown() {
        viewForLanguagesKnown.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewForLanguagesKnown.topAnchor.constraint(equalTo: viewForLocation.bottomAnchor, constant: -10),
            viewForLanguagesKnown.leadingAnchor.constraint(equalTo: viewForLocation.leadingAnchor),
            viewForLanguagesKnown.trailingAnchor.constraint(equalTo: viewForLocation.trailingAnchor),
            viewForLanguagesKnown.heightAnchor.constraint(equalToConstant: 0.04*view.frame.height),
        ])
    }
    
    
    func loadLanguagesKnownImageView(){
        languagesKnownImageView.translatesAutoresizingMaskIntoConstraints = false
    
        let image = UIImage(systemName: "person.wave.2.fill")?.withRenderingMode(.alwaysOriginal)
        
        languagesKnownImageView.image = image?.withTintColor(.secondaryLabel)
        
        NSLayoutConstraint.activate([
            languagesKnownImageView.centerYAnchor.constraint(equalTo: viewForLanguagesKnown.centerYAnchor),
            languagesKnownImageView.leadingAnchor.constraint(equalTo: viewForLanguagesKnown.leadingAnchor)
        ])
    }
    
    func loadLanguagesKnownLabel(){
        languagesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var languages = ""
        
        for char in doctor.languagesKnown{
            if(char == ","){
                languages+=" | "
            }
            else{
                languages+=String(char)
            }
        }
        
        languagesLabel.text = languages
        languagesLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            languagesLabel.centerYAnchor.constraint(equalTo: viewForLanguagesKnown.centerYAnchor),
            languagesLabel.leadingAnchor.constraint(equalTo: languagesKnownImageView.trailingAnchor,constant: 10)
        ])
    }
    
    func loadLanguagesKnownLineView() {
        languagesKnownLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            languagesKnownLineView.topAnchor.constraint(equalTo: viewForLanguagesKnown.bottomAnchor,constant: 5),
            languagesKnownLineView.leadingAnchor.constraint(equalTo: viewForLanguagesKnown.leadingAnchor),
            languagesKnownLineView.trailingAnchor.constraint(equalTo: viewForLanguagesKnown.trailingAnchor),
            languagesKnownLineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func loadViewForAvailability() {
        viewForAvailability.translatesAutoresizingMaskIntoConstraints = false
        
        if(view.frame.height > 1000){
            let constraints = [
                viewForAvailability.topAnchor.constraint(equalTo: languagesKnownLineView.bottomAnchor),
                viewForAvailability.leadingAnchor.constraint(equalTo: languagesKnownLineView.leadingAnchor),
                viewForAvailability.trailingAnchor.constraint(equalTo: languagesKnownLineView.trailingAnchor),
                viewForAvailability.heightAnchor.constraint(equalToConstant: 0.04*view.frame.height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
        else if(view.frame.height > 800){
            let constraints = [
                viewForAvailability.topAnchor.constraint(equalTo: languagesKnownLineView.bottomAnchor),
                viewForAvailability.leadingAnchor.constraint(equalTo: languagesKnownLineView.leadingAnchor),
                viewForAvailability.trailingAnchor.constraint(equalTo: languagesKnownLineView.trailingAnchor),
                viewForAvailability.heightAnchor.constraint(equalToConstant: 0.09*view.frame.height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
        else{
            let constraints = [
                viewForAvailability.topAnchor.constraint(equalTo: languagesKnownLineView.bottomAnchor),
                viewForAvailability.leadingAnchor.constraint(equalTo: languagesKnownLineView.leadingAnchor),
                viewForAvailability.trailingAnchor.constraint(equalTo: languagesKnownLineView.trailingAnchor),
                viewForAvailability.heightAnchor.constraint(equalToConstant: 0.12*view.frame.height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
    }
    
    func loadAvailabilityImageView() {
        availabilityImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "text.bubble")?.withRenderingMode(.alwaysOriginal)
        
        availabilityImageView.image = image?.withTintColor(.secondaryLabel)
        
        NSLayoutConstraint.activate([
            availabilityImageView.topAnchor.constraint(equalTo: viewForAvailability.topAnchor,constant: 5),
            availabilityImageView.leadingAnchor.constraint(equalTo: viewForAvailability.leadingAnchor),
        ])
    }
    
    func loadAvailabilityLabel() {
        availabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        availabilityLabel.text = "\(doctor.name) is available for a minimum of \(doctor.availableForAMinimumOf) days for free follow up chat post consultation. The same may be increased based the doctor's discretion."
        
        availabilityLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            availabilityLabel.topAnchor.constraint(equalTo: availabilityImageView.topAnchor,constant: -5),
            availabilityLabel.leadingAnchor.constraint(equalTo: availabilityImageView.trailingAnchor,constant: 5),
            availabilityLabel.widthAnchor.constraint(equalTo: viewForAvailability.widthAnchor, multiplier: 0.9),
            availabilityLabel.bottomAnchor.constraint(equalTo: viewForAvailability.bottomAnchor)
        ])
    }
    
    func loadCostView() {
        costView.translatesAutoresizingMaskIntoConstraints = false
        
        costView.backgroundColor = view.backgroundColor
        
        var width = 0.0
        
        if(view.frame.height > 800){
            let constraints = [
                costView.topAnchor.constraint(equalTo: viewForAvailability.bottomAnchor,constant: 15),
                costView.leadingAnchor.constraint(equalTo: viewForAvailability.leadingAnchor),
                costView.trailingAnchor.constraint(equalTo: viewForAvailability.trailingAnchor),
                costView.heightAnchor.constraint(equalToConstant: 0.15*view.frame.height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
        }
        else{
            let constraints = [
                costView.topAnchor.constraint(equalTo: viewForAvailability.bottomAnchor,constant: 15),
                costView.leadingAnchor.constraint(equalTo: viewForAvailability.leadingAnchor),
                costView.trailingAnchor.constraint(equalTo: viewForAvailability.trailingAnchor),
                costView.heightAnchor.constraint(equalToConstant: 0.2*view.frame.height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeactivate.append(constraint)
            }
            
            costView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 0.2*view.frame.height), cornerRadius: costView.layer.cornerRadius).cgPath
        }
        
        costView.layer.cornerRadius = 10
        
        costView.layer.shadowColor = UIColor.label.cgColor
        
        costView.layer.shadowOffset = CGSize(width: 0, height: 5)
        costView.layer.shadowRadius = 12
        costView.layer.shadowOpacity = 0.1
        costView.layer.masksToBounds = false
    }
    
    func loadVideoConsultView() {
        videoConsultView.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            videoConsultView.heightAnchor.constraint(equalTo: costView.heightAnchor, multiplier: 0.85),
            videoConsultView.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            videoConsultView.leadingAnchor.constraint(equalTo: costView.leadingAnchor,constant: 10),
            videoConsultView.trailingAnchor.constraint(equalTo: verticalLineView.leadingAnchor,constant: -10)
        ])
    }
    
    func loadVideoConsultLabel() {
        videoConsultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultLabel.text = "Video Consult"
        
        NSLayoutConstraint.activate([
            videoConsultLabel.centerXAnchor.constraint(equalTo: videoConsultView.centerXAnchor),
            videoConsultLabel.topAnchor.constraint(equalTo: videoConsultView.topAnchor,constant: 10)
        ])
    }
    
    func loadVideoConsultCostLabel() {
        videoConsultCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultCostLabel.text = "₹\(doctor.vedioConsultationCost)"
        
        NSLayoutConstraint.activate([
            videoConsultCostLabel.centerXAnchor.constraint(equalTo: videoConsultView.centerXAnchor),
            videoConsultCostLabel.topAnchor.constraint(equalTo: videoConsultLabel.bottomAnchor,constant: 5)
        ])
    }
    
    func loadVideoConsultAvailableAtLabel() {
        videoConsultAvailableAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let time = Int.random(in: Range(uncheckedBounds: (1,59)))
        
        videoConsultAvailableAtLabel.text = "Available in \(time)mins"
        
        if(UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .unspecified) {
            if(UIScreen.main.traitCollection.userInterfaceStyle == .dark) {
                videoConsultAvailableAtLabel.backgroundColor = .secondarySystemGroupedBackground
            }
            else{
                videoConsultAvailableAtLabel.backgroundColor = UIColor(red: 220/255, green: 235/255, blue: 237/255, alpha: 1)
            }
        }
        else if (UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .dark) {
            videoConsultAvailableAtLabel.backgroundColor = .secondarySystemGroupedBackground
        }
        else{
            videoConsultAvailableAtLabel.backgroundColor = UIColor(red: 220/255, green: 235/255, blue: 237/255, alpha: 1)
        }
        
        NSLayoutConstraint.activate([
            videoConsultAvailableAtLabel.centerXAnchor.constraint(equalTo: videoConsultView.centerXAnchor),
            videoConsultAvailableAtLabel.topAnchor.constraint(equalTo: videoConsultCostLabel.bottomAnchor,constant: 5)
        ])
        
        videoConsultAvailableAtLabel.layer.cornerRadius = 10
    }
    
    func loadVerticalView() {
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalLineView.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            verticalLineView.heightAnchor.constraint(equalTo: costView.heightAnchor, multiplier: 0.6),
            verticalLineView.widthAnchor.constraint(equalToConstant: 1),
            verticalLineView.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            verticalLineView.centerXAnchor.constraint(equalTo: costView.centerXAnchor)
        ])
    }
    
    func loadHospitalConsultView() {
        hospitalConsultView.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalConsultView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            hospitalConsultView.heightAnchor.constraint(equalTo: costView.heightAnchor, multiplier: 0.85),
            hospitalConsultView.centerYAnchor.constraint(equalTo: costView.centerYAnchor),
            hospitalConsultView.leadingAnchor.constraint(equalTo: verticalLineView.trailingAnchor,constant: 10),
            hospitalConsultView.trailingAnchor.constraint(equalTo: costView.trailingAnchor,constant: -10)
        ])
    }
    
    func loadHospitalConsultLabel() {
        hospitalConsultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalConsultLabel.text = "Hospital Visit"
        
        NSLayoutConstraint.activate([
            hospitalConsultLabel.centerXAnchor.constraint(equalTo: hospitalConsultView.centerXAnchor),
            hospitalConsultLabel.topAnchor.constraint(equalTo: hospitalConsultView.topAnchor, constant: 10),
        ])
    }
    
    func loadHospitalConsultCostLabel() {
        hospitalConsultCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalConsultCostLabel.text = "₹\(doctor.hospitalVisitCost)"
        
        NSLayoutConstraint.activate([
            hospitalConsultCostLabel.centerXAnchor.constraint(equalTo: hospitalConsultView.centerXAnchor),
            hospitalConsultCostLabel.topAnchor.constraint(equalTo: hospitalConsultLabel.bottomAnchor,constant: 5)
        ])
    }
    
    func loadHospitalConsultAvailableAtLabel() {
        hospitalConsultAvailableAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let time = Int.random(in: Range(uncheckedBounds: (1,59)))
        
        hospitalConsultAvailableAtLabel.text = "Available in \(time)mins"
        
        if(UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .unspecified) {
            if(UIScreen.main.traitCollection.userInterfaceStyle == .dark) {
                hospitalConsultAvailableAtLabel.backgroundColor = .secondarySystemGroupedBackground
            }
            else{
                hospitalConsultAvailableAtLabel.backgroundColor = UIColor(red: 220/255, green: 235/255, blue: 237/255, alpha: 1)
            }
        }
        else if (UIApplication.shared.keyWindow?.overrideUserInterfaceStyle == .dark) {
            hospitalConsultAvailableAtLabel.backgroundColor = .secondarySystemGroupedBackground
        }
        else{
            hospitalConsultAvailableAtLabel.backgroundColor = UIColor(red: 220/255, green: 235/255, blue: 237/255, alpha: 1)
        }
        
        NSLayoutConstraint.activate([
            hospitalConsultAvailableAtLabel.centerXAnchor.constraint(equalTo: hospitalConsultView.centerXAnchor),
            hospitalConsultAvailableAtLabel.topAnchor.constraint(equalTo: hospitalConsultCostLabel.bottomAnchor,constant: 5)
        ])
        
        hospitalConsultAvailableAtLabel.layer.cornerRadius = 10
    }
    
    func loadSeeAllDoctorReviews() {
        seeAllDoctorReviewsButton.translatesAutoresizingMaskIntoConstraints = false
        
        seeAllDoctorReviewsButton.addTarget(self, action: #selector(didTapSeeAllReviews), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            seeAllDoctorReviewsButton.topAnchor.constraint(equalTo: costView.bottomAnchor, constant: 10),
            seeAllDoctorReviewsButton.leadingAnchor.constraint(equalTo: costView.leadingAnchor),
            seeAllDoctorReviewsButton.trailingAnchor.constraint(equalTo: costView.trailingAnchor)
        ])
    }
    
    func loadInformationView() {
        informationView.translatesAutoresizingMaskIntoConstraints = false
        
        informationView.backgroundColor = view.backgroundColor
        informationView.layer.cornerRadius = 10
        
        var width = 0.0
        var constraints: [NSLayoutConstraint] = []
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular && isFromBookAgain == false){
            
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                constraints = [
                    informationView.topAnchor.constraint(equalTo: seeAllDoctorReviewsButton.bottomAnchor,constant: 10),
                    informationView.leadingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.leadingAnchor),
                    informationView.trailingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.trailingAnchor),
                    informationView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
                ]
            }
            else{
                constraints = [
                    informationView.topAnchor.constraint(equalTo: seeAllDoctorReviewsButton.bottomAnchor,constant: 10),
                    informationView.leadingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.leadingAnchor),
                    informationView.trailingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.trailingAnchor),
                    informationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
                ]
            }
        }
        else{
            if(view.frame.height > 1000){
                constraints = [
                    informationView.topAnchor.constraint(equalTo: seeAllDoctorReviewsButton.bottomAnchor,constant: 10),
                    informationView.leadingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.leadingAnchor),
                    informationView.trailingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.trailingAnchor),
                    informationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
                ]
                
                
                informationView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 0.3*view.frame.height), cornerRadius: costView.layer.cornerRadius).cgPath
            }
            else if(view.frame.height > 800){
                constraints = [
                    informationView.topAnchor.constraint(equalTo: seeAllDoctorReviewsButton.bottomAnchor,constant: 10),
                    informationView.leadingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.leadingAnchor),
                    informationView.trailingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.trailingAnchor),
                    informationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
                ]
                
                
                informationView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 0.4*view.frame.height), cornerRadius: costView.layer.cornerRadius).cgPath
            }
            else if(view.frame.height < 600){
                constraints = [
                    informationView.topAnchor.constraint(equalTo: seeAllDoctorReviewsButton.bottomAnchor,constant: 10),
                    informationView.leadingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.leadingAnchor),
                    informationView.trailingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.trailingAnchor),
                    informationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
                ]
                
                
                informationView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 0.6*view.frame.height), cornerRadius: costView.layer.cornerRadius).cgPath
            }
            else{
                constraints = [
                    informationView.topAnchor.constraint(equalTo: seeAllDoctorReviewsButton.bottomAnchor,constant: 10),
                    informationView.leadingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.leadingAnchor),
                    informationView.trailingAnchor.constraint(equalTo: seeAllDoctorReviewsButton.trailingAnchor),
                    informationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                ]
                
                
                informationView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 0.5*view.frame.height), cornerRadius: costView.layer.cornerRadius).cgPath
            }
        }
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
        
        informationView.layer.shadowColor = UIColor.label.cgColor
        
        informationView.layer.shadowOffset = CGSize(width: 0, height: 5)
        informationView.layer.shadowRadius = 12
        informationView.layer.shadowOpacity = 0.1
        informationView.layer.masksToBounds = false
        
    }
    
    func loadInAppAudioVedioLabel() {
        inAppAudioVideoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        inAppAudioVideoLabel.text = "Quick Help !"
        
        NSLayoutConstraint.activate([
            inAppAudioVideoLabel.topAnchor.constraint(equalTo: informationView.topAnchor,constant: 10),
            inAppAudioVideoLabel.leadingAnchor.constraint(equalTo: informationView.leadingAnchor,constant: 10),
            inAppAudioVideoLabel.trailingAnchor.constraint(equalTo: costLabel.leadingAnchor)
        ])
    }
    
    func loadCostLabel() {
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: informationView.topAnchor,constant: 10),
            costLabel.trailingAnchor.constraint(equalTo: informationView.trailingAnchor,constant: -15)
        ])
    }
    
    func loadAvailableInLabel() {
        availableInLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            availableInLabel.topAnchor.constraint(equalTo: inAppAudioVideoLabel.bottomAnchor,constant: 10),
            availableInLabel.leadingAnchor.constraint(equalTo: inAppAudioVideoLabel.leadingAnchor)
        ])
    }
    
    func loadInformationLineView() {
        informationLineView.translatesAutoresizingMaskIntoConstraints = false
        
        informationLineView.backgroundColor = .systemGray
        
        NSLayoutConstraint.activate([
            informationLineView.topAnchor.constraint(equalTo: inAppAudioVideoLabel.bottomAnchor,constant: 10),
            informationLineView.leadingAnchor.constraint(equalTo: inAppAudioVideoLabel.leadingAnchor),
            informationLineView.trailingAnchor.constraint(equalTo: costLabel.trailingAnchor),
            informationLineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    func loadInformationQusetionLabel() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.text = "How to consult via text/audio/video?"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: informationLineView.bottomAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: inAppAudioVideoLabel.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: inAppAudioVideoLabel.trailingAnchor)
        ])
    }
    
    func loadDoctorImageView() {
        doctorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal)
        doctorImageView.image = image?.withTintColor(.label)
        
        NSLayoutConstraint.activate([
            doctorImageView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,constant: 10),
            doctorImageView.leadingAnchor.constraint(equalTo: inAppAudioVideoLabel.leadingAnchor)
        ])
    }
    
    func loadInfoViewDoctorLabel() {
        infoViewDoctorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoViewDoctorLabel.text = "Choose the doctor"
        
        NSLayoutConstraint.activate([
            infoViewDoctorLabel.centerYAnchor.constraint(equalTo: doctorImageView.centerYAnchor),
            infoViewDoctorLabel.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor,constant: 15)
        ])
    }
    
    func loadSlotImageView() {
        slotImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "calendar.badge.plus")?.withRenderingMode(.alwaysOriginal)
        slotImageView.image = image?.withTintColor(.label)
        
        NSLayoutConstraint.activate([
            slotImageView.topAnchor.constraint(equalTo: doctorImageView.bottomAnchor,constant: 10),
            slotImageView.leadingAnchor.constraint(equalTo: doctorImageView.leadingAnchor)
        ])
    }
    
    func loadInfoViewSlotLabel() {
        infoViewSlotLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoViewSlotLabel.text = "Book a Slot"
        
        NSLayoutConstraint.activate([
            infoViewSlotLabel.centerYAnchor.constraint(equalTo: slotImageView.centerYAnchor),
            infoViewSlotLabel.leadingAnchor.constraint(equalTo: infoViewDoctorLabel.leadingAnchor)
        ])
    }
    
    func loadCardImageView() {
        creditCardImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "creditcard")?.withRenderingMode(.alwaysOriginal)
        
        creditCardImageView.image = image?.withTintColor(.label)
        
        NSLayoutConstraint.activate([
            creditCardImageView.topAnchor.constraint(equalTo: slotImageView.bottomAnchor,constant: 10),
            creditCardImageView.leadingAnchor.constraint(equalTo: slotImageView.leadingAnchor)
        ])
    }
    
    func loadInfoViewCardLabel() {
        infoViewCreditCardLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoViewCreditCardLabel.text = "Make payment"
        
        NSLayoutConstraint.activate([
            infoViewCreditCardLabel.centerYAnchor.constraint(equalTo: creditCardImageView.centerYAnchor),
            infoViewCreditCardLabel.leadingAnchor.constraint(equalTo: infoViewSlotLabel.leadingAnchor)
        ])
    }
    
    func loadAppImageView() {
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "app.badge.checkmark")?.withRenderingMode(.alwaysOriginal)
        
        appImageView.image = image?.withTintColor(.label)
        
        NSLayoutConstraint.activate([
            appImageView.topAnchor.constraint(equalTo: creditCardImageView.bottomAnchor,constant: 10),
            appImageView.leadingAnchor.constraint(equalTo: creditCardImageView.leadingAnchor)
        ])
    }
    
    func loadInfoViewAppLabel() {
        infoViewAppLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoViewAppLabel.text = "Be present with app during consultation"
        
        NSLayoutConstraint.activate([
            infoViewAppLabel.centerYAnchor.constraint(equalTo: appImageView.centerYAnchor),
            infoViewAppLabel.leadingAnchor.constraint(equalTo: infoViewCreditCardLabel.leadingAnchor)
        ])
    }
    
    func loadCameraImageView() {
        cameraImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "video")?.withRenderingMode(.alwaysOriginal)
        
        cameraImageView.image = image?.withTintColor(.label)
        
        NSLayoutConstraint.activate([
            cameraImageView.topAnchor.constraint(equalTo: appImageView.bottomAnchor,constant: 10),
            cameraImageView.leadingAnchor.constraint(equalTo: appImageView.leadingAnchor)
        ])
    }
    
    func loadInfoViewCameraLabel() {
        infoViewCameraLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoViewCameraLabel.text = "Speak to the doctor via Audio/Vedio/Text"
        
        NSLayoutConstraint.activate([
            infoViewCameraLabel.centerYAnchor.constraint(equalTo: cameraImageView.centerYAnchor),
            infoViewCameraLabel.leadingAnchor.constraint(equalTo: infoViewAppLabel.leadingAnchor)
        ])
    }
    
    func loadPrescriptionImageView() {
        prescriptionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "doc.plaintext")?.withRenderingMode(.alwaysOriginal)
        
        prescriptionImageView.image = image?.withTintColor(.label)
        
        NSLayoutConstraint.activate([
            prescriptionImageView.topAnchor.constraint(equalTo: cameraImageView.bottomAnchor,constant: 10),
            prescriptionImageView.leadingAnchor.constraint(equalTo: cameraImageView.leadingAnchor)
        ])
    }
    
    func loadInfoViewPrescriptionLabel() {
        infoViewPrescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoViewPrescriptionLabel.text = "Recieve Prescriptions Instantly"
        
        NSLayoutConstraint.activate([
            infoViewPrescriptionLabel.centerYAnchor.constraint(equalTo: prescriptionImageView.centerYAnchor),
            infoViewPrescriptionLabel.leadingAnchor.constraint(equalTo: infoViewCameraLabel.leadingAnchor)
        ])
    }
    
    func loadFollowUpImageView() {
        followUpImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "text.bubble")?.withRenderingMode(.alwaysOriginal)
        
        followUpImageView.image = image?.withTintColor(.label)
        
        NSLayoutConstraint.activate([
            followUpImageView.topAnchor.constraint(equalTo: prescriptionImageView.bottomAnchor,constant: 10),
            followUpImageView.leadingAnchor.constraint(equalTo: prescriptionImageView.leadingAnchor)
        ])
    }
    
    func loadInfoViewFollowUpLabel() {
        infoViewFollowUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoViewFollowUpLabel.text = "Follow up via text - Valid for 7 days"
        
        NSLayoutConstraint.activate([
            infoViewFollowUpLabel.centerYAnchor.constraint(equalTo: followUpImageView.centerYAnchor),
            infoViewFollowUpLabel.leadingAnchor.constraint(equalTo: infoViewPrescriptionLabel.leadingAnchor),
        ])
    }
    
    func loadPhysicalLocationLabel() {
        physicalLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        physicalLocationLabel.text = "\(doctor.name) for physical visits"
        
        physicalLocationLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        var constraints: [NSLayoutConstraint] = []
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular && isFromBookAgain == false){
            constraints = [
                physicalLocationLabel.topAnchor.constraint(equalTo: viewForProfileImage.topAnchor),
                physicalLocationLabel.widthAnchor.constraint(equalTo: viewForProfileImage.widthAnchor),
                physicalLocationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            ]
        }
        else{
            constraints = [
                physicalLocationLabel.topAnchor.constraint(equalTo: informationView.bottomAnchor,constant: 10),
                physicalLocationLabel.leadingAnchor.constraint(equalTo: informationView.leadingAnchor),
                physicalLocationLabel.trailingAnchor.constraint(equalTo: informationView.trailingAnchor)
            ]
        }
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
    }
    
    func loadPhysicalLocationView() {
        physicalLocationView.translatesAutoresizingMaskIntoConstraints = false
        
        physicalLocationView.backgroundColor = view.backgroundColor
        
        NSLayoutConstraint.activate([
            physicalLocationView.topAnchor.constraint(equalTo: physicalLocationLabel.bottomAnchor,constant: 10),
            physicalLocationView.leadingAnchor.constraint(equalTo: physicalLocationLabel.leadingAnchor),
            physicalLocationView.trailingAnchor.constraint(equalTo: physicalLocationLabel.trailingAnchor),
        ])
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular && isFromBookAgain == false){
            physicalLocationView.heightAnchor.constraint(equalToConstant: 0.2*view.frame.height).isActive = true
            
            previousConstraintsToDeactivate.append(physicalLocationView.heightAnchor.constraint(equalToConstant: 0.2*view.frame.height))
        }
        else{
            physicalLocationView.heightAnchor.constraint(equalToConstant: 0.3*view.frame.height).isActive = true
            
            previousConstraintsToDeactivate.append(physicalLocationView.heightAnchor.constraint(equalToConstant: 0.3*view.frame.height))
        }
        
        physicalLocationView.layer.shadowColor = UIColor.label.cgColor
        
        physicalLocationView.layer.cornerRadius = 10
        physicalLocationView.layer.shadowRadius = 8
        physicalLocationView.layer.shadowOpacity = 0.1
        physicalLocationView.layer.shadowOffset = CGSize(width: 2, height: 5)
        
    }
    
    func loadPhysicalLocationImageView() {
        physicalLocationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        physicalLocationImageView.downloaded(from: doctor.locationImageName)
        
        NSLayoutConstraint.activate([
            physicalLocationImageView.topAnchor.constraint(equalTo: physicalLocationView.topAnchor),
            physicalLocationImageView.leadingAnchor.constraint(equalTo: physicalLocationView.leadingAnchor),
            physicalLocationImageView.trailingAnchor.constraint(equalTo: physicalLocationView.trailingAnchor),
            physicalLocationImageView.heightAnchor.constraint(equalTo: physicalLocationView.heightAnchor, multiplier: 0.7)
        ])
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 0.3*0.7*view.frame.height),
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 10, height:  10))

        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        physicalLocationImageView.layer.mask = maskLayer
    }
    
    func loadPhysicalLocationAddressLabel() {
        physicalLocationAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        physicalLocationAddressLabel.text = doctor.locationAddress
        
        NSLayoutConstraint.activate([
            physicalLocationAddressLabel.topAnchor.constraint(equalTo: physicalLocationImageView.bottomAnchor),
            physicalLocationAddressLabel.leadingAnchor.constraint(equalTo: physicalLocationView.leadingAnchor,constant: 5),
            physicalLocationAddressLabel.trailingAnchor.constraint(equalTo: physicalLocationView.trailingAnchor),
            physicalLocationAddressLabel.bottomAnchor.constraint(equalTo: physicalLocationView.bottomAnchor)
        ])
    }
    
    func loadTimingsView() {
        timingsView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular && isFromBookAgain == false){
            constraints = [
                timingsView.topAnchor.constraint(equalTo: physicalLocationView.bottomAnchor,constant: 15),
                timingsView.leadingAnchor.constraint(equalTo: physicalLocationView.leadingAnchor),
                timingsView.trailingAnchor.constraint(equalTo: physicalLocationView.trailingAnchor),
                timingsView.heightAnchor.constraint(equalToConstant: 0.4*view.frame.height),
            ]
        }
        else{
            if(view.frame.height > 1000){
                constraints = [
                    timingsView.topAnchor.constraint(equalTo: physicalLocationView.bottomAnchor,constant: 15),
                    timingsView.leadingAnchor.constraint(equalTo: physicalLocationView.leadingAnchor),
                    timingsView.trailingAnchor.constraint(equalTo: physicalLocationView.trailingAnchor),
                    timingsView.heightAnchor.constraint(equalToConstant: 0.4*view.frame.height),
                ]
            }
            else if(view.frame.height > 800){
                constraints = [
                    timingsView.topAnchor.constraint(equalTo: physicalLocationView.bottomAnchor,constant: 15),
                    timingsView.leadingAnchor.constraint(equalTo: physicalLocationView.leadingAnchor),
                    timingsView.trailingAnchor.constraint(equalTo: physicalLocationView.trailingAnchor),
                    timingsView.heightAnchor.constraint(equalToConstant: 0.6*view.frame.height),
                ]
            }
            else if(view.frame.height < 600){
                constraints = [
                    timingsView.topAnchor.constraint(equalTo: physicalLocationView.bottomAnchor,constant: 15),
                    timingsView.leadingAnchor.constraint(equalTo: physicalLocationView.leadingAnchor),
                    timingsView.trailingAnchor.constraint(equalTo: physicalLocationView.trailingAnchor),
                    timingsView.heightAnchor.constraint(equalToConstant: 0.72*view.frame.height),
                ]
            }
            else{
                constraints = [
                    timingsView.topAnchor.constraint(equalTo: physicalLocationView.bottomAnchor,constant: 15),
                    timingsView.leadingAnchor.constraint(equalTo: physicalLocationView.leadingAnchor),
                    timingsView.trailingAnchor.constraint(equalTo: physicalLocationView.trailingAnchor),
                    timingsView.heightAnchor.constraint(equalToConstant: 0.72*view.frame.height),
                ]
            }
        }
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
    }
    
    func loadTimingsLabel(){
        timingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timingsLabel.text = "Timings"
        
        NSLayoutConstraint.activate([
            timingsLabel.topAnchor.constraint(equalTo: timingsView.topAnchor),
            timingsLabel.leadingAnchor.constraint(equalTo: timingsView.leadingAnchor),
            timingsLabel.trailingAnchor.constraint(equalTo: timingsView.trailingAnchor)
        ])
    }
    
    func loadTimingsVideoConsultLabel() {
        timingsVideoConsultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timingsVideoConsultLabel.text = "Video Consult :"
        
        NSLayoutConstraint.activate([
            timingsVideoConsultLabel.topAnchor.constraint(equalTo: timingsLabel.bottomAnchor),
            timingsVideoConsultLabel.leadingAnchor.constraint(equalTo: timingsView.leadingAnchor),
            timingsVideoConsultLabel.trailingAnchor.constraint(equalTo: timingsView.trailingAnchor)
        ])
    }
    
    func loadVideoConsultMondayLabel() {
        videoConsultMondayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultMondayLabel.text = "Monday"
        
        NSLayoutConstraint.activate([
            videoConsultMondayLabel.topAnchor.constraint(equalTo: timingsVideoConsultLabel.bottomAnchor),
            videoConsultMondayLabel.leadingAnchor.constraint(equalTo: timingsVideoConsultLabel.leadingAnchor)
        ])
    }
    
    func loadVideoConsultMondayTimingLabel() {
        videoConsultMondayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultMondayTimingLabel.text = doctorProfileVCHelper.videoConsultTimings?.monday
        
        NSLayoutConstraint.activate([
            videoConsultMondayTimingLabel.topAnchor.constraint(equalTo: videoConsultMondayLabel.topAnchor),
            videoConsultMondayTimingLabel.trailingAnchor.constraint(equalTo: timingsVideoConsultLabel.trailingAnchor),
            videoConsultMondayTimingLabel.leadingAnchor.constraint(equalTo: videoConsultMondayLabel.trailingAnchor)
        ])
    }
    
    func loadVideoConsultTuesdayLabel() {
        videoConsultTuesdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultTuesdayLabel.text = "Tuesday"
        
        NSLayoutConstraint.activate([
            videoConsultTuesdayLabel.topAnchor.constraint(equalTo: videoConsultMondayLabel.bottomAnchor),
            videoConsultTuesdayLabel.leadingAnchor.constraint(equalTo: videoConsultMondayLabel.leadingAnchor)
        ])
    }
    
    func loadVideoConsultTuesdayTimingLabel() {
        videoConsultTuesdayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultTuesdayTimingLabel.text = doctorProfileVCHelper.videoConsultTimings?.tuesday
        
        NSLayoutConstraint.activate([
            videoConsultTuesdayTimingLabel.topAnchor.constraint(equalTo: videoConsultTuesdayLabel.topAnchor),
            videoConsultTuesdayTimingLabel.trailingAnchor.constraint(equalTo: videoConsultMondayTimingLabel.trailingAnchor),
            videoConsultTuesdayTimingLabel.leadingAnchor.constraint(equalTo: videoConsultTuesdayLabel.trailingAnchor)
        ])
    }
    
    func loadVideoConsultWednesdayLabel() {
        videoConsultWednesdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultWednesdayLabel.text = "Wednesday"
        
        NSLayoutConstraint.activate([
            videoConsultWednesdayLabel.topAnchor.constraint(equalTo: videoConsultTuesdayLabel.bottomAnchor),
            videoConsultWednesdayLabel.leadingAnchor.constraint(equalTo: videoConsultTuesdayLabel.leadingAnchor)
        ])
    }
    
    func loadVideoConsultWednesdayTimingLabel() {
        videoConsultWednesdayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultWednesdayTimingLabel.text = doctorProfileVCHelper.videoConsultTimings?.wednesday
        
        NSLayoutConstraint.activate([
            videoConsultWednesdayTimingLabel.topAnchor.constraint(equalTo: videoConsultWednesdayLabel.topAnchor),
            videoConsultWednesdayTimingLabel.trailingAnchor.constraint(equalTo: videoConsultTuesdayTimingLabel.trailingAnchor),
            videoConsultWednesdayTimingLabel.leadingAnchor.constraint(equalTo: videoConsultWednesdayLabel.trailingAnchor)
        ])
    }
    
    func loadVideoConsultThursdayLabel() {
        videoConsultThursdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultThursdayLabel.text = "Thursday"
        
        NSLayoutConstraint.activate([
            videoConsultThursdayLabel.topAnchor.constraint(equalTo: videoConsultWednesdayLabel.bottomAnchor),
            videoConsultThursdayLabel.leadingAnchor.constraint(equalTo: videoConsultWednesdayLabel.leadingAnchor)
        ])
    }
    
    func loadVideoConsultThursdayTimingLabel() {
        videoConsultThursdayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultThursdayTimingLabel.text = doctorProfileVCHelper.videoConsultTimings?.thursday
        
        NSLayoutConstraint.activate([
            videoConsultThursdayTimingLabel.topAnchor.constraint(equalTo: videoConsultThursdayLabel.topAnchor),
            videoConsultThursdayTimingLabel.trailingAnchor.constraint(equalTo: videoConsultWednesdayTimingLabel.trailingAnchor),
            videoConsultThursdayTimingLabel.leadingAnchor.constraint(equalTo: videoConsultThursdayLabel.trailingAnchor)
        ])
    }
    
    func loadVideoConsultFridayLabel() {
        videoConsultFridayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultFridayLabel.text = "Friday"
        
        NSLayoutConstraint.activate([
            videoConsultFridayLabel.topAnchor.constraint(equalTo: videoConsultThursdayLabel.bottomAnchor),
            videoConsultFridayLabel.leadingAnchor.constraint(equalTo: videoConsultThursdayLabel.leadingAnchor)
        ])
    }
    
    func loadVideoConsultFridayTimingLabel() {
        videoConsultFridayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultFridayTimingLabel.text = doctorProfileVCHelper.videoConsultTimings?.friday
        
        NSLayoutConstraint.activate([
            videoConsultFridayTimingLabel.topAnchor.constraint(equalTo: videoConsultFridayLabel.topAnchor),
            videoConsultFridayTimingLabel.trailingAnchor.constraint(equalTo: videoConsultThursdayTimingLabel.trailingAnchor),
            videoConsultFridayTimingLabel.leadingAnchor.constraint(equalTo: videoConsultFridayLabel.trailingAnchor)
        ])
    }
    
    func loadVideoConsultSaturdayLabel() {
        videoConsultSaturdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultSaturdayLabel.text = "Saturday"
        
        NSLayoutConstraint.activate([
            videoConsultSaturdayLabel.topAnchor.constraint(equalTo: videoConsultFridayLabel.bottomAnchor),
            videoConsultSaturdayLabel.leadingAnchor.constraint(equalTo: videoConsultFridayLabel.leadingAnchor)
        ])
    }
    
    func loadVideoConsultSaturdayTimingLabel() {
        videoConsultSaturdayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultSaturdayTimingLabel.text = doctorProfileVCHelper.videoConsultTimings?.saturday
        
        NSLayoutConstraint.activate([
            videoConsultSaturdayTimingLabel.topAnchor.constraint(equalTo: videoConsultSaturdayLabel.topAnchor),
            videoConsultSaturdayTimingLabel.trailingAnchor.constraint(equalTo: videoConsultFridayTimingLabel.trailingAnchor),
            videoConsultSaturdayTimingLabel.leadingAnchor.constraint(equalTo: videoConsultSaturdayLabel.trailingAnchor)
        ])
    }
    
    func loadVideoConsultSundayLabel() {
        videoConsultSundayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultSundayLabel.text = "Sunday"
        
        NSLayoutConstraint.activate([
            videoConsultSundayLabel.topAnchor.constraint(equalTo: videoConsultSaturdayLabel.bottomAnchor),
            videoConsultSundayLabel.leadingAnchor.constraint(equalTo: videoConsultSaturdayLabel.leadingAnchor)
        ])
    }
    
    func loadVideoConsultSundayTimingLabel() {
        videoConsultSundayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        videoConsultSundayTimingLabel.text = doctorProfileVCHelper.videoConsultTimings?.sunday
        
        NSLayoutConstraint.activate([
            videoConsultSundayTimingLabel.topAnchor.constraint(equalTo: videoConsultSundayLabel.topAnchor),
            videoConsultSundayTimingLabel.trailingAnchor.constraint(equalTo: videoConsultSaturdayTimingLabel.trailingAnchor),
            videoConsultSundayTimingLabel.leadingAnchor.constraint(equalTo: videoConsultSundayLabel.trailingAnchor)
        ])
    }
    
    func loadTimingsHospitalVisitLabel() {
        timingsHospitalVisitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timingsHospitalVisitLabel.text = "Hospital Visit : "
        
        NSLayoutConstraint.activate([
            timingsHospitalVisitLabel.topAnchor.constraint(equalTo: videoConsultSundayLabel.bottomAnchor,constant: 10),
            timingsHospitalVisitLabel.leadingAnchor.constraint(equalTo: timingsVideoConsultLabel.leadingAnchor),
            timingsHospitalVisitLabel.trailingAnchor.constraint(equalTo: timingsVideoConsultLabel.trailingAnchor)
        ])
    }
    
    func loadHospitalVisitMondayLabel() {
        hospitalVisitMondayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitMondayLabel.text = "Monday"
        
        NSLayoutConstraint.activate([
            hospitalVisitMondayLabel.topAnchor.constraint(equalTo: timingsHospitalVisitLabel.bottomAnchor),
            hospitalVisitMondayLabel.leadingAnchor.constraint(equalTo: timingsHospitalVisitLabel.leadingAnchor)
        ])
    }
    
    func loadHospitalVisitMondayTimingLabel() {
        hospitalVisitMondayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitMondayTimingLabel.text = doctorProfileVCHelper.hospitalVisitTimings?.monday
        
        NSLayoutConstraint.activate([
            hospitalVisitMondayTimingLabel.topAnchor.constraint(equalTo: hospitalVisitMondayLabel.topAnchor),
            hospitalVisitMondayTimingLabel.trailingAnchor.constraint(equalTo: timingsHospitalVisitLabel.trailingAnchor),
            hospitalVisitMondayTimingLabel.leadingAnchor.constraint(equalTo: hospitalVisitMondayLabel.trailingAnchor)
        ])
    }
    
    func loadHospitalVisitTuesdayLabel() {
        hospitalVisitTuesdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitTuesdayLabel.text = "Tuesday"
        
        NSLayoutConstraint.activate([
            hospitalVisitTuesdayLabel.topAnchor.constraint(equalTo: hospitalVisitMondayLabel.bottomAnchor),
            hospitalVisitTuesdayLabel.leadingAnchor.constraint(equalTo: hospitalVisitMondayLabel.leadingAnchor)
        ])
    }
    
    func loadHospitalVisitTuesdayTimingLabel() {
        hospitalVisitTuesdayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitTuesdayTimingLabel.text = doctorProfileVCHelper.hospitalVisitTimings?.tuesday
        
        NSLayoutConstraint.activate([
            hospitalVisitTuesdayTimingLabel.topAnchor.constraint(equalTo: hospitalVisitTuesdayLabel.topAnchor),
            hospitalVisitTuesdayTimingLabel.trailingAnchor.constraint(equalTo: hospitalVisitMondayTimingLabel.trailingAnchor),
            hospitalVisitTuesdayTimingLabel.leadingAnchor.constraint(equalTo: hospitalVisitTuesdayLabel.trailingAnchor)
        ])
    }
    
    func loadHospitalVisitWednesdayLabel() {
        hospitalVisitWednesdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitWednesdayLabel.text = "Wednesday"
        
        NSLayoutConstraint.activate([
            hospitalVisitWednesdayLabel.topAnchor.constraint(equalTo: hospitalVisitTuesdayLabel.bottomAnchor),
            hospitalVisitWednesdayLabel.leadingAnchor.constraint(equalTo: hospitalVisitTuesdayLabel.leadingAnchor)
        ])
    }
    
    func loadHospitalVisitWednesdayTimingLabel() {
        hospitalVisitWednesdayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitWednesdayTimingLabel.text = doctorProfileVCHelper.hospitalVisitTimings?.wednesday
        
        NSLayoutConstraint.activate([
            hospitalVisitWednesdayTimingLabel.topAnchor.constraint(equalTo: hospitalVisitWednesdayLabel.topAnchor),
            hospitalVisitWednesdayTimingLabel.trailingAnchor.constraint(equalTo: hospitalVisitTuesdayTimingLabel.trailingAnchor),
            hospitalVisitWednesdayTimingLabel.leadingAnchor.constraint(equalTo: hospitalVisitWednesdayLabel.trailingAnchor)
        ])
    }
    
    func loadHospitalVisitThursdayLabel() {
        hospitalVisitThursdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitThursdayLabel.text = "Thursday"
        
        NSLayoutConstraint.activate([
            hospitalVisitThursdayLabel.topAnchor.constraint(equalTo: hospitalVisitWednesdayLabel.bottomAnchor),
            hospitalVisitThursdayLabel.leadingAnchor.constraint(equalTo: hospitalVisitWednesdayLabel.leadingAnchor)
        ])
    }
    
    func loadHospitalVisitThursdayTimingLabel() {
        hospitalVisitThursdayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitThursdayTimingLabel.text = doctorProfileVCHelper.hospitalVisitTimings?.thursday
        
        NSLayoutConstraint.activate([
            hospitalVisitThursdayTimingLabel.topAnchor.constraint(equalTo: hospitalVisitThursdayLabel.topAnchor),
            hospitalVisitThursdayTimingLabel.trailingAnchor.constraint(equalTo: hospitalVisitWednesdayTimingLabel.trailingAnchor),
            hospitalVisitThursdayTimingLabel.leadingAnchor.constraint(equalTo: hospitalVisitThursdayLabel.trailingAnchor)
        ])
    }
    
    func loadHospitalVisitFridayLabel() {
        hospitalVisitFridayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitFridayLabel.text = "Friday"
        
        NSLayoutConstraint.activate([
            hospitalVisitFridayLabel.topAnchor.constraint(equalTo: hospitalVisitThursdayLabel.bottomAnchor),
            hospitalVisitFridayLabel.leadingAnchor.constraint(equalTo: hospitalVisitThursdayLabel.leadingAnchor)
        ])
    }
    
    func loadHospitalVisitFridayTimingLabel() {
        hospitalVisitFridayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitFridayTimingLabel.text = doctorProfileVCHelper.hospitalVisitTimings?.friday
        
        NSLayoutConstraint.activate([
            hospitalVisitFridayTimingLabel.topAnchor.constraint(equalTo: hospitalVisitFridayLabel.topAnchor),
            hospitalVisitFridayTimingLabel.trailingAnchor.constraint(equalTo: hospitalVisitThursdayTimingLabel.trailingAnchor),
            hospitalVisitFridayTimingLabel.leadingAnchor.constraint(equalTo: hospitalVisitFridayLabel.trailingAnchor)
        ])
    }
    
    func loadHospitalVisitSaturdayLabel() {
        hospitalVisitSaturdayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitSaturdayLabel.text = "Saturday"
        
        NSLayoutConstraint.activate([
            hospitalVisitSaturdayLabel.topAnchor.constraint(equalTo: hospitalVisitFridayLabel.bottomAnchor),
            hospitalVisitSaturdayLabel.leadingAnchor.constraint(equalTo: hospitalVisitFridayLabel.leadingAnchor)
        ])
    }
    
    func loadHospitalVisitSaturdayTimingLabel() {
        hospitalVisitSaturdayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitSaturdayTimingLabel.text = doctorProfileVCHelper.hospitalVisitTimings?.saturday
        
        NSLayoutConstraint.activate([
            hospitalVisitSaturdayTimingLabel.topAnchor.constraint(equalTo: hospitalVisitSaturdayLabel.topAnchor),
            hospitalVisitSaturdayTimingLabel.trailingAnchor.constraint(equalTo: hospitalVisitFridayTimingLabel.trailingAnchor),
            hospitalVisitSaturdayTimingLabel.leadingAnchor.constraint(equalTo: hospitalVisitSaturdayLabel.trailingAnchor)
        ])
    }

    func loadHospitalVisitSundayLabel() {
        hospitalVisitSundayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitSundayLabel.text = "Sunday"
        
        NSLayoutConstraint.activate([
            hospitalVisitSundayLabel.topAnchor.constraint(equalTo: hospitalVisitSaturdayLabel.bottomAnchor),
            hospitalVisitSundayLabel.leadingAnchor.constraint(equalTo: hospitalVisitSaturdayLabel.leadingAnchor)
        ])
    }
    
    func loadHospitalVisitSundayTimingLabel() {
        hospitalVisitSundayTimingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hospitalVisitSundayTimingLabel.text = doctorProfileVCHelper.hospitalVisitTimings?.sunday
        
        NSLayoutConstraint.activate([
            hospitalVisitSundayTimingLabel.topAnchor.constraint(equalTo: hospitalVisitSundayLabel.topAnchor),
            hospitalVisitSundayTimingLabel.trailingAnchor.constraint(equalTo: hospitalVisitSaturdayTimingLabel.trailingAnchor),
            hospitalVisitSundayTimingLabel.leadingAnchor.constraint(equalTo: hospitalVisitSundayLabel.trailingAnchor)
        ])
    }
    
    func loadSeperatorView() {
        seperatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            seperatorView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.0),
            seperatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seperatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seperatorView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -(bottomViewHeight))
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular && isFromBookAgain == false) {
            let topAnchor = seperatorView.topAnchor.constraint(equalTo: informationView.bottomAnchor, constant: 35)
            
            topAnchor.isActive = true
            
            previousConstraintsToDeactivate.append(topAnchor)
        }
        else {
            let topAnchor = seperatorView.topAnchor.constraint(equalTo: timingsView.bottomAnchor, constant: 5)
            
            topAnchor.isActive = true
            
            previousConstraintsToDeactivate.append(topAnchor)
        }
    }
    
    @objc func didTapSeeAllReviews(_ sender: UIButton) {
        print("See All Doctor Reviews Tapped.")
        
        guard let requirments = doctorProfileVCHelper.requirments else {
            return
        }
        
        let seeAllReviewsVC = SeeAllReviewsVC(requirments: requirments,doctor: doctor, isFromDoctorVC: true)
        
        navigationController?.pushViewController(seeAllReviewsVC, animated: true)
    }
}

extension DoctorProfileVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if(offset.y > nameLabel.frame.height + viewForProfileImage.frame.height) {
            self.title = doctor.name
        }
        else {
            self.title = ""
        }
    }
}

extension DoctorProfileVC {
    func getRatedAttributedString(forRating: Int) -> NSMutableAttributedString {
        let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        
        let imageToAppend = NSTextAttachment()
        
        imageToAppend.image = image?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
        
        imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
        
        let mutableString = NSMutableAttributedString(attachment: imageToAppend)
        
        return mutableString
    }
}

extension DoctorProfileVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
    }
}
