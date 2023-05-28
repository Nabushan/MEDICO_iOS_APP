//
//  SeeAllReviewsCollectionReusableView.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 11/10/22.
//

import UIKit

class SeeAllReviewsCollectionReusableView: UICollectionReusableView {
    static let identifier = "SeeAllReviewsCollectionReusableView"
    
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
        label.font = UIFont(name: "Helvetica", size: 20)
        
        return label
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
    
    lazy var viewForReviewsAndRatings: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var productCollectionViewLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    var starButtonArray: [ResizedButton] = []
    
    var reviews: [Reviews] = []
    var ratings: [Ratings] = []
    var userSelectedStarRating: Int = 0
    var progressBarValues: [Float] = []
    var overAllRating: String = ""
    var totalNumberOfRatings: Int = 0
    var reviewId: Int = -1
    var isRated = false
    
    var requirment: SeeAllReview? {
        didSet{
            guard let requirment = requirment else {
                return
            }
            
            self.reviews = requirment.reviews
            self.ratings = requirment.ratings
            self.userSelectedStarRating = requirment.userSelectedStarRating
            self.progressBarValues = requirment.progressRatings
            self.overAllRating = requirment.overAllRating
            self.totalNumberOfRatings = requirment.totalNumberOfRatings
            self.reviewId = requirment.reviewId
            
            if(userSelectedStarRating > 0){
                isRated = true
            }
            
            print("SeeAllReviewCollectionReusableView : isRated => ",isRated)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(viewForReviewsAndRatings)
        
        viewForReviewsAndRatings.addSubview(productCollectionViewLineView)
        viewForReviewsAndRatings.addSubview(ratingsAndReviewLabel)
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
        
        
        loadViewForReviewsAndRatings()
        loadProductCollectionViewLineView()
        loadRatingsAndReviewLabel()
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
        
        starButtonArray = [starButtonOne, starButtonTwo, starButtonThree, starButtonFour, starButtonFive]
        
        fillNStars(userSelectedStarRating)
    }
    
    func loadViewForReviewsAndRatings() {
        viewForReviewsAndRatings.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewForReviewsAndRatings.topAnchor.constraint(equalTo: self.topAnchor),
            viewForReviewsAndRatings.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewForReviewsAndRatings.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewForReviewsAndRatings.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func loadProductCollectionViewLineView() {
        productCollectionViewLineView.translatesAutoresizingMaskIntoConstraints = false
        
        productCollectionViewLineView.backgroundColor = .systemGray5
        productCollectionViewLineView.alpha = 0
        
        NSLayoutConstraint.activate([
            productCollectionViewLineView.topAnchor.constraint(equalTo: viewForReviewsAndRatings.topAnchor),
            productCollectionViewLineView.leadingAnchor.constraint(equalTo: viewForReviewsAndRatings.leadingAnchor, constant: 10),
            productCollectionViewLineView.trailingAnchor.constraint(equalTo: viewForReviewsAndRatings.trailingAnchor, constant: -10),
            productCollectionViewLineView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
    
    func loadRatingsAndReviewLabel(){
        ratingsAndReviewLabel.translatesAutoresizingMaskIntoConstraints = false
       
        ratingsAndReviewLabel.text = "Ratings & Reviews"
        ratingsAndReviewLabel.alpha = 0
        
        NSLayoutConstraint.activate([
            ratingsAndReviewLabel.topAnchor.constraint(equalTo: productCollectionViewLineView.bottomAnchor),
            ratingsAndReviewLabel.leadingAnchor.constraint(equalTo: productCollectionViewLineView.leadingAnchor),
        ])
    }
    
    func loadFinalRatingLabel() {
        finalRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        finalRatingLabel.text = overAllRating
        finalRatingLabel.font = .systemFont(ofSize: 50, weight: .bold)
        
        NSLayoutConstraint.activate([
            finalRatingLabel.topAnchor.constraint(equalTo: ratingsAndReviewLabel.bottomAnchor),
            finalRatingLabel.leadingAnchor.constraint(equalTo: ratingsAndReviewLabel.leadingAnchor, constant: 5),
        ])
    }
    
    func loadFiveStarProgressView() {
        fiveStarProgressView.translatesAutoresizingMaskIntoConstraints = false

        print("Five star progress bar value : ",progressBarValues[4])
        fiveStarProgressView.setProgress(progressBarValues[4], animated: true)

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

        fourStarProgressView.setProgress(progressBarValues[3], animated: true)

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
        
        threeStarProgressView.setProgress(progressBarValues[2], animated: true)
        
        NSLayoutConstraint.activate([
            threeStarProgressView.centerYAnchor.constraint(equalTo: finalRatingLabel.centerYAnchor),
            threeStarProgressView.trailingAnchor.constraint(equalTo: productCollectionViewLineView.trailingAnchor, constant: -5),
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

        twoStarProgressView.setProgress(progressBarValues[1], animated: true)

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

        oneStarProgressView.setProgress(progressBarValues[0], animated: true)

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
        
        totalRatingsLabel.text = "\(totalNumberOfRatings) Ratings"
        
        NSLayoutConstraint.activate([
            totalRatingsLabel.topAnchor.constraint(equalTo: outOfFiveLabel.topAnchor),
            totalRatingsLabel.bottomAnchor.constraint(equalTo: outOfFiveLabel.bottomAnchor),
            totalRatingsLabel.trailingAnchor.constraint(equalTo: threeStarProgressView.trailingAnchor),
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
        
        print("SeeAllReviewCollectionReusableView : isRated => ",isRated)
        
        let userInfo = ["userSelectedStarRating": userSelectedStarRating]
        
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_StarRating"), object: nil, userInfo: userInfo as [AnyHashable : Any])
        
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
                self?.fiveStarProgressView.setProgress(self?.progressBarValues[4] ?? 0.0, animated: true)
                self?.fourStarProgressView.setProgress(self?.progressBarValues[3] ?? 0.0, animated: true)
                self?.threeStarProgressView.setProgress(self?.progressBarValues[2] ?? 0.0, animated: true)
                self?.twoStarProgressView.setProgress(self?.progressBarValues[1] ?? 0.0, animated: true)
                self?.oneStarProgressView.setProgress(self?.progressBarValues[0] ?? 0.0, animated: true)
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
