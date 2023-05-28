//
//  AddMedicineCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/09/22.
//

import UIKit

class AddMedicineCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AddMedicineCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    var imageName: String! {
        didSet{
            imageView.image = UIImage(named: imageName)
            activityIndicator.stopAnimating()
        }
    }
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    lazy var medNameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.textAlignment = .center
        label.contentMode = .center 
        label.font = UIFont(name: "Helvetica", size: 15)
        label.textColor = .label
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicator.stopAnimating()
        isCellSelected(false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(medNameLabel)
        contentView.addSubview(imageView)
        
        contentView.layer.cornerRadius = 10
        
        loadMedNameLabel()
        loadImageView()
    }
    
    func loadMedNameLabel() {
        medNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        medNameLabel.text = imageName
        
        NSLayoutConstraint.activate([
            medNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            medNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            medNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if(imageView.image != nil){
            activityIndicator.stopAnimating()
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: medNameLabel.bottomAnchor,constant: 5),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func isCellSelected(_ flag: Bool) {
        if(flag){
            contentView.backgroundColor = .systemBlue
            medNameLabel.textColor = .white
        }
        else{
            contentView.backgroundColor = Theme.lightMode.mainViewBackGroundColor
            medNameLabel.textColor = .label
        }
    }
}
