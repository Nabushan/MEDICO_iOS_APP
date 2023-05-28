//
//  HospitalListCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/12/22.
//

import UIKit

class HospitalListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HospitalListCollectionViewCell"
    
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
        imageView.contentMode = .scaleAspectFit
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
    
    lazy var addressLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
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
            
            if let _ = imageView.image {
                activityIndicator.stopAnimating()
            }
            
            nameLabel.text = "\(hospital.name) Hospital"
            
            let starAttributedString: NSMutableAttributedString = getRatedAttributedString(forRating: hospital.ratings)
            
            starAttributedString.append(NSAttributedString(string: " (\(hospital.ratings))"))
            
            ratingLabel.attributedText = starAttributedString
            
            let attributedString = NSMutableAttributedString(string: "Open For : \(hospital.openHours)")
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: NSRange(location: 0, length: "Open For : \(hospital.openHours)".count))
            
            addressLabel.text = hospital.address
            
            activityIndicator.stopAnimating()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.attributedText = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(thumbNailImageView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(addressLabel)
        
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.cornerRadius = 10
        
        loadThumbNailImageView()
        loadActivityIndicator()
        loadImageView()
        loadNameLabel()
        loadRatinglabel()
        loadAddressLabel()
    }
    
    func loadThumbNailImageView() {
        thumbNailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbNailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            thumbNailImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            thumbNailImageView.widthAnchor.constraint(equalTo: thumbNailImageView.heightAnchor),
            thumbNailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
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
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        imageView.layer.cornerRadius = 10
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -3),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
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
    
    func loadAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: -2),
            addressLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: ratingLabel.trailingAnchor)
        ])
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
}
