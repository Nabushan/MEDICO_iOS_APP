//
//  PharmacyProfileVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 07/10/22.
//

import UIKit

class PharmacyProfileVC: UIViewController, PharmacyProfileProtocol {

    let pharmacyLink = "https://goo.gl/maps/pHaQ16mz4jSggpg77"
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.isScrollEnabled = true
        
        return scrollView
    }()
    
    lazy var  viewForProfileInfo: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var viewForImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var viewForProductsCollectionView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var viewForReviewsAndRatings: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var produtsLabel: ResizedLabel = {
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
    
    lazy var seeMoreButton: ResizedButton = {
        let button = ResizedButton()
        
        button.contentMode = .center
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        
        return button
    }()
    
    lazy var productCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutProvider.getPharmacyMedicineLayout())
        
        collectionView.register(PharmacyProfileCollectionViewCell.self, forCellWithReuseIdentifier: PharmacyProfileCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    lazy var reviewCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutProvider.getPharmacyReviewLavout())
        
        collectionView.register(PharmacyReviewCollectionViewCell.self, forCellWithReuseIdentifier: PharmacyReviewCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let layoutProvider = CollectionViewLayoutProvider()
    
    lazy var thumbNailImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.downloaded(from: "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg")
        
        return imageView
    }()
    
    lazy var pharmacyImage: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        
        activity.startAnimating()
        
        return activity
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
        label.font = UIFont(name: "Helvetica", size: 20)
        
        return label
    }()
    
    lazy var addressAndInfoLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    lazy var ratingsLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var locationDistanceView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var directionsView: UIView = {
        let view = UIView()
        
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var directionLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var directionImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var distanceLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var distanceImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var ratingsAndReviewLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
    lazy var seeAllButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("See All", for: .normal)
        button.titleLabel?.textColor = .systemBlue
        button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
        
        return button
    }()
    
    lazy var finalRatingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    lazy var fiveStarProgressView: UIProgressView = {
        let view = UIProgressView()
        
        view.progressTintColor = .systemGray
        
        return view
    }()
    
    lazy var fiveStarLabel: ResizedLabel = {
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
    
    lazy var fourStarProgressView: UIProgressView = {
        let view = UIProgressView()
        
        view.progressTintColor = .systemGray
        
        return view
    }()
    
    lazy var fourStarLabel: ResizedLabel = {
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
    
    lazy var threeStarProgressView: UIProgressView = {
        let view = UIProgressView()
        
        view.progressTintColor = .systemGray
        
        return view
    }()
    
    lazy var threeStarLabel: ResizedLabel = {
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
    
    lazy var twoStarProgressView: UIProgressView = {
        let view = UIProgressView()
        
        view.progressTintColor = .systemGray
        
        return view
    }()
    
    lazy var twoStarLabel: ResizedLabel = {
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
    
    lazy var oneStarProgressView: UIProgressView = {
        let view = UIProgressView()
        
        view.progressTintColor = .systemGray
        
        return view
    }()
    
    lazy var oneStarLabel: ResizedLabel = {
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
    
    lazy var outOfFiveLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .bold)
        
        return label
    }()
    
    lazy var totalRatingsLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var productCollectionViewLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var ratingLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var writeAReviewLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var tapToRateLabel: ResizedLabel = {
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
        
        return label
    }()
    
    lazy var starButtonOne: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 1
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starButtonTwo: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 2
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starButtonThree: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 3
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starButtonFour: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 4
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starButtonFive: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 5
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.contentMode = .right
        
        return stackView
    }()
    
    lazy var writeAReviewView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var writeAReviewImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var writeAReviewLabel: ResizedLabel = {
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
        
        return label
    }()
    
    var starButtonArray: [ResizedButton] = []
    
    let pharmacyProfileHelperVC: PharmacyProfileHelperVC
    
    let pharmacy: Pharmacy
    var userSelectedStarRating: Int = 0
    var isRated = false
    var previousConstraintToDeActivate: [NSLayoutConstraint] = []
    
    init(pharmacy: Pharmacy){
        self.pharmacy = pharmacy
        pharmacyProfileHelperVC = PharmacyProfileHelperVC(reviewId: pharmacy.reviewId, ratingId: pharmacy.ratingId, productId: pharmacy.productBatchId, pharmacyId: pharmacy.id)
        
        super.init(nibName: nil, bundle: nil)
        
        pharmacyProfileHelperVC.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapStarRating), name: Notification.Name("NotificationIdentifier_StarRating"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reviewAdded), name: Notification.Name("NotificationIdentifier_ReviewAdded"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier_StarRating"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier_ReviewAdded"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(viewForProfileInfo)
        viewForProfileInfo.addSubview(viewForImage)
        viewForImage.addSubview(thumbNailImage)
        viewForImage.addSubview(activityIndicator)
        viewForImage.addSubview(pharmacyImage)
        
        viewForProfileInfo.addSubview(nameLabel)
        viewForProfileInfo.addSubview(addressAndInfoLabel)
        viewForProfileInfo.addSubview(ratingsLabel)
        viewForProfileInfo.addSubview(locationDistanceView)
        locationDistanceView.addSubview(distanceImageView)
        locationDistanceView.addSubview(distanceLabel)
        viewForProfileInfo.addSubview(directionsView)
        directionsView.addSubview(directionLabel)
        directionsView.addSubview(directionImageView)
        
        scrollView.addSubview(viewForProductsCollectionView)
        viewForProductsCollectionView.addSubview(produtsLabel)
        viewForProductsCollectionView.addSubview(seeMoreButton)
        viewForProductsCollectionView.addSubview(productCollectionView)
        
        scrollView.addSubview(viewForReviewsAndRatings)
        viewForReviewsAndRatings.addSubview(productCollectionViewLineView)
        viewForReviewsAndRatings.addSubview(ratingsAndReviewLabel)
        viewForReviewsAndRatings.addSubview(seeAllButton)
        viewForReviewsAndRatings.addSubview(finalRatingLabel)
        viewForReviewsAndRatings.addSubview(fiveStarProgressView)
        viewForReviewsAndRatings.addSubview(fiveStarLabel)
        viewForReviewsAndRatings.addSubview(fourStarProgressView)
        viewForReviewsAndRatings.addSubview(fourStarLabel)
        viewForReviewsAndRatings.addSubview(threeStarProgressView)
        viewForReviewsAndRatings.addSubview(threeStarLabel)
        viewForReviewsAndRatings.addSubview(twoStarProgressView)
        viewForReviewsAndRatings.addSubview(twoStarLabel)
        viewForReviewsAndRatings.addSubview(oneStarProgressView)
        viewForReviewsAndRatings.addSubview(oneStarLabel)
        viewForReviewsAndRatings.addSubview(outOfFiveLabel)
        viewForReviewsAndRatings.addSubview(totalRatingsLabel)
        viewForReviewsAndRatings.addSubview(ratingLineView)
        viewForReviewsAndRatings.addSubview(tapToRateLabel)
        viewForReviewsAndRatings.addSubview(starStackView)
        starStackView.addArrangedSubview(starButtonOne)
        starStackView.addArrangedSubview(starButtonTwo)
        starStackView.addArrangedSubview(starButtonThree)
        starStackView.addArrangedSubview(starButtonFour)
        starStackView.addArrangedSubview(starButtonFive)
        
        viewForReviewsAndRatings.addSubview(reviewCollectionView)
        viewForReviewsAndRatings.addSubview(writeAReviewView)
        writeAReviewView.addSubview(writeAReviewImageView)
        writeAReviewView.addSubview(writeAReviewLabel)
        viewForReviewsAndRatings.addSubview(writeAReviewLineView)
        
        configureDelegates()
        loadScrollView()
        loadContents()
        
        starButtonArray = [starButtonOne, starButtonTwo, starButtonThree, starButtonFour, starButtonFive]
    }
    
    func setToDefaults() {
        if UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular {
            pharmacyProfileHelperVC.restoreToDefaults(incrementBy: 4)
        }
        else{
            pharmacyProfileHelperVC.restoreToDefaults(incrementBy: 3)
        }
    }
    
    func configureDelegates() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintToDeActivate)
        previousConstraintToDeActivate = []
        
        reviewCollectionView.collectionViewLayout = layoutProvider.getPharmacyReviewLavout()
        productCollectionView.collectionViewLayout = layoutProvider.getPharmacyMedicineLayout()
        
        loadContents()
        
        reviewCollectionView.reloadData()
        productCollectionView.reloadData()
    }
    
    func loadContents() {
        setToDefaults()
        loadViewForProfileInfo()
        loadViewForImage()
        loadThumbNailImage()
        loadActivityIndicator()
        loadPharmacyImage()
        loadNameLabel()
        loadAddressLabel()
        loadRatingsLabel()
        loadLocationDistanceView()
        loadDistanceImage()
        loadDistanceLabel()
        loadDirectionsView()
        loadDirectionLabel()
        loadDirectionImageView()
        loadViewForProductsCollectionView()
        loadProdutsLabel()
        loadSeeMoreButton()
        loadProductCollectionView()
        loadViewForReviewsAndRatings()
        loadProductCollectionViewLineView()
        loadRatingsAndReviewLabel()
        loadSeeAllButton()
        loadFinalRatingLabel()
        loadFiveStarProgressView()
        loadFiveStarLabel()
        loadFourStarProgressView()
        loadFourStarLabel()
        loadThreeStarProgressView()
        loadThreeStarLabel()
        loadTwoStarProgressView()
        loadTwoStarLabel()
        loadOneStarProgressView()
        loadOneStarLabel()
        loadOutOfFiveLabel()
        loadTotalRatingsLabel()
        loadRatingLineView()
        loadTapToRateLabel()
        loadStarStackView()
        loadReviewCollectionView()
        loadWriteAReviewView()
        loadWriteAReviewImageView()
        loadWriteAReviewLabel()
        loadWriteAReviewLineView()
    }
    
    func loadViewForProfileInfo() {
        viewForProfileInfo.translatesAutoresizingMaskIntoConstraints = false
        
        viewForProfileInfo.backgroundColor = view.backgroundColor
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                viewForProfileInfo.topAnchor.constraint(equalTo: scrollView.topAnchor),
                viewForProfileInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.1*view.frame.width),
                viewForProfileInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0.1*view.frame.width),
                viewForProfileInfo.heightAnchor.constraint(equalToConstant: 0.35*view.frame.height)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintToDeActivate.append(constraint)
            }
        }
        else{
            if(view.frame.height > 800){
                let constraints = [
                    viewForProfileInfo.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    viewForProfileInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                    viewForProfileInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                    viewForProfileInfo.heightAnchor.constraint(equalToConstant: 0.35*view.frame.height)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previousConstraintToDeActivate.append(constraint)
                }
            }
            else{
                let constraints = [
                    viewForProfileInfo.topAnchor.constraint(equalTo: scrollView.topAnchor),
                    viewForProfileInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                    viewForProfileInfo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
                    viewForProfileInfo.heightAnchor.constraint(equalToConstant: 0.46*view.frame.height)
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previousConstraintToDeActivate.append(constraint)
                }
            }
        }
    }
    
    func loadViewForImage() {
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                viewForImage.topAnchor.constraint(equalTo: viewForProfileInfo.topAnchor, constant: 5),
                viewForImage.leadingAnchor.constraint(equalTo: viewForProfileInfo.leadingAnchor,constant: 0.15*view.frame.width),
                viewForImage.trailingAnchor.constraint(equalTo: viewForProfileInfo.trailingAnchor,constant: -0.15*view.frame.width),
                viewForImage.heightAnchor.constraint(equalTo: viewForProfileInfo.heightAnchor, multiplier: 0.55)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                viewForImage.topAnchor.constraint(equalTo: viewForProfileInfo.topAnchor, constant: 5),
                viewForImage.leadingAnchor.constraint(equalTo: viewForProfileInfo.leadingAnchor,constant: 20),
                viewForImage.trailingAnchor.constraint(equalTo: viewForProfileInfo.trailingAnchor,constant: -20),
                viewForImage.heightAnchor.constraint(equalTo: viewForProfileInfo.heightAnchor, multiplier: 0.44)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintToDeActivate.append(constraint)
            }
        }
        
        viewForImage.layer.cornerRadius = 10
    }
    
    func loadThumbNailImage() {
        thumbNailImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbNailImage.widthAnchor.constraint(equalTo: viewForImage.widthAnchor),
            thumbNailImage.heightAnchor.constraint(equalTo: viewForImage.heightAnchor),
        ])
        
        thumbNailImage.layer.cornerRadius = 10
    }
    
    func loadActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor)
        ])
    }
    
    func loadPharmacyImage() {
        pharmacyImage.translatesAutoresizingMaskIntoConstraints = false
        
        guard let url = URL(string: pharmacy.pharmacyImage) else {
            return
        }
        
        pharmacyImage.loadImageWithUrl(url)
        
        if(pharmacyImage.image != nil){
            activityIndicator.stopAnimating()
        }
        
        NSLayoutConstraint.activate([
            pharmacyImage.widthAnchor.constraint(equalTo: viewForImage.widthAnchor),
            pharmacyImage.heightAnchor.constraint(equalTo: viewForImage.heightAnchor)
        ])
        
        pharmacyImage.layer.cornerRadius = 10
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = pharmacy.name
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: viewForImage.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: viewForProfileInfo.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: viewForProfileInfo.trailingAnchor,constant: -5),
        ])
    }
    
    func loadAddressLabel() {
        addressAndInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addressAndInfoLabel.text = pharmacy.address
        
        NSLayoutConstraint.activate([
            addressAndInfoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            addressAndInfoLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            addressAndInfoLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
    }
    
    func loadRatingsLabel() {
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let rating = Int(Double(pharmacyProfileHelperVC.overAllRating) ?? 0.0)
        
        ratingsLabel.attributedText = (Rating(rawValue: rating) ?? .noRating).getRating(size: CGSize(width: 20, height: 20))
        
        NSLayoutConstraint.activate([
            ratingsLabel.topAnchor.constraint(equalTo: addressAndInfoLabel.bottomAnchor),
            ratingsLabel.leadingAnchor.constraint(equalTo: addressAndInfoLabel.leadingAnchor),
            ratingsLabel.trailingAnchor.constraint(equalTo: addressAndInfoLabel.trailingAnchor),
        ])
    }
    
    func loadLocationDistanceView(){
        locationDistanceView.translatesAutoresizingMaskIntoConstraints = false
        
        locationDistanceView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            locationDistanceView.topAnchor.constraint(equalTo: ratingsLabel.bottomAnchor, constant: 5),
            locationDistanceView.bottomAnchor.constraint(equalTo: viewForProfileInfo.bottomAnchor, constant: -5),
            locationDistanceView.leadingAnchor.constraint(equalTo: viewForProfileInfo.leadingAnchor, constant: 10),
        ])
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let widthAnchor = locationDistanceView.widthAnchor.constraint(equalTo: viewForProfileInfo.widthAnchor, multiplier: 0.2)
            widthAnchor.isActive = true
            
            previousConstraintToDeActivate.append(widthAnchor)
        }
        else{
            let widthAnchor = locationDistanceView.widthAnchor.constraint(equalTo: viewForProfileInfo.widthAnchor, multiplier: 0.3)
            widthAnchor.isActive = true
            
            previousConstraintToDeActivate.append(widthAnchor)
        }
        
        locationDistanceView.layer.cornerRadius = 10
    }
    
    func loadDistanceImage() {
        distanceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "mappin.and.ellipse")?.withRenderingMode(.alwaysOriginal)
        
        distanceImageView.image = image?.withTintColor(.systemBlue)
        
        NSLayoutConstraint.activate([
            distanceImageView.centerYAnchor.constraint(equalTo: locationDistanceView.centerYAnchor),
            distanceImageView.heightAnchor.constraint(equalTo: locationDistanceView.heightAnchor, multiplier: 0.7),
            distanceImageView.widthAnchor.constraint(equalTo: distanceImageView.heightAnchor),
            distanceImageView.centerXAnchor.constraint(equalTo: locationDistanceView.centerXAnchor,constant: -30)
        ])
    }
    
    func loadDistanceLabel() {
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        print(pharmacy.kmValue)
        let attributedString = NSMutableAttributedString(string: pharmacy.kmValue)
        
        let location = pharmacy.kmValue.count - 2
        
        attributedString.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 13), range: NSRange(location: location, length: 2))
        
        distanceLabel.attributedText = attributedString
        
        NSLayoutConstraint.activate([
            distanceLabel.centerYAnchor.constraint(equalTo: distanceImageView.centerYAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: distanceImageView.trailingAnchor,constant: 5),
            distanceLabel.trailingAnchor.constraint(equalTo: locationDistanceView.trailingAnchor,constant: -15),
            distanceLabel.heightAnchor.constraint(equalToConstant: distanceLabel.intrinsicContentSize.height - 5)
        ])
    }
    
    func loadDirectionsView() {
        directionsView.translatesAutoresizingMaskIntoConstraints = false
    
        directionsView.backgroundColor = .systemBlue
        
        addTapGesture(toView: directionsView)
        
        NSLayoutConstraint.activate([
            directionsView.topAnchor.constraint(equalTo: ratingsLabel.bottomAnchor,constant: 5),
            directionsView.bottomAnchor.constraint(equalTo: viewForProfileInfo.bottomAnchor,constant: -5),
            directionsView.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                directionsView.widthAnchor.constraint(equalToConstant: 220),
                directionsView.trailingAnchor.constraint(equalTo: viewForProfileInfo.trailingAnchor, constant: -10),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                directionsView.leadingAnchor.constraint(equalTo: locationDistanceView.trailingAnchor, constant: 5),
                directionsView.trailingAnchor.constraint(equalTo: viewForProfileInfo.trailingAnchor, constant: -10),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintToDeActivate.append(constraint)
            }
        }
        
        directionsView.layer.cornerRadius = 10
    }
    
    func loadDirectionLabel() {
        directionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        directionLabel.text = "Direction To Store"
        directionLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            directionLabel.centerYAnchor.constraint(equalTo: directionsView.centerYAnchor),
            directionLabel.centerXAnchor.constraint(equalTo: directionsView.centerXAnchor, constant: -15),
            directionLabel.heightAnchor.constraint(equalToConstant: directionLabel.intrinsicContentSize.height - 5)
        ])
    }
    
    func loadDirectionImageView() {
        directionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "map")?.withRenderingMode(.alwaysOriginal)
        
        directionImageView.image = image?.withTintColor(.white)
        
        NSLayoutConstraint.activate([
            directionImageView.centerYAnchor.constraint(equalTo: directionsView.centerYAnchor),
            directionImageView.leadingAnchor.constraint(equalTo: directionLabel.trailingAnchor,constant: 5),
            directionImageView.heightAnchor.constraint(equalTo: directionsView.heightAnchor, multiplier: 0.8),
            directionImageView.widthAnchor.constraint(equalTo: directionImageView.heightAnchor)
        ])
    }
    
    func loadViewForProductsCollectionView() {
        viewForProductsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        viewForProductsCollectionView.backgroundColor = view.backgroundColor
        
        let constraints = [
            viewForProductsCollectionView.topAnchor.constraint(equalTo: viewForProfileInfo.bottomAnchor,constant: 10),
            viewForProductsCollectionView.leadingAnchor.constraint(equalTo: viewForProfileInfo.leadingAnchor),
            viewForProductsCollectionView.trailingAnchor.constraint(equalTo: viewForProfileInfo.trailingAnchor),
            viewForProductsCollectionView.heightAnchor.constraint(equalToConstant: 0.5*view.frame.height),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintToDeActivate.append(constraint)
        }
    }
    
    func loadProdutsLabel() {
        produtsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        produtsLabel.text = "Available Products"
        
        produtsLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        produtsLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            produtsLabel.topAnchor.constraint(equalTo: viewForProductsCollectionView.topAnchor,constant: 5),
            produtsLabel.leadingAnchor.constraint(equalTo: viewForProductsCollectionView.leadingAnchor,constant: 10),
        ])
    }
    
    func loadSeeMoreButton() {
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        seeMoreButton.setTitle("See More", for: .normal)
        seeMoreButton.setTitleColor(.systemBlue, for: .normal)
        
        seeMoreButton.addTarget(self, action: #selector(didTapSeeMoreButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            seeMoreButton.bottomAnchor.constraint(equalTo: produtsLabel.bottomAnchor, constant: -5),
            seeMoreButton.topAnchor.constraint(equalTo: produtsLabel.topAnchor, constant: 5),
            seeMoreButton.trailingAnchor.constraint(equalTo: viewForProductsCollectionView.trailingAnchor, constant: -10)
        ])
    }
    
    func loadProductCollectionView() {
        productCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            productCollectionView.topAnchor.constraint(equalTo: produtsLabel.bottomAnchor,constant: 5),
            productCollectionView.leadingAnchor.constraint(equalTo: viewForProductsCollectionView.leadingAnchor),
            productCollectionView.trailingAnchor.constraint(equalTo: viewForProductsCollectionView.trailingAnchor),
            productCollectionView.bottomAnchor.constraint(equalTo: viewForProductsCollectionView.bottomAnchor,constant: -5),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        productCollectionView.layer.cornerRadius = 10
    }
    
    func loadViewForReviewsAndRatings() {
        viewForReviewsAndRatings.translatesAutoresizingMaskIntoConstraints = false
        
        if(view.frame.height > 800){
            NSLayoutConstraint.activate([
                viewForReviewsAndRatings.topAnchor.constraint(equalTo: viewForProductsCollectionView.bottomAnchor,constant: 10),
                viewForReviewsAndRatings.leadingAnchor.constraint(equalTo: viewForProductsCollectionView.leadingAnchor),
                viewForReviewsAndRatings.trailingAnchor.constraint(equalTo: viewForProductsCollectionView.trailingAnchor),
                viewForReviewsAndRatings.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -15),
                viewForReviewsAndRatings.heightAnchor.constraint(equalToConstant: 0.6*view.frame.height),
            ])
        }
        else{
            NSLayoutConstraint.activate([
                viewForReviewsAndRatings.topAnchor.constraint(equalTo: viewForProductsCollectionView.bottomAnchor,constant: 10),
                viewForReviewsAndRatings.leadingAnchor.constraint(equalTo: viewForProductsCollectionView.leadingAnchor),
                viewForReviewsAndRatings.trailingAnchor.constraint(equalTo: viewForProductsCollectionView.trailingAnchor),
                viewForReviewsAndRatings.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -15),
                viewForReviewsAndRatings.heightAnchor.constraint(equalToConstant: 0.7*view.frame.height),
            ])
        }
        
        viewForReviewsAndRatings.layer.cornerRadius = 10
    }
    
    func loadProductCollectionViewLineView() {
        productCollectionViewLineView.translatesAutoresizingMaskIntoConstraints = false
        
        productCollectionViewLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            productCollectionViewLineView.topAnchor.constraint(equalTo: viewForReviewsAndRatings.topAnchor),
            productCollectionViewLineView.leadingAnchor.constraint(equalTo: viewForReviewsAndRatings.leadingAnchor, constant: 5),
            productCollectionViewLineView.trailingAnchor.constraint(equalTo: viewForReviewsAndRatings.trailingAnchor, constant: -5),
            productCollectionViewLineView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    func loadRatingsAndReviewLabel(){
        ratingsAndReviewLabel.translatesAutoresizingMaskIntoConstraints = false
       
        ratingsAndReviewLabel.text = "Ratings & Reviews"
        ratingsAndReviewLabel.font = .systemFont(ofSize: 20, weight: .regular)
        
        NSLayoutConstraint.activate([
            ratingsAndReviewLabel.topAnchor.constraint(equalTo: productCollectionViewLineView.bottomAnchor),
            ratingsAndReviewLabel.leadingAnchor.constraint(equalTo: productCollectionViewLineView.leadingAnchor),
        ])
    }
    
    func loadSeeAllButton() {
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        seeAllButton.contentMode = .right
        seeAllButton.setTitleColor(.systemBlue, for: .normal)
        seeAllButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        
        seeAllButton.addTarget(self, action: #selector(didTapSeeAllButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            seeAllButton.topAnchor.constraint(equalTo: ratingsAndReviewLabel.topAnchor),
            seeAllButton.bottomAnchor.constraint(equalTo: ratingsAndReviewLabel.bottomAnchor),
            seeAllButton.leadingAnchor.constraint(equalTo: ratingsAndReviewLabel.trailingAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: productCollectionViewLineView.trailingAnchor),
            seeAllButton.widthAnchor.constraint(equalToConstant: seeAllButton.intrinsicContentSize.width)
        ])
    }
    
    func loadFinalRatingLabel() {
        finalRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        finalRatingLabel.text = pharmacyProfileHelperVC.overAllRating
        finalRatingLabel.font = .systemFont(ofSize: 50, weight: .bold)
        
        NSLayoutConstraint.activate([
            finalRatingLabel.topAnchor.constraint(equalTo: ratingsAndReviewLabel.bottomAnchor),
            finalRatingLabel.leadingAnchor.constraint(equalTo: ratingsAndReviewLabel.leadingAnchor, constant: 5),
        ])
    }
    
    func loadFiveStarProgressView() {
        fiveStarProgressView.translatesAutoresizingMaskIntoConstraints = false

        fiveStarProgressView.setProgress(Float(pharmacyProfileHelperVC.progressRatings[4]), animated: true)

        NSLayoutConstraint.activate([
            fiveStarProgressView.bottomAnchor.constraint(equalTo: fourStarProgressView.topAnchor,constant: -5),
            fiveStarProgressView.trailingAnchor.constraint(equalTo: fourStarProgressView.trailingAnchor),
            fiveStarProgressView.widthAnchor.constraint(equalTo: fourStarProgressView.widthAnchor),
            fiveStarProgressView.heightAnchor.constraint(equalTo: fourStarProgressView.heightAnchor)
        ])
    }
    
    func loadFiveStarLabel() {
        fiveStarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fiveStarLabel.attributedText = getNRatingStars(5)
        
        NSLayoutConstraint.activate([
            fiveStarLabel.trailingAnchor.constraint(equalTo: fiveStarProgressView.leadingAnchor),
            fiveStarLabel.centerYAnchor.constraint(equalTo: fiveStarProgressView.centerYAnchor, constant: -1),
        ])
    }
    
    func loadFourStarProgressView() {
        fourStarProgressView.translatesAutoresizingMaskIntoConstraints = false

        fourStarProgressView.setProgress(Float(pharmacyProfileHelperVC.progressRatings[3]), animated: true)

        NSLayoutConstraint.activate([
            fourStarProgressView.bottomAnchor.constraint(equalTo: threeStarProgressView.topAnchor,constant: -5),
            fourStarProgressView.trailingAnchor.constraint(equalTo: threeStarProgressView.trailingAnchor),
            fourStarProgressView.widthAnchor.constraint(equalTo: threeStarProgressView.widthAnchor),
            fourStarProgressView.heightAnchor.constraint(equalTo: threeStarProgressView.heightAnchor)
        ])
    }
    
    func loadFourStarLabel() {
        fourStarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fourStarLabel.attributedText = getNRatingStars(4)
        
        NSLayoutConstraint.activate([
            fourStarLabel.trailingAnchor.constraint(equalTo: fourStarProgressView.leadingAnchor),
            fourStarLabel.centerYAnchor.constraint(equalTo: fourStarProgressView.centerYAnchor, constant: -1),
        ])
    }
    
    func loadThreeStarProgressView() {
        threeStarProgressView.translatesAutoresizingMaskIntoConstraints = false
        
        threeStarProgressView.setProgress(Float(pharmacyProfileHelperVC.progressRatings[2]), animated: true)
        
        NSLayoutConstraint.activate([
            threeStarProgressView.centerYAnchor.constraint(equalTo: finalRatingLabel.centerYAnchor),
            threeStarProgressView.trailingAnchor.constraint(equalTo: seeAllButton.trailingAnchor, constant: -5),
            threeStarProgressView.widthAnchor.constraint(equalTo: viewForReviewsAndRatings.widthAnchor, multiplier: 0.5),
            threeStarProgressView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    func loadThreeStarLabel() {
        threeStarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        threeStarLabel.attributedText = getNRatingStars(3)
        
        NSLayoutConstraint.activate([
            threeStarLabel.trailingAnchor.constraint(equalTo: threeStarProgressView.leadingAnchor),
            threeStarLabel.centerYAnchor.constraint(equalTo: threeStarProgressView.centerYAnchor, constant: -1),
        ])
    }
    
    func loadTwoStarProgressView() {
        twoStarProgressView.translatesAutoresizingMaskIntoConstraints = false

        twoStarProgressView.setProgress(Float(pharmacyProfileHelperVC.progressRatings[1]), animated: true)

        NSLayoutConstraint.activate([
            twoStarProgressView.topAnchor.constraint(equalTo: threeStarProgressView.bottomAnchor,constant: 5),
            twoStarProgressView.trailingAnchor.constraint(equalTo: threeStarProgressView.trailingAnchor),
            twoStarProgressView.widthAnchor.constraint(equalTo: threeStarProgressView.widthAnchor),
            twoStarProgressView.heightAnchor.constraint(equalTo: threeStarProgressView.heightAnchor)
        ])
    }
    
    func loadTwoStarLabel() {
        twoStarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        twoStarLabel.attributedText = getNRatingStars(2)
        
        NSLayoutConstraint.activate([
            twoStarLabel.trailingAnchor.constraint(equalTo: twoStarProgressView.leadingAnchor),
            twoStarLabel.centerYAnchor.constraint(equalTo: twoStarProgressView.centerYAnchor, constant: -1),
        ])
    }
    
    func loadOneStarProgressView() {
        oneStarProgressView.translatesAutoresizingMaskIntoConstraints = false

        oneStarProgressView.setProgress(Float(pharmacyProfileHelperVC.progressRatings[0]), animated: true)

        NSLayoutConstraint.activate([
            oneStarProgressView.topAnchor.constraint(equalTo: twoStarProgressView.bottomAnchor,constant: 5),
            oneStarProgressView.trailingAnchor.constraint(equalTo: twoStarProgressView.trailingAnchor),
            oneStarProgressView.widthAnchor.constraint(equalTo: twoStarProgressView.widthAnchor),
            oneStarProgressView.heightAnchor.constraint(equalTo: twoStarProgressView.heightAnchor)
        ])
    }
    
    func loadOneStarLabel() {
        oneStarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        oneStarLabel.attributedText = getNRatingStars(1)
        
        NSLayoutConstraint.activate([
            oneStarLabel.trailingAnchor.constraint(equalTo: oneStarProgressView.leadingAnchor),
            oneStarLabel.centerYAnchor.constraint(equalTo: oneStarProgressView.centerYAnchor, constant: -1),
        ])
    }
    
    func loadOutOfFiveLabel() {
        outOfFiveLabel.translatesAutoresizingMaskIntoConstraints = false
        
        outOfFiveLabel.text = "out of 5"
        
        NSLayoutConstraint.activate([
            outOfFiveLabel.topAnchor.constraint(equalTo: finalRatingLabel.bottomAnchor),
            outOfFiveLabel.leadingAnchor.constraint(equalTo: finalRatingLabel.leadingAnchor),
            outOfFiveLabel.centerXAnchor.constraint(equalTo: finalRatingLabel.centerXAnchor)
        ])
    }
    
    func loadTotalRatingsLabel() {
        totalRatingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalRatingsLabel.text = "\(pharmacyProfileHelperVC.totalRatings) Ratings"
        
        NSLayoutConstraint.activate([
            totalRatingsLabel.topAnchor.constraint(equalTo: outOfFiveLabel.topAnchor),
            totalRatingsLabel.bottomAnchor.constraint(equalTo: outOfFiveLabel.bottomAnchor),
            totalRatingsLabel.trailingAnchor.constraint(equalTo: seeAllButton.trailingAnchor),
        ])
    }
    
    func loadRatingLineView() {
        ratingLineView.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            ratingLineView.topAnchor.constraint(equalTo: totalRatingsLabel.bottomAnchor),
            ratingLineView.leadingAnchor.constraint(equalTo: ratingsAndReviewLabel.leadingAnchor),
            ratingLineView.trailingAnchor.constraint(equalTo: totalRatingsLabel.trailingAnchor),
            ratingLineView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    func loadTapToRateLabel() {
        tapToRateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tapToRateLabel.text = "Tap to Rate:"
        
        NSLayoutConstraint.activate([
            tapToRateLabel.topAnchor.constraint(equalTo: ratingLineView.bottomAnchor),
            tapToRateLabel.leadingAnchor.constraint(equalTo: ratingLineView.leadingAnchor),
        ])
    }
    
    func loadStarStackView() {
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starStackView.topAnchor.constraint(equalTo: tapToRateLabel.topAnchor),
            starStackView.bottomAnchor.constraint(equalTo: tapToRateLabel.bottomAnchor),
            starStackView.trailingAnchor.constraint(equalTo: ratingLineView.trailingAnchor)
        ])
    }
    
    func loadReviewCollectionView() {
        reviewCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                reviewCollectionView.topAnchor.constraint(equalTo: tapToRateLabel.bottomAnchor),
                reviewCollectionView.leadingAnchor.constraint(equalTo: ratingLineView.leadingAnchor),
                reviewCollectionView.trailingAnchor.constraint(equalTo: ratingLineView.trailingAnchor),
                reviewCollectionView.heightAnchor.constraint(equalTo: viewForReviewsAndRatings.heightAnchor, multiplier: 0.45),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                reviewCollectionView.topAnchor.constraint(equalTo: tapToRateLabel.bottomAnchor),
                reviewCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                reviewCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                reviewCollectionView.heightAnchor.constraint(equalTo: viewForReviewsAndRatings.heightAnchor, multiplier: 0.45),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintToDeActivate.append(constraint)
            }
        }
    }
    
    func loadWriteAReviewView() {
        writeAReviewView.translatesAutoresizingMaskIntoConstraints = false
        
        addTapGesture(toView: writeAReviewView)
        
        NSLayoutConstraint.activate([
            writeAReviewView.topAnchor.constraint(equalTo: reviewCollectionView.bottomAnchor),
            writeAReviewView.leadingAnchor.constraint(equalTo: tapToRateLabel.leadingAnchor),
            writeAReviewView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            writeAReviewView.heightAnchor.constraint(equalTo: tapToRateLabel.heightAnchor),
        ])
    }
    
    func loadWriteAReviewImageView() {
        writeAReviewImageView.translatesAutoresizingMaskIntoConstraints = false
        
        writeAReviewImageView.image = UIImage(systemName: "square.and.pencil")
        
        NSLayoutConstraint.activate([
            writeAReviewImageView.centerYAnchor.constraint(equalTo: writeAReviewView.centerYAnchor),
            writeAReviewImageView.leadingAnchor.constraint(equalTo: writeAReviewView.leadingAnchor),
            writeAReviewImageView.heightAnchor.constraint(equalTo: writeAReviewView.heightAnchor, multiplier: 0.5),
            writeAReviewImageView.widthAnchor.constraint(equalTo: writeAReviewImageView.heightAnchor),
        ])
    }
    
    func loadWriteAReviewLabel() {
        writeAReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        writeAReviewLabel.text = " Write a Review"
        writeAReviewLabel.textColor = .systemBlue
        
        NSLayoutConstraint.activate([
            writeAReviewLabel.topAnchor.constraint(equalTo: writeAReviewView.topAnchor),
            writeAReviewLabel.leadingAnchor.constraint(equalTo: writeAReviewImageView.trailingAnchor),
            writeAReviewLabel.bottomAnchor.constraint(equalTo: writeAReviewView.bottomAnchor),
        ])
    }
    
    func loadWriteAReviewLineView() {
        writeAReviewLineView.translatesAutoresizingMaskIntoConstraints = false
        
        writeAReviewLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            writeAReviewLineView.topAnchor.constraint(equalTo: writeAReviewLabel.bottomAnchor),
            writeAReviewLineView.leadingAnchor.constraint(equalTo: tapToRateLabel.leadingAnchor),
            writeAReviewLineView.trailingAnchor.constraint(equalTo: starStackView.trailingAnchor),
            writeAReviewLineView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == directionsView){
            tapGesture.addTarget(self, action: #selector(didTapDirectionToStore))
        }
        else if(toView == writeAReviewView){
            tapGesture.addTarget(self, action: #selector(didTapWriteAReview))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapSeeMoreButton(_ sender: UIButton) {
        print("See more button tapped")
        
        let availableProductsVC = PharmacyAvailableProductsVC(pharmacyProducts: pharmacyProfileHelperVC.products, pharmacyId: pharmacy.id)
        
        navigationController?.pushViewController(availableProductsVC, animated: true)
    }
    
    @objc func didTapDirectionToStore(_ sender: UITapGestureRecognizer){
        
        guard let url = URL(string: "comgooglemaps://\(pharmacy.directionToStoreLink)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url){
            guard let url = URL(string: pharmacy.directionToStoreLink) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        else {
            guard let url = URL(string: "https://apps.apple.com/us/app/google-maps/id585027354") else {
                return
            }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func didTapStarRating(_ notification: Notification){
        
        let info = notification.userInfo as? [String: Int] ?? [:]
        print(info)
        
        
        fillNStars(info["userSelectedStarRating"] ?? 0)
        userSelectedStarRating = info["userSelectedStarRating"] ?? 0
    }
    
    @objc func reviewAdded(_ notification: Notification) {
        pharmacyProfileHelperVC.fetchReviews()
        
        reviewCollectionView.reloadData()
    }
    
    @objc func didTapWriteAReview(_ sender: UITapGestureRecognizer){
        print("Write A Review Tapped.")
        
        var reviewWritten: Bool = false
        var reviewToSend: Reviews?
        
        for review in pharmacyProfileHelperVC.reviews {
            if(review.reviewerName == UserDefaults.standard.string(forKey: "User - Name")) {
                reviewWritten = true
                reviewToSend = review
            }
        }
        
        var pharmacyWriteAReviewVC: UINavigationController?
        
        if(reviewWritten){
            guard let reviewToSend = reviewToSend else {
                return
            }
            
            pharmacyWriteAReviewVC = UINavigationController(rootViewController: PharmacyWriteAReviewVC(
                review: reviewToSend,
                previouslyFilledStars: userSelectedStarRating,
                pharmacyReviewId: pharmacy.reviewId))
        }
        else{
            pharmacyWriteAReviewVC = UINavigationController(rootViewController: PharmacyWriteAReviewVC(
                    previouslyFilledStars: userSelectedStarRating,
                    pharmacyReviewId: pharmacy.reviewId))
        }
        
        guard let pharmacyWriteAReviewVC = pharmacyWriteAReviewVC else {
            return
        }
        
        present(pharmacyWriteAReviewVC, animated: true)
    }
    
    @objc func didTapSeeAllButton(_ sender: UIButton) {
        print("See All Button Tapped")
        
        let requirments = SeeAllReview(
            reviews: pharmacyProfileHelperVC.reviews,
            ratings: pharmacyProfileHelperVC.ratings,
            userSelectedStarRating: userSelectedStarRating,
            overAllRating: pharmacyProfileHelperVC.overAllRating,
            progressRatings: pharmacyProfileHelperVC.progressRatings,
            totalNumberOfRatings: pharmacy.totalNumberOfRatings,
            reviewId: pharmacy.reviewId)
        
        let seeAllVC = SeeAllReviewsVC(requirments: requirments)
        
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    func resetButtons() {
        for button in starButtonArray {
            let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
            button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        }
    }
    
    @objc func didTapStarRatingButton(_ sender: UIButton) {
        print(sender.tag)
        resetButtons()
        
        for button in starButtonArray {
            if(button.tag <= sender.tag){
                let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
                button.setImage(image?.withTintColor(.systemBlue), for: .normal)
            }
        }
        isRated = true
        
        userSelectedStarRating = sender.tag
        
        setProgressBar()
    }
    
    func setProgressBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 3, delay: 0) { [weak self] in
                self?.fiveStarProgressView.setProgress(0, animated: true)
                self?.fourStarProgressView.setProgress(0, animated: true)
                self?.threeStarProgressView.setProgress(0, animated: true)
                self?.twoStarProgressView.setProgress(0, animated: true)
                self?.oneStarProgressView.setProgress(0, animated: true)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 3, delay: 0) { [weak self] in
                self?.fiveStarProgressView.setProgress(self?.pharmacyProfileHelperVC.progressRatings[4] ?? 0.0, animated: true)
                self?.fourStarProgressView.setProgress(self?.pharmacyProfileHelperVC.progressRatings[3] ?? 0.0, animated: true)
                self?.threeStarProgressView.setProgress(self?.pharmacyProfileHelperVC.progressRatings[2] ?? 0.0, animated: true)
                self?.twoStarProgressView.setProgress(self?.pharmacyProfileHelperVC.progressRatings[1] ?? 0.0, animated: true)
                self?.oneStarProgressView.setProgress(self?.pharmacyProfileHelperVC.progressRatings[0] ?? 0.0, animated: true)
            }
        }
    }
    
    func fillNStars(_ value: Int){
        for index in 0..<starButtonArray.count {
            if(index < value){
                let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
                starButtonArray[index].setImage(image?.withTintColor(.systemBlue), for: .normal)
            }
            else{
                let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
                starButtonArray[index].setImage(image?.withTintColor(.systemBlue), for: .normal)
            }
        }
    }
    
    func min(_ valueOne: Int,_ valueTwo: Int) -> Int{
        return (valueOne < valueTwo) ? valueOne : valueTwo
    }
}

extension PharmacyProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == productCollectionView){
            return pharmacyProfileHelperVC.products.count
        }
        else if(collectionView == reviewCollectionView){
            return min(10, pharmacyProfileHelperVC.reviews.count)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == productCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyProfileCollectionViewCell.identifier, for: indexPath) as? PharmacyProfileCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.product = pharmacyProfileHelperVC.products[indexPath.row]
            
            if(indexPath.row == pharmacyProfileHelperVC.bottomCellsToRound || pharmacyProfileHelperVC.isPresent(value: indexPath.row, in: pharmacyProfileHelperVC.bottomCellToRoundIndices)){
                pharmacyProfileHelperVC.bottomCellToRoundIndices.append(pharmacyProfileHelperVC.bottomCellsToRound)
                
                print(indexPath.row," ",pharmacyProfileHelperVC.bottomCellsToRound)
                
                pharmacyProfileHelperVC.bottomCellsToRound+=pharmacyProfileHelperVC.incrementBy

                cell.roundBottomEdges()
            }
            else if(indexPath.row == pharmacyProfileHelperVC.topCellsToRound || pharmacyProfileHelperVC.isPresent(value: indexPath.row, in: pharmacyProfileHelperVC.topCellToRoundIndices)){
                pharmacyProfileHelperVC.topCellToRoundIndices.append(pharmacyProfileHelperVC.topCellsToRound)
                
                print(indexPath.row," ",pharmacyProfileHelperVC.topCellsToRound)
                
                pharmacyProfileHelperVC.topCellsToRound+=pharmacyProfileHelperVC.incrementBy

                cell.roundTopEdges()
            }
            
            return cell
        }
        else if(collectionView == reviewCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyReviewCollectionViewCell.identifier, for: indexPath) as? PharmacyReviewCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let review = pharmacyProfileHelperVC.reviews[indexPath.row]
            
            cell.review = review
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == productCollectionView){
            let pharmacyProductVC = PharmacyProductVC(product: pharmacyProfileHelperVC.products[indexPath.row], pharmacyId: pharmacy.id)
            
            pharmacyProductVC.delegate = self
            
            present(pharmacyProductVC, animated: true)
        }
        else if (collectionView == reviewCollectionView){
            didTapSeeAllButton(seeAllButton)
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension Rating {
    func getRating(size: CGSize?) -> NSMutableAttributedString {
        
        let ratingValue = self.rawValue
        var value = 1
        let attributedString = NSMutableAttributedString("")
        
        while(value < 6){
            let imageToAppend = NSTextAttachment()
            if(value <= ratingValue){
                
                imageToAppend.image = UIImage(systemName: "star.fill")?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
            }
            else{
                imageToAppend.image = UIImage(systemName: "star")?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
            }
            
            if let size = size {
                imageToAppend.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            }
            
            attributedString.append(NSAttributedString(attachment: imageToAppend))
            value+=1
        }
        
        return attributedString
    }
    
    func getRating(withColor: UIColor, size: CGSize?) -> NSMutableAttributedString {
        
        let ratingValue = self.rawValue
        var value = 1
        let attributedString = NSMutableAttributedString("")
        
        while(value < 6){
            let imageToAppend = NSTextAttachment()
            if(value <= ratingValue){
                imageToAppend.image = UIImage(systemName: "star.fill")?.withTintColor(withColor)
            }
            else{
                imageToAppend.image = UIImage(systemName: "star")?.withTintColor(withColor)
            }
            
            if let size = size {
                imageToAppend.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            }
            
            attributedString.append(NSAttributedString(attachment: imageToAppend))
            value+=1
        }
        
        return attributedString
    }
}

extension PharmacyProfileVC {
    func getNRatingStars(_ count: Int) -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString("")
        
        var cnt = count
        
        while(cnt > 0){
            let imageToAppend = NSTextAttachment()
            
            let image = UIImage(systemName: "star.fill")?.withTintColor(.secondaryLabel)
            
            imageToAppend.image = image
            
            imageToAppend.bounds = CGRect(x: 0, y: 0, width: 8, height: 8)
            
            attributedString.append(NSAttributedString(attachment: imageToAppend))
            cnt-=1
        }
        
        return attributedString
    }
}

extension PharmacyProfileVC: ViewInCartProtocol {
    func showCartVC() {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 1
    }
}

extension PharmacyProfileVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        
        if(offset.y > nameLabel.frame.height + viewForImage.frame.height) {
            self.title = pharmacy.name
        }
        else {
            self.title = ""
        }
    }
}

extension PharmacyProfileVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print(isRated)
        if(isRated == true){
            pharmacyProfileHelperVC.updateTheCountTable(for: userSelectedStarRating)
            
            pharmacyProfileHelperVC.fetchRatings()
            
            
            let value = Int(Double(pharmacyProfileHelperVC.getOverAllRating()) ?? 0)
            
            pharmacyProfileHelperVC.updateDB(forRow: pharmacy.id, updateColumn: .rating, toValue: value)
            
            let userInfoValue = ["StarRating_Updated_PharmacyId": pharmacy.id - 1, "StarRating_Updated_RatingOutOfFive": value]
            
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_StarRating_Updated"), object: nil,
                userInfo: userInfoValue)
        }
    }
}
