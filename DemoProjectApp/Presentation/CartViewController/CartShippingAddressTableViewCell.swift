//
//  CartShippingAddressTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import UIKit

class CartShippingAddressTableViewCell: UITableViewCell {

    static let identifier: String = "CartShippingAddressTableViewCell"
    
    lazy var nameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        label.text = "Name"
        
        return label
    }()
    
    lazy var contactNumberLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        label.text = "Contact No"
        
        return label
    }()
    
    lazy var doorNumberLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        label.text = "Door No"
        
        return label
    }()
    
    lazy var addressLineOneLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        label.text = "Add Line1"
        
        return label
    }()
    
    lazy var addressLineTwoLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        label.text = "Add Line2"
        
        return label
    }()
    
    lazy var pincodeLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        label.text = "Pincode"
        
        return label
    }()
    
    lazy var nameValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var contactNumberValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var doorNumberValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var addressLineOneValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var addressLineTwoValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var pincodeValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var selectedLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 13)
        
        let attributedString = NSMutableAttributedString(string: "Selected")
        
        attributedString.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 13), range: NSRange(location: 0, length: 8))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: NSRange(location: 0, length: 8))
        
        label.attributedText = attributedString
        
        return label
    }()
    
    var shippingAddress: ShippingAddress? {
        didSet {
            guard let shippingAddress = shippingAddress else {
                return
            }
            
            nameValueLabel.text = ": "+shippingAddress.name
            contactNumberValueLabel.text = ": "+shippingAddress.contactNumber
            doorNumberValueLabel.text = ": "+shippingAddress.doorNumber
            addressLineOneValueLabel.text = ": "+shippingAddress.addressLine1
            addressLineTwoValueLabel.text = ": "+shippingAddress.addressLine2
            pincodeValueLabel.text = ": "+shippingAddress.pincode
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(contactNumberLabel)
        contentView.addSubview(doorNumberLabel)
        contentView.addSubview(addressLineOneLabel)
        contentView.addSubview(addressLineTwoLabel)
        contentView.addSubview(pincodeLabel)
        contentView.addSubview(nameValueLabel)
        contentView.addSubview(contactNumberValueLabel)
        contentView.addSubview(doorNumberValueLabel)
        contentView.addSubview(addressLineOneValueLabel)
        contentView.addSubview(addressLineTwoValueLabel)
        contentView.addSubview(pincodeValueLabel)
        contentView.addSubview(selectedLabel)
        
        loadInitView()
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
        
//        selectedLabel.alpha = 0
        isCellSelected(false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadInitView() {
        loadNameLabel()
        loadContactNumberLabel()
        loadDoorNumberLabel()
        loadAddressLineOneLabel()
        loadAddressLineTwoLabel()
        loadPincodeLabel()
        loadNameValueLabel()
        loadContactNumberValueLabel()
        loadDoorNumberValueLabel()
        loadAddressLineOneValueLabel()
        loadAddressLineTwoValueLabel()
        loadPincodeValueLabel()
        loadSelectedLabel()
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: nameValueLabel.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contactNumberLabel.widthAnchor)
        ])
    }
    
    func loadContactNumberLabel() {
        contactNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contactNumberLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contactNumberLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            contactNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            contactNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contactNumberLabel.trailingAnchor.constraint(equalTo: contactNumberValueLabel.leadingAnchor),
            contactNumberLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func loadDoorNumberLabel() {
        doorNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doorNumberLabel.topAnchor.constraint(equalTo: contactNumberLabel.bottomAnchor),
            doorNumberLabel.leadingAnchor.constraint(equalTo: contactNumberLabel.leadingAnchor),
            doorNumberLabel.widthAnchor.constraint(equalTo: contactNumberLabel.widthAnchor),
            doorNumberLabel.trailingAnchor.constraint(equalTo: doorNumberValueLabel.leadingAnchor)
        ])
    }
    
    func loadAddressLineOneLabel() {
        addressLineOneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLineOneLabel.topAnchor.constraint(equalTo: doorNumberLabel.bottomAnchor),
            addressLineOneLabel.leadingAnchor.constraint(equalTo: doorNumberLabel.leadingAnchor),
            addressLineOneLabel.widthAnchor.constraint(equalTo: doorNumberLabel.widthAnchor),
            addressLineOneLabel.heightAnchor.constraint(equalTo: addressLineOneValueLabel.heightAnchor),
            addressLineOneLabel.trailingAnchor.constraint(equalTo: addressLineOneValueLabel.leadingAnchor)
        ])
    }
    
    func loadAddressLineTwoLabel() {
        addressLineTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLineTwoLabel.topAnchor.constraint(equalTo: addressLineOneLabel.bottomAnchor),
            addressLineTwoLabel.leadingAnchor.constraint(equalTo: addressLineOneLabel.leadingAnchor),
            addressLineTwoLabel.widthAnchor.constraint(equalTo: addressLineOneLabel.widthAnchor),
            addressLineTwoLabel.heightAnchor.constraint(equalTo: addressLineTwoValueLabel.heightAnchor),
            addressLineTwoLabel.trailingAnchor.constraint(equalTo: addressLineTwoValueLabel.leadingAnchor)
        ])
    }
    
    func loadPincodeLabel() {
        pincodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pincodeLabel.topAnchor.constraint(equalTo: addressLineTwoLabel.bottomAnchor),
            pincodeLabel.leadingAnchor.constraint(equalTo: addressLineTwoLabel.leadingAnchor),
            pincodeLabel.widthAnchor.constraint(equalTo: addressLineTwoLabel.widthAnchor),
            pincodeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            pincodeLabel.trailingAnchor.constraint(equalTo: pincodeValueLabel.leadingAnchor)
        ])
    }
    
    func loadNameValueLabel() {
        nameValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameValueLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func loadContactNumberValueLabel() {
        contactNumberValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactNumberValueLabel.topAnchor.constraint(equalTo: nameValueLabel.bottomAnchor),
            contactNumberValueLabel.trailingAnchor.constraint(equalTo: nameValueLabel.trailingAnchor)
        ])
    }
    
    func loadDoorNumberValueLabel() {
        doorNumberValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doorNumberValueLabel.topAnchor.constraint(equalTo: contactNumberValueLabel.bottomAnchor),
            doorNumberValueLabel.trailingAnchor.constraint(equalTo: contactNumberValueLabel.trailingAnchor)
        ])
    }
    
    func loadAddressLineOneValueLabel() {
        addressLineOneValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLineOneValueLabel.topAnchor.constraint(equalTo: doorNumberValueLabel.bottomAnchor),
            addressLineOneValueLabel.trailingAnchor.constraint(equalTo: doorNumberValueLabel.trailingAnchor)
        ])
    }
    
    func loadAddressLineTwoValueLabel() {
        addressLineTwoValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLineTwoValueLabel.topAnchor.constraint(equalTo: addressLineOneValueLabel.bottomAnchor),
            addressLineOneValueLabel.trailingAnchor.constraint(equalTo: addressLineTwoValueLabel.trailingAnchor)
        ])
    }
    
    func loadPincodeValueLabel() {
        pincodeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pincodeValueLabel.topAnchor.constraint(equalTo: addressLineTwoValueLabel.bottomAnchor),
            pincodeValueLabel.trailingAnchor.constraint(equalTo: addressLineTwoValueLabel.trailingAnchor),
            pincodeValueLabel.bottomAnchor.constraint(equalTo: pincodeLabel.bottomAnchor)
        ])
    }
    
    func loadSelectedLabel() {
        selectedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectedLabel.bottomAnchor.constraint(equalTo: pincodeValueLabel.bottomAnchor),
            selectedLabel.trailingAnchor.constraint(equalTo: pincodeValueLabel.trailingAnchor)
        ])
    }
    
    func isCellSelected(_ flag: Bool) {
        if(flag) {
            selectedLabel.alpha = 0
            self.accessoryType = .checkmark
        }
        else {
            selectedLabel.alpha = 0
            self.accessoryType = .none
        }
    }
}
