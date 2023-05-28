//
//  SectionHeaderCollectionReusableView.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 24/09/22.
//

import UIKit

class SectionHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "SectionHeaderCollectionReusableView"
    
    var sectionHeading: String? {
        didSet{
            label.text = sectionHeading
        }
    }
    
    var fontSize: Int? {
        didSet{
            label.font = UIFont(name: "Helvetica", size: CGFloat(fontSize ?? 15))
        }
    }
    
    let label: ResizedLabel = {
        let label = ResizedLabel()
        
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.sizeToFit()
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(label)
        
        loadLabel()
    }
    
    private func loadLabel(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        
        let constraints = [
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

