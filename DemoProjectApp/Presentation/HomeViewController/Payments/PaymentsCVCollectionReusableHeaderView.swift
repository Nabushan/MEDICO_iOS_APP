//
//  PaymentsCVCollectionReusableHeaderView.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 19/10/22.
//

import UIKit

class PaymentsCVCollectionReusableHeaderView: UICollectionReusableView {
    
    static let identifier = "PaymentsCVCollectionReusableHeaderView"
    
    lazy var label: ResizedLabel = {
        let label = ResizedLabel()

        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .regular)

        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(label)
        
        loadLabel()
    }
    
    func loadLabel() {
        label.text = "Select the payment method you want to use."
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0),
        ])
    }
}
