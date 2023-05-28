//
//  PharmacyListCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 11/10/22.
//

import UIKit

class PharmacyListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PharmacyListCollectionViewCell"
    
    lazy var viewForImage: UIView = {
        let view = UIImageView()
        
        return view
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
    
    lazy var acticityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    lazy var pharmacyImageView: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
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
        label.font = UIFont(name: "Helvetica", size: 20)
        
        return label
    }()
    
    lazy var addressLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 3
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()
    
    lazy var ratingAndDistanceLabel: ResizedLabel = {
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
    
    var pharmacy: Pharmacy? {
        didSet{
            guard let pharmacy = pharmacy else {
                return
            }
            
            nameLabel.text = pharmacy.name
            
            let attributedString = NSMutableAttributedString()
            
            attributedString.append(getRatedAttributedString(forRating: pharmacy.ratingOutOfFive))
            attributedString.append(NSMutableAttributedString(string: " | "))
            attributedString.append(getKMAttributedString(forKm: pharmacy.kmValue))
            
            addressLabel.text = pharmacy.address
            ratingAndDistanceLabel.attributedText = attributedString
            
            guard let url = URL(string: pharmacy.pharmacyImage) else {
                return
            }
            
            pharmacyImageView.loadImageWithUrl(url)
            
            if(pharmacyImageView.image != nil){
                acticityIndicator.stopAnimating()
            }
        }
    }
    
    var imageCenterAnchor: NSLayoutConstraint?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        acticityIndicator.stopAnimating()
        imageCenterAnchor?.isActive = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(viewForImage)
        viewForImage.addSubview(thumbNailImageView)
        viewForImage.addSubview(acticityIndicator)
        viewForImage.addSubview(pharmacyImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(ratingAndDistanceLabel)
        
        loadViewForImage()
        loadThumbNailImageView()
        loadActicityIndicator()
        loadPharmacyImageView()
        loadNameLabel()
        loadAddressLabel()
        loadRatingAndDistanceLabel()
    }
    
    func loadViewForImage() {
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        
        imageCenterAnchor = viewForImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        guard let imageCenterAnchor = imageCenterAnchor else {
            return
        }
        
        NSLayoutConstraint.activate([
            viewForImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            viewForImage.widthAnchor.constraint(equalTo: viewForImage.heightAnchor),
            imageCenterAnchor,
            viewForImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
        
        viewForImage.layer.cornerRadius = 10
    }
    
    func loadThumbNailImageView() {
        thumbNailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbNailImageView.topAnchor.constraint(equalTo: viewForImage.topAnchor),
            thumbNailImageView.leadingAnchor.constraint(equalTo: viewForImage.leadingAnchor),
            thumbNailImageView.trailingAnchor.constraint(equalTo: viewForImage.trailingAnchor),
            thumbNailImageView.bottomAnchor.constraint(equalTo: viewForImage.bottomAnchor),
        ])
        
        thumbNailImageView.layer.cornerRadius = 10
    }
    
    func loadActicityIndicator() {
        acticityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        acticityIndicator.startAnimating()
        
        NSLayoutConstraint.activate([
            acticityIndicator.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor),
            acticityIndicator.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor),
        ])
    }
    
    func loadPharmacyImageView() {
        pharmacyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if(pharmacyImageView.image != nil){
            acticityIndicator.stopAnimating()
        }
        
        NSLayoutConstraint.activate([
            pharmacyImageView.topAnchor.constraint(equalTo: viewForImage.topAnchor),
            pharmacyImageView.leadingAnchor.constraint(equalTo: viewForImage.leadingAnchor),
            pharmacyImageView.trailingAnchor.constraint(equalTo: viewForImage.trailingAnchor),
            pharmacyImageView.bottomAnchor.constraint(equalTo: viewForImage.bottomAnchor),
        ])
        
        pharmacyImageView.layer.cornerRadius = 10
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .boldSystemFont(ofSize: 18)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: viewForImage.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func loadAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addressLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -5),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    func loadRatingAndDistanceLabel(){
        ratingAndDistanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingAndDistanceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        ratingAndDistanceLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        ratingAndDistanceLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            ratingAndDistanceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 0),
            ratingAndDistanceLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor),
            ratingAndDistanceLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            ratingAndDistanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
            
    func getKMAttributedString(forKm: String) -> NSMutableAttributedString {
        let image = UIImage(systemName: "mappin.and.ellipse")?.withRenderingMode(.alwaysOriginal)
        
        let imageToAppend = NSTextAttachment()
        
        imageToAppend.image = image?.withTintColor(.systemBlue)
        
        imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
        
        let mutableString = NSMutableAttributedString(attachment: imageToAppend)
        
        mutableString.append(NSMutableAttributedString(string: " \(forKm)"))
        
        return mutableString
    }
            
    func getRatedAttributedString(forRating: Int) -> NSMutableAttributedString {
        let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        
        let imageToAppend = NSTextAttachment()
        
        imageToAppend.image = image?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
        
        imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
        
        let mutableString = NSMutableAttributedString(attachment: imageToAppend)
        
        mutableString.append(NSMutableAttributedString(string: " \(String(forRating))"))
        
        return mutableString
    }
}
