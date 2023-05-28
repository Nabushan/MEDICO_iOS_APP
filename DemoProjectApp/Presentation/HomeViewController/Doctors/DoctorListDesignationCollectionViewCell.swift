//
//  DoctorListDesignationCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/09/22.
//

import UIKit

class DoctorListDesignationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DoctorListDesignationCollectionViewCell"
    
    let countLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.isUserInteractionEnabled = false
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = .label
        
        return label
    }()
    
    let nameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.isUserInteractionEnabled = false
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = .label
        
        return label
    }()
    
    var isCurrentlySelected: Bool = false
    
    var name: String? {
        didSet{
            nameLabel.text = name
        }
    }
    
    var count: Int? {
        didSet{
            countLabel.text = String(count ?? 0)
        }
    }
    
    var state: DoctorSpecialization? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isCurrentlySelected = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        
        loadCountLabel()
        loadNameLabel()
    }
    
    func loadCountLabel(){
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loadCountLabelAccordingTo(selected: isCurrentlySelected)
        
        NSLayoutConstraint.activate([
            countLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor),
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10)
        ])
        
        
        countLabel.layer.cornerRadius = 0.7*contentView.frame.height / 2
    }
    
    func loadNameLabel(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loadNameLabelAccordingTo(selected: isCurrentlySelected)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: countLabel.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor,constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: countLabel.bottomAnchor)
        ])
    }
    
    func loadCountLabelAccordingTo(selected: Bool){
        if(selected){
            countLabel.backgroundColor = .white
            countLabel.textColor = .systemBlue
        }
        else{
            countLabel.backgroundColor = .systemBlue
            countLabel.textColor = .white
        }
    }
    
    func loadNameLabelAccordingTo(selected: Bool){
        if(selected){
            nameLabel.textColor = .white
        }
        else{
            nameLabel.textColor = .label
        }
    }
}

extension DoctorListDesignationCollectionViewCell{
    func isCellSelected(isSelected: Bool){
        let cell = self
        isCurrentlySelected = isSelected
        
        if(isSelected){
            print("Selected State is : ",cell.state)
            cell.backgroundColor = .systemBlue
        }
        else{
            print(cell.state)
            cell.backgroundColor = contentView.backgroundColor
        }
        loadNameLabelAccordingTo(selected: isSelected)
        loadCountLabelAccordingTo(selected: isSelected)
    }
}
