//
//  MedicalArticleCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 25/09/22.
//

import UIKit

class MedicalArticleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MedicalArticleCollectionViewCell"
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        
        activity.startAnimating()
        activity.hidesWhenStopped = true
        
        return activity
    }()
    
    lazy var imageView: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var thumbNailImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    lazy var viewForImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var titleLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.textColor = .label
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()
    
    var previousConstraits: [NSLayoutConstraint] = []
    
    var article: Article! {
        didSet{
            titleLabel.text = article.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicator.stopAnimating()
        imageView.image = nil
        titleLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(viewForImage)
        viewForImage.addSubview(thumbNailImageView)
        viewForImage.addSubview(activityIndicator)
        viewForImage.addSubview(imageView)
        contentView.addSubview(titleLabel)
        activityIndicator.startAnimating()
        
        loadViewForImage()
        loadThumbNailImage()
        loadActivityIndicator()
        loadImageView()
        loadTitleLabel()
        
        activityIndicator.stopAnimating()
    }
    
    func loadViewForImage() {
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForImage.layer.cornerRadius = 10
        
        NSLayoutConstraint.deactivate(previousConstraits)
        
        let constraints = [
            viewForImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            viewForImage.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width - 20),
            viewForImage.heightAnchor.constraint(lessThanOrEqualTo: contentView.heightAnchor, multiplier: 0.65),
            viewForImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        previousConstraits = constraints
    }
    
    func loadThumbNailImage() {
        thumbNailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        thumbNailImageView.downloaded(from: "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg")
        
        NSLayoutConstraint.activate([
            thumbNailImageView.widthAnchor.constraint(equalTo: viewForImage.widthAnchor),
            thumbNailImageView.heightAnchor.constraint(equalTo: viewForImage.heightAnchor)
        ])
        
        thumbNailImageView.layer.cornerRadius = 10
    }
    
    func loadActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor)
        ])
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: viewForImage.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: viewForImage.topAnchor),
            imageView.widthAnchor.constraint(equalTo: viewForImage.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: viewForImage.heightAnchor)
        ])
        
        guard let url = URL(string: article.urlToImage ?? "") else {
            return
        }
        
        imageView.loadImageWithUrl(url)
        
        if(imageView.image != nil){
            activityIndicator.stopAnimating()
        }
    }
    
    func loadTitleLabel(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewForImage.bottomAnchor,constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
}
