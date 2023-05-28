//
//  InformationValueChangeTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import UIKit

class InformationValueChangeTableViewCell: UITableViewCell {

    static let identifier = "InformationValueChangeTableViewCell"
    
    lazy var firstValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 15)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var firstValueTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.font = UIFont(name: "Helvetica", size: 15)
        
        return textField
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        contentView.addSubview(firstValueLabel)
        contentView.addSubview(firstValueTextField)
        
        loadFirstValueLabel()
        loadFirstValueTextField()
    }

    func loadFirstValueLabel() {
        firstValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        firstValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            firstValueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            firstValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            firstValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            firstValueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.17)
        ])
    }
    
    func loadFirstValueTextField() {
        firstValueTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstValueTextField.centerYAnchor.constraint(equalTo: firstValueLabel.centerYAnchor),
            firstValueTextField.leadingAnchor.constraint(equalTo: firstValueLabel.trailingAnchor),
            firstValueTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
}
