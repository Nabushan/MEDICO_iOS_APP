//
//  BookAppointmentHourCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 14/10/22.
//

import UIKit

class BookAppointmentHourCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BookAppointmentHourCollectionViewCell"
    
    lazy var timeLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    var isCellDisabled: Bool = false {
        didSet {
            if(isCellDisabled){
                contentView.alpha = 0.5
                contentView.layer.opacity = 0.5
                contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
            }
            else{
                contentView.alpha = 1
                contentView.layer.opacity = 1
                contentView.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.isCellSelected(false)
        isCellDisabled = false
        
        timeLabel.textColor = .label
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(timeLabel)
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        loadTimeLabel()
    }
    
    func loadTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if(isCellDisabled) {
            timeLabel.textColor = .secondaryLabel
        }
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func isCellSelected(_ flag: Bool){
        if(flag){
            
            contentView.backgroundColor = .systemBlue
            self.layer.borderColor = UIColor.clear.cgColor
            timeLabel.textColor = .white
            contentView.layer.cornerRadius = contentView.frame.height/2
        }
        else{
            
            contentView.backgroundColor = Theme.lightMode.mainViewBackGroundColor
            timeLabel.textColor = .label
            self.layer.borderColor = UIColor.secondaryLabel.cgColor
            contentView.layer.cornerRadius = 0
            
            print("Cell back to normal state.")
        }
    }
}
