//
//  CollectionCartHeaderReusableView.swift
//  Medico
//
//  Created by nabushan-pt5611 on 22/01/23.
//

import UIKit

class CollectionCartHeaderReusableView: UICollectionReusableView {
    static let identifier = "CollectionCartHeaderReusableView"
    
    lazy var label: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Helvetica", size: 15)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.contentMode = .center
        
        return label
    }()
    
    var searchResults: String? {
        didSet{
            guard let searchResults = self.searchResults else {
                return
            }
            
            label.text = searchResults
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(label)
        
        loadLabel()
    }
    
    func loadLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

