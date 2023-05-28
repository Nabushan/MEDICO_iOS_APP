//
//  PersonDetailTableViewCell.swift
//  Medico
//
//  Created by nabushan-pt5611 on 01/02/23.
//

import UIKit

class PersonDetailTableViewCell: UITableViewCell {
    
    static let identifier: String = "PersonDetailTableViewCell"
    
    lazy var label: ResizedLabel  = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        
        label.font = UIFont(name: "Helvetica", size: 15)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        loadLabel()
    }
    
    func loadLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
}
