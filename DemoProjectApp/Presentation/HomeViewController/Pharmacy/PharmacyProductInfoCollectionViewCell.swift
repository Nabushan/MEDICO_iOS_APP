//
//  PharmacyProductInfoCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 13/10/22.
//

import UIKit

class PharmacyProductInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PharmacyProductInfoCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var infoLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    var text: String? {
        didSet{
            guard let text = text else {
                return
            }
            
            infoLabel.text = text
        }
    }
    
    var imageLink: String? {
        didSet{
            guard let imageLink = imageLink else {
                return
            }
            
            imageView.downloaded(from: imageLink, shouldRender: true, withColor: .white)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(imageView)
        contentView.addSubview(infoLabel)
        
        loadContents()
    }
    
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        
        previousConstraintsToDeActivate = []
        
        loadContents()
    }
    
    func loadContents() {
        loadImageView()
        loadInfoLabel()
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            imageView.trailingAnchor.constraint(equalTo: infoLabel.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel.textColor = .white
        
        let constraints = [
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
}
