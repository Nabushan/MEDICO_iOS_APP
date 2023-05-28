//
//  MedicineInformationCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/09/22.
//

import UIKit

class MedicineInformationCollectionViewCell: UICollectionViewCell {
    static let identifier = "MedicineInformationCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var textLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.contentMode = .left
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
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
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        
        loadImageView()
        loadTextLabel()
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10)
        ])
    }
    
    func loadTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 5),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5)
        ])
    }
}
