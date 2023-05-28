//
//  InformationDetailVCTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import UIKit

class InformationDetailVCTableViewCell: UITableViewCell {

    static let identifier = "InformationDetailVCTableViewCell"
    
    lazy var contentLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 15)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var contentDateLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 15)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    var shouldShowChevronRight: Bool = false
    var shouldShowDateContentLabel: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        contentView.addSubview(contentLabel)
        
        if(shouldShowDateContentLabel) {
            contentView.addSubview(contentDateLabel)
        }
        
        loadContentLabel()
        if(shouldShowChevronRight && shouldShowDateContentLabel == false){
            self.accessoryType = .disclosureIndicator
        }
        
        if(shouldShowDateContentLabel && shouldShowChevronRight == false) {
            loadContentDateLabel()
        }
        
    }

    func loadContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        if(shouldShowChevronRight && shouldShowDateContentLabel == false) {
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        }
        
        if(shouldShowDateContentLabel && shouldShowChevronRight == false) {
            contentLabel.trailingAnchor.constraint(equalTo: contentDateLabel.leadingAnchor, constant: -10).isActive = true
        }
        
        if(!shouldShowChevronRight && !shouldShowDateContentLabel) {
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        }
    }
    
    func loadContentDateLabel() {
        contentDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentDateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            contentDateLabel.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
            contentDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
}
