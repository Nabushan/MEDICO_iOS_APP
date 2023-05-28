//
//  OnboardingCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 29/12/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var label: ResizedLabel = {
        let label = ResizedLabel()
        
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        
        return label
    }()
    
    var image: String? {
        didSet {
            guard let image = image else{
                return
            }
            
            imageView.image = UIImage(named: image)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        loadImageView()
        loadLabel()
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
    }
    
    func loadLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            label.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
