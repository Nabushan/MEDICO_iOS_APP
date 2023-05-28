//
//  CartShippingNewAddressEntryTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import UIKit

class CartShippingNewAddressEntryTableViewCell: UITableViewCell {

    static let identifier = "CartShippingNewAddressEntryTableViewCell"
    
    lazy var textField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 20
        )
        
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textField)
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadInitView() {
        loadTextField()
    }
    
    func loadTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
