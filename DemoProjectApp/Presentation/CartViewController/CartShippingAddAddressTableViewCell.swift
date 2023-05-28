//
//  CartShippingAddAddressTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import UIKit

class CartShippingAddAddressTableViewCell: UITableViewCell {

    static let identifier = "CartShippingAddAddressTableViewCell"
    
    lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var addShippingAddressLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .systemBlue
        label.font = UIFont(name: "Helvatica", size: 15)
        
        label.text = "Add New Shipping Address."
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(plusImageView)
        contentView.addSubview(addShippingAddressLabel)
        
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
        loadPlusImageView()
        loadAddShippingAddressLabel()
    }
    
    func loadPlusImageView() {
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        plusImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            plusImageView.topAnchor.constraint(equalTo: addShippingAddressLabel.topAnchor),
            plusImageView.bottomAnchor.constraint(equalTo: addShippingAddressLabel.bottomAnchor),
            plusImageView.widthAnchor.constraint(equalTo: addShippingAddressLabel.heightAnchor),
            plusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    func loadAddShippingAddressLabel() {
        addShippingAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addShippingAddressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            addShippingAddressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            addShippingAddressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            addShippingAddressLabel.leadingAnchor.constraint(equalTo: plusImageView.trailingAnchor, constant: 10),
        ])
    }
}
