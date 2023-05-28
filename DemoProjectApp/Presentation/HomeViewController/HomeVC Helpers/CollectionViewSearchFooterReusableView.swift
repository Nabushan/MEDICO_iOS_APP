//
//  CollectionViewSearchFooterReusableView.swift
//  Medico
//
//  Created by nabushan-pt5611 on 13/01/23.
//

import UIKit

class CollectionViewSearchFooterReusableView: UICollectionReusableView {
    static let identifier = "CollectionViewSearchFooterReusableView"
    
    lazy var label: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
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
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
