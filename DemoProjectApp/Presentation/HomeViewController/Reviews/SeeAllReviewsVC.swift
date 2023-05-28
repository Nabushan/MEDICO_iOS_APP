//
//  SeeAllReviewsVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 11/10/22.
//

import UIKit

class SeeAllReviewsVC: UIViewController, SeeAllReviewsProtocol {
    
    lazy var reviewCollectionView: UICollectionView = {
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayoutProvider().getSeeAllReviewLayout())
        
        collectionview.register(PharmacyReviewCollectionViewCell.self, forCellWithReuseIdentifier: PharmacyReviewCollectionViewCell.identifier)
        
        collectionview.register(SeeAllReviewsCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: SeeAllReviewsCollectionReusableView.identifier)
        
        return collectionview
    }()
    
    var requirments: SeeAllReview
    var doctor: Doctor?
    var reviews: [Reviews]
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    let seeAllReviewsHelper: SeeAllReviewsHelper
    var reusableHeaderView: SeeAllReviewsCollectionReusableView?
    var isFromDoctorsProfileVC: Bool = false
    
    init(requirments: SeeAllReview){
        self.requirments = requirments
        self.reviews = requirments.reviews
        self.seeAllReviewsHelper = SeeAllReviewsHelper(requirments, nil)
        
        super.init(nibName: nil, bundle: nil)
        
        seeAllReviewsHelper.delegate = self
    }
    
    init(requirments: SeeAllReview, doctor: Doctor, isFromDoctorVC: Bool){
        self.requirments = requirments
        self.reviews = requirments.reviews
        self.seeAllReviewsHelper = SeeAllReviewsHelper(requirments, doctor)
        self.doctor = doctor
        self.isFromDoctorsProfileVC = isFromDoctorVC
        
        super.init(nibName: nil, bundle: nil)
        
        seeAllReviewsHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Ratings & Reviews"
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        view.addSubview(reviewCollectionView)
        
        configureDelegates()
        loadCollectionView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        loadCollectionView()
    }
    
    func configureDelegates() {
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self
    }
    
    func loadCollectionView() {
        reviewCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                reviewCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
                reviewCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 0.1*view.frame.width),
                reviewCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -0.1*view.frame.width),
                reviewCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            previousConstraintsToDeActivate = constraints
        }
        else{
            let constraints = [
                reviewCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 0),
                reviewCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 5),
                reviewCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -5),
                reviewCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -5),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            previousConstraintsToDeActivate = constraints
        }
    }
}

extension SeeAllReviewsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyReviewCollectionViewCell.identifier, for: indexPath) as? PharmacyReviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.review = reviews[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let detailVC = SeeAllDetailReviewVC(review: reviews[indexPath.row])
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if(kind == "header"){
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SeeAllReviewsCollectionReusableView.identifier, for: indexPath) as? SeeAllReviewsCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            view.requirment = requirments
            
            reusableHeaderView = view
            
            return view
        }
        
        return UICollectionReusableView()
    }
}

extension SeeAllReviewsVC {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(isFromDoctorsProfileVC) {
            var isUserAlreadyRated: Bool = false
            for review in reviews {
                guard let userName = UserDefaults.standard.string(forKey: "User - Name") else {
                    return
                }
                if(review.reviewerName == userName) {
                    isUserAlreadyRated = true
                    if((reusableHeaderView?.isRated ?? false) && (reusableHeaderView?.userSelectedStarRating != review.numberOfRatingStars)) {
                        seeAllReviewsHelper.reduceEarlierRatings(review.numberOfRatingStars, rating: requirments.ratings[0])
                        seeAllReviewsHelper.updatePresentRatings(reusableHeaderView?.userSelectedStarRating ?? 0, rating: requirments.ratings[0])
                    }
                }
            }
            
            if(!isUserAlreadyRated) {
                seeAllReviewsHelper.updatePresentRatings(reusableHeaderView?.userSelectedStarRating ?? 0, rating: requirments.ratings[0])
                seeAllReviewsHelper.addsNewRating(reusableHeaderView?.userSelectedStarRating ?? 0)
            }
        }
    }
}
