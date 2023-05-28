//
//  PharmacyReviewCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 08/10/22.
//

import UIKit

class PharmacyReviewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PharmacyReviewCollectionViewCell"
    
    lazy var overAllReviewLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.text = "Lorem Ipsum"
        
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
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
        label.lineBreakMode = .byTruncatingTail
        label.text = "Lorem Ipsum"
        
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var dateLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.text = "Lorem Ipsum"
        
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var reviewerName: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.text = "Lorem Ipsum"
        
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var reviewLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.text = "Lorem Ipsum"

        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    var review: Reviews? {
        didSet{
            guard let review = review else {
                return
            }
            
            reviewerName.text = review.reviewerName
            overAllReviewLabel.text = review.title
            dateLabel.text = review.dateOfReview
            ratingLabel.attributedText = Rating(rawValue: review.numberOfRatingStars)?.getRating(withColor: UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1), size: CGSize(width: 15, height: 13))
            reviewLabel.text = review.body
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .systemGray6

        contentView.addSubview(overAllReviewLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(reviewerName)
        contentView.addSubview(reviewLabel)
        
        contentView.layer.cornerRadius = 10
        
        loadOverAllReviewLabel()
        loadRatingLabel()
        loadDateLabel()
        loadReviewerName()
        loadReviewLabel()
    }
    
    func loadOverAllReviewLabel() {
        overAllReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overAllReviewLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        overAllReviewLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            overAllReviewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            overAllReviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            overAllReviewLabel.bottomAnchor.constraint(equalTo: ratingLabel.topAnchor),
        ])
    }
    
    func loadRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        ratingLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: overAllReviewLabel.bottomAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: overAllReviewLabel.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: reviewerName.leadingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: reviewLabel.topAnchor)
        ])
    }
    
    func loadDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: overAllReviewLabel.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            dateLabel.leadingAnchor.constraint(equalTo: overAllReviewLabel.trailingAnchor)
        ])
    }
    
    func loadReviewerName() {
        reviewerName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reviewerName.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            reviewerName.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
        ])
    }
    
    func loadReviewLabel() {
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            reviewLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            reviewLabel.trailingAnchor.constraint(equalTo: reviewerName.trailingAnchor),
            reviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }
}
