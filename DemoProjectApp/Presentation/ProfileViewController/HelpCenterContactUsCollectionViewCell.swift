//
//  HelpCenterContactUsCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 13/12/22.
//

import UIKit

class HelpCenterContactUsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HelpCenterContactUsCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.font = UIFont(name: "Helvetica", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.contentMode = .left
        label.textAlignment = .left
        
        return label
    }()
    
    var imageName: String? {
        didSet {
            guard let imageName = imageName else {
                return
            }
            
            imageView.image = UIImage(systemName: imageName)
        }
    }
    
    var textValue: String? {
        didSet {
            guard let textValue = textValue else {
                return
            }
            
            textLabel.text = textValue
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        
        contentView.backgroundColor = Theme.lightMode.subViewBackGroundColor
        contentView.layer.cornerRadius = 10
        
        loadImageView()
        loadTextLabel()
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageView.heightAnchor.constraint(equalTo: textLabel.heightAnchor, multiplier: 1.3),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    func loadTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}
