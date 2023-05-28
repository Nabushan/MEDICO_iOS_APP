//
//  AppointmentPaymentProfileTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 18/10/22.
//

import UIKit

class AppointmentPaymentProfileCollectionViewCell: UICollectionViewCell {

    static let identifier = "AppointmentPaymentProfileTableViewCell"
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
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
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var designationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    lazy var addressLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    lazy var viewForProfileImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Configure the view for the selected state
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(designationLabel)
        contentView.addSubview(addressLabel)
        
        loadProfileImageView()
        loadNameLabel()
        loadLineView()
        loadDesignationLabel()
        loadAddressLabel()
    }
    
    func loadProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            profileImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
        
        profileImageView.layer.cornerRadius = 10
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func loadLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        lineView.layer.cornerRadius = 0.5
    }
    
    func loadDesignationLabel() {
        designationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            designationLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            designationLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            designationLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
        ])
    }
    
    func loadAddressLabel() {
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: designationLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: designationLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: designationLabel.trailingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}
