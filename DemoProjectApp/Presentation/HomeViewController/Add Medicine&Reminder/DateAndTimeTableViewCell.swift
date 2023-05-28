//
//  DateAndTimeTableViewCell.swift
//  Medico
//
//  Created by nabushan-pt5611 on 05/02/23.
//

import UIKit

class DateAndTimeTableViewCell: UITableViewCell {

    static let identifier = "DateAndTimeTableViewCell"
    
    lazy var toggleSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        
        return toggleSwitch
    }()
    
    lazy var viewForDisplayImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var displayImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false

        return imageView
    }()
    
    lazy var headerLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvetica", size: 15)
        label.contentMode = .left
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var valueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.textColor = .systemBlue
        label.font = UIFont(name: "Helvetica", size: 13)
        label.contentMode = .left
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var selectionLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Helvetica", size: 15)
        label.contentMode = .left
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var centeredHeaderLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvetica", size: 15)
        label.contentMode = .left
        label.textAlignment = .left
        
        return label
    }()
    
    var hideStepper: Bool = false {
        didSet {
            if(hideStepper) {
                toggleSwitch.isHidden = true
                headerLabel.isHidden = true
                selectionLabel.isHidden = false
                centeredHeaderLabel.isHidden = false
                
                toggleSwitch.isUserInteractionEnabled = false
                self.accessoryType = .disclosureIndicator
            }
            else{
                toggleSwitch.isHidden = false
                selectionLabel.isHidden = true
                
                self.accessoryType = .disclosureIndicator
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(toggleSwitch)
        contentView.addSubview(viewForDisplayImage)
        viewForDisplayImage.addSubview(displayImageView)
        contentView.addSubview(headerLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(selectionLabel)
        contentView.addSubview(centeredHeaderLabel)
        
        selectionLabel.isHidden = true
        centeredHeaderLabel.isHidden = true
        
        loadInitView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadInitView() {
        loadToggleSwitch()
        loadViewForDisplayImage()
        loadDisplayImageView()
        loadHeaderLabel()
        loadValueLabel()
        loadSelectionLabel()
        loadCenteredHeaderLabel()
    }
    
    func loadToggleSwitch() {
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toggleSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            toggleSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            toggleSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func loadViewForDisplayImage() {
        viewForDisplayImage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForDisplayImage.layer.cornerRadius = 5
        
        NSLayoutConstraint.activate([
            viewForDisplayImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            viewForDisplayImage.topAnchor.constraint(equalTo: toggleSwitch.topAnchor),
            viewForDisplayImage.bottomAnchor.constraint(equalTo: toggleSwitch.bottomAnchor),
            viewForDisplayImage.widthAnchor.constraint(equalTo: viewForDisplayImage.heightAnchor)
        ])
    }
    
    func loadDisplayImageView() {
        displayImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            displayImageView.topAnchor.constraint(equalTo: viewForDisplayImage.topAnchor, constant: 5),
            displayImageView.leadingAnchor.constraint(equalTo: viewForDisplayImage.leadingAnchor, constant: 5),
            displayImageView.trailingAnchor.constraint(equalTo: viewForDisplayImage.trailingAnchor, constant: -5),
            displayImageView.bottomAnchor.constraint(equalTo: viewForDisplayImage.bottomAnchor, constant: -5),
        ])
    }
        
    func loadHeaderLabel() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: toggleSwitch.topAnchor, constant: -5),
            headerLabel.leadingAnchor.constraint(equalTo: viewForDisplayImage.trailingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: toggleSwitch.leadingAnchor, constant: -10)
        ])
    }
    
    func loadCenteredHeaderLabel() {
        centeredHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centeredHeaderLabel.centerYAnchor.constraint(equalTo: displayImageView.centerYAnchor),
            centeredHeaderLabel.leadingAnchor.constraint(equalTo: viewForDisplayImage.trailingAnchor, constant: 10),
            centeredHeaderLabel.trailingAnchor.constraint(equalTo: toggleSwitch.leadingAnchor, constant: -10)
        ])
    }
    
    func loadValueLabel() {
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: -10),
            valueLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor)
        ])
    }
    
    func loadSelectionLabel(){
        selectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectionLabel.centerYAnchor.constraint(equalTo: toggleSwitch.centerYAnchor),
            selectionLabel.trailingAnchor.constraint(equalTo: toggleSwitch.trailingAnchor, constant: 5)
        ])
    }
}
