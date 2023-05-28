//
//  DoctorListCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/09/22.
//

import UIKit

class DoctorListCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "DoctorListCollectionViewCell"
    
    lazy var viewForImage = UIView()
    
    lazy var imageView: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.contentMode = .scaleAspectFit
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
        label.text = "Lorem Ipsum"
        
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
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.text = "Lorem Ipsum"
        
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
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.text = "Lorem Ipsum"
        
        return label
    }()
    
    lazy var numberOfRatersLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .right
        label.textAlignment = .right
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.text = "Lorem Ipsum"
        
        return label
    }()
    
    var docName: NSMutableAttributedString? {
        didSet{
            nameLabel.attributedText = docName
        }
    }
    
    var qualification: String? {
        didSet {
            qualificationLabel.text = qualification
        }
    }
    
    var imageName: String? {
        didSet {
            print(imageName)
            
            guard let imageName = imageName,
                  let url = URL(string: imageName) else {
                return
            }
            
            imageView.loadImageWithUrl(url)
        }
    }
    
    var rating: Double? {
        didSet {
            let attributedString = NSMutableAttributedString( attributedString: getRatedAttributedString(forRating: rating ?? 0.0))
            
            attributedString.append(NSAttributedString(string: " (\(rating ?? 0.0))"))
            
            ratingLabel.attributedText = attributedString
        }
    }
    
    var totalRaters: Int? {
        didSet{
        
            let string = "\(totalRaters ?? -1) Raters"
            let attributedString = NSMutableAttributedString(string: string)
            
            attributedString.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 15), range: NSRange(location: 0, length: string.count))
            
            numberOfRatersLabel.attributedText = attributedString
        }
    }
    
    var viewForImageConstraints: [NSLayoutConstraint] = []
    var previouslySelectedConstraints: [NSLayoutConstraint] = []
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        NSLayoutConstraint.deactivate(viewForImageConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(viewForImage)
        viewForImage.addSubview(activityIndicator)
        viewForImage.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(qualificationLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(numberOfRatersLabel)
        
        loadContents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previouslySelectedConstraints)
        
       loadContents()
    }
    
    func loadContents() {
        loadViewForImage()
        loadActivityIndicator()
        loadImageView()
        loadNameLabel()
        loadQualificationLabel()
        loadRatingLabel()
        loadNumberOfRatersLabel()
    }
    
    func loadViewForImage() {
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForImage.layer.cornerRadius = 10
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            viewForImageConstraints = [
                viewForImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
                viewForImage.widthAnchor.constraint(equalTo: viewForImage.heightAnchor),
                viewForImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                viewForImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0.1*contentView.frame.height)
            ]
        }
        else{
            viewForImageConstraints = [
                viewForImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
                viewForImage.widthAnchor.constraint(equalTo: viewForImage.heightAnchor),
                viewForImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                viewForImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0.1*contentView.frame.height)
            ]
        }
        
        NSLayoutConstraint.activate(viewForImageConstraints)
        
        for viewForImageConstraint in viewForImageConstraints {
            previouslySelectedConstraints.append(viewForImageConstraint)
        }
    }
    
    func loadActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor)
        ])
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 10
        if(imageView.image != nil){
            activityIndicator.stopAnimating()
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: viewForImage.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: viewForImage.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewForImage.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: viewForImage.bottomAnchor)
        ])
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor,constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10)
        ])
    }
    
    func loadQualificationLabel() {
        qualificationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            qualificationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 0),
            qualificationLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10),
            qualificationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10)
        ])
    }
    
    func loadRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ratingLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: qualificationLabel.bottomAnchor, constant: 0),
            ratingLabel.leadingAnchor.constraint(equalTo: qualificationLabel.leadingAnchor),
        ])
    }
    
    func loadNumberOfRatersLabel() {
        numberOfRatersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberOfRatersLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor),
            numberOfRatersLabel.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            numberOfRatersLabel.trailingAnchor.constraint(equalTo: qualificationLabel.trailingAnchor)
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
