//
//  PharmacyProductQuantityCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 13/10/22.
//

import UIKit

class PharmacyProductQuantityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PharmacyProductQuantityCollectionViewCell"
    
    lazy var countLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 25, weight: .medium)
        
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        countLabel.textColor = .label
    }
    
    var count: Int? {
        didSet{
            guard let count = count else {
                return
            }
            
            countLabel.text = "\(count)"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(countLabel)
        contentView.layer.cornerRadius = 10
        
        loadCountLabel()
    }
    
    func loadCountLabel() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func isSelected(_ flag: Bool){
        if(flag){
            contentView.backgroundColor = .systemBlue
            countLabel.textColor = .white
        }
        else{
            contentView.backgroundColor = nil
            countLabel.textColor = .label
        }
    }
}
