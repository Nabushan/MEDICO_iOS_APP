//
//  PharmacyProfileCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 07/10/22.
//

import UIKit

class PharmacyProfileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PharmacyProfileCollectionViewCell"
    
    lazy var medicineImage: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var medicineNameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    lazy var medicineCostLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    lazy var expiryDateLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    
    lazy var availableItemsLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    
    lazy var ratingLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    
    lazy var totalBuyersLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    
    var product: PharmacyProduct? {
        didSet{
            guard let product = product else {
                return
            }
            
            medicineNameLabel.text = product.name
            medicineCostLabel.text = "₹ \(product.cost)"
            expiryDateLabel.text = "Exp on: \(product.expiryDate)"
            availableItemsLabel.text = "\(product.availableCount) items"
            ratingLabel.attributedText = getRatedAttributedStarString(forRating: product.productRating)
            totalBuyersLabel.attributedText = getRatedAttributedBuyersString(forCount: product.totalBuyers)
            
            guard let url = URL(string: product.imageLink) else {
                return
            }
            
            medicineImage.loadImageWithUrl(url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.layer.mask = nil
        medicineImage.layer.mask = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .tertiarySystemGroupedBackground
        
        contentView.addSubview(medicineImage)
        contentView.addSubview(medicineNameLabel)
        contentView.addSubview(medicineCostLabel)
        contentView.addSubview(expiryDateLabel)
        contentView.addSubview(availableItemsLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(totalBuyersLabel)
        
        loadMedicineImageView()
        loadMedicineNameLabel()
        loadMedicineCostLabel()
        loadExpiryDateLabel()
        loadAvailableItemsLabel()
        loadRatingLabel()
        loadTotalBuyerslabel()
    }
    
    func loadMedicineImageView() {
        medicineImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            medicineImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            medicineImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            medicineImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            medicineImage.widthAnchor.constraint(equalTo: medicineImage.heightAnchor)
        ])
    }
    
    func loadMedicineNameLabel() {
        medicineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        medicineNameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            medicineNameLabel.bottomAnchor.constraint(equalTo: expiryDateLabel.topAnchor, constant: 3),
            medicineNameLabel.leadingAnchor.constraint(equalTo: expiryDateLabel.leadingAnchor),
        ])
    }
    
    func loadMedicineCostLabel() {
        medicineCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            medicineCostLabel.bottomAnchor.constraint(equalTo: medicineNameLabel.bottomAnchor),
            medicineCostLabel.trailingAnchor.constraint(equalTo: availableItemsLabel.trailingAnchor),
            medicineCostLabel.leadingAnchor.constraint(equalTo: medicineNameLabel.trailingAnchor)
        ])
    }
    
    func loadExpiryDateLabel() {
        expiryDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        expiryDateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            expiryDateLabel.centerYAnchor.constraint(equalTo: medicineImage.centerYAnchor),
            expiryDateLabel.leadingAnchor.constraint(equalTo: medicineImage.trailingAnchor, constant: 15)
        ])
    }
    
    func loadAvailableItemsLabel() {
        availableItemsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            availableItemsLabel.centerYAnchor.constraint(equalTo: expiryDateLabel.centerYAnchor),
            availableItemsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            availableItemsLabel.leadingAnchor.constraint(equalTo: expiryDateLabel.trailingAnchor)
        ])
    }
    
    func loadRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: expiryDateLabel.bottomAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: expiryDateLabel.leadingAnchor)
        ])
    }
    
    func loadTotalBuyerslabel() {
        totalBuyersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalBuyersLabel.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            totalBuyersLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            totalBuyersLabel.trailingAnchor.constraint(equalTo: availableItemsLabel.trailingAnchor)
        ])
    }
    
    func getRatedAttributedStarString(forRating: Double) -> NSMutableAttributedString {
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
        
        mutableString.append(NSAttributedString(string: " (\(forRating))"))
        
        return mutableString
    }
    
    func getRatedAttributedBuyersString(forCount: Int) -> NSMutableAttributedString {
        guard let image = UIImage(systemName: "person.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue) else {
            return NSMutableAttributedString(string: "")
        }
        
        let textAttachment = NSTextAttachment(image: image)
        
        let mutableString = NSMutableAttributedString(attachment: textAttachment)
        
        mutableString.append(NSAttributedString(string: " \(forCount)"))
        
        return mutableString
    }
    
    func roundTopEdges() {
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        
        shapeLayer.path = path.cgPath
        
        contentView.layer.mask = shapeLayer
        
        roundImageTop()
    }
    
    func roundImageTop() {
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: contentView.frame.height*0.9, height: contentView.frame.height*0.9), byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 10, height: 10))
        
        shapeLayer.path = path.cgPath
        
        medicineImage.layer.mask = shapeLayer
    }
    
    func roundBottomEdges() {
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        shapeLayer.path = path.cgPath
        
        contentView.layer.mask = shapeLayer
        
        roundImageBottom()
    }
    
    func roundImageBottom() {
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: contentView.frame.height*0.9, height: contentView.frame.height*0.9), byRoundingCorners: [.bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        
        shapeLayer.path = path.cgPath
        
        medicineImage.layer.mask = shapeLayer
    }
}
