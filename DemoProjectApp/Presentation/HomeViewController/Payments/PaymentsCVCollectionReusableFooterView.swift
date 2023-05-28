//
//  PaymentsCVCollectionReusableFooterView.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 19/10/22.
//

import UIKit

class PaymentsCVCollectionReusableFooterView: UICollectionReusableView {
    
    static let identifier = "PaymentsCVCollectionReusableFooterView"
    
    lazy var button: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = button.intrinsicContentSize.height/2
        
        return button
    }()
    
    weak var delegateForFooter: PaymentsAddNewCardProtocol?
    var deActivateConstraints: [NSLayoutConstraint] = []
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(button)
        
        loadButton()
    }
    
    func loadButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.deactivate(deActivateConstraints)
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                button.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
                button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
            ]
            
            NSLayoutConstraint.activate(constraints)
            deActivateConstraints = constraints
        }
        else{
            let constraints = [
                button.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            ]
            
            NSLayoutConstraint.activate(constraints)
            deActivateConstraints = constraints
        }
    
        button.backgroundColor = UIColor(red: 233/255, green: 240/255, blue: 255/255, alpha: 1)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.cornerRadius = 10
        button.setTitle("Add New Card", for: .normal)
        
        button.addTarget(self, action: #selector(didTapAddNewCardButton), for: .touchUpInside)
    }
    
    @objc func didTapAddNewCardButton(_ button: UIButton) {
        delegateForFooter?.addNewCard()
    }
}
