//
//  AddmedicineVCTableViewCell.swift
//  Medico
//
//  Created by nabushan-pt5611 on 05/02/23.
//

import UIKit

class AddmedicineVCTableViewCell: UITableViewCell {

    static let identifier = "AddmedicineVCTableViewCell"
    
    lazy var dateAndTimeImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "calendar.badge.clock")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    lazy var label: ResizedLabel = {
        let label = ResizedLabel()
        
        label.font = UIFont(name: "Helvetica", size: 15)
        label.contentMode = .left
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Select Date & Time"
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dateAndTimeImageView)
        contentView.addSubview(label)
        
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
        loadImageView()
        loadLabel()
    }
    
    func loadImageView() {
        dateAndTimeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateAndTimeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateAndTimeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            dateAndTimeImageView.heightAnchor.constraint(equalToConstant: 35),
            dateAndTimeImageView.widthAnchor.constraint(equalTo: dateAndTimeImageView.heightAnchor)
        ])
    }
    
    func loadLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: dateAndTimeImageView.trailingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
