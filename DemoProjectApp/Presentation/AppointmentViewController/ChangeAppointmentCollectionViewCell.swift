//
//  ChangeAppointmentCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/10/22.
//

import UIKit

class ChangeAppointmentCollectionViewCell: UICollectionViewCell {
    static let identifier = "ChangeAppointmentCollectionViewCell"
    
    lazy var selectorImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = nonSelectedImage
        
        return imageView
    }()
    
    lazy var nonSelectedImage: UIImage? = {
        let image = UIImage(systemName: "circle")
        
        return image
    }()
    
    lazy var selectedImage: UIImage? = {
        let image = UIImage(systemName: "circle.circle.fill")
        
        return image
    }()
    
    lazy var label: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(selectorImageView)
        contentView.addSubview(label)
        
        loadSelectorImageView()
        loadLabel()
    }
    
    func loadSelectorImageView() {
        selectorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        selectorImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        selectorImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            selectorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
    }
    
    func loadLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: selectorImageView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: selectorImageView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
    func isCellSelected(_ flag: Bool){
        if(flag){
            selectorImageView.image = selectedImage
        }
        else{
            selectorImageView.image = nonSelectedImage
        }
    }
}
