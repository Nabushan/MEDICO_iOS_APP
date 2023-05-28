//
//  EmergencyProfileTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 05/10/22.
//

import UIKit

class EmergencyProfileTableViewCell: UITableViewCell {

    static let identifier = "EmergencyProfileTableViewCell"
    
    lazy var contactName: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    var emergencyContact: EmergencyContact? {
        didSet{
            guard let emergencyContact = emergencyContact else {
                return
            }

            contactName.text = emergencyContact.firstName+" "+emergencyContact.lastName
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.addSubview(contactName)
        loadContactName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }
   
    func loadContactName() {
        contactName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            contactName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            contactName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            contactName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15)
        ])
    }
}
