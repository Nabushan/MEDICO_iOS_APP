//
//  CartCollectionReusableView.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 20/12/22.
//

import UIKit

class CartCollectionReusableView: UICollectionReusableView {
    static let identifier = "CartCollectionReusableView"
    
    weak var delegate: CartCheckoutProtocol?
    
    lazy var subtotalLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var offersAppliedLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var totalLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var subtotalValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var offersAppliedValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var totalValueLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var checkOutButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Pay Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
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
        
        self.backgroundColor = .clear
        
        self.addSubview(contentView)
        
        self.addSubview(subtotalLabel)
        self.addSubview(subtotalValueLabel)
        self.addSubview(offersAppliedLabel)
        self.addSubview(offersAppliedValueLabel)
        self.addSubview(totalLabel)
        self.addSubview(totalValueLabel)
        self.addSubview(checkOutButton)
        
        contentView.layer.cornerRadius = 10
        
        loadContentView()
        loadSubTotalLabel()
        loadSubTotalValueLabel()
        loadOffersAppliedLabel()
        loadOffersAppliedTableView()
        loadTotalLabel()
        loadTotalValueLabel()
        loadCheckOutButton()
    }
    
    func loadContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    func loadSubTotalLabel() {
        subtotalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtotalLabel.text = "Sub Total: "
        
        NSLayoutConstraint.activate([
            subtotalLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            subtotalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    func loadSubTotalValueLabel() {
        subtotalValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtotalValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            subtotalValueLabel.topAnchor.constraint(equalTo: subtotalLabel.topAnchor),
            subtotalValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            subtotalValueLabel.leadingAnchor.constraint(equalTo: subtotalLabel.trailingAnchor)
        ])
    }
    
    func loadOffersAppliedLabel() {
        offersAppliedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        offersAppliedLabel.text = "Offers Applied: "
        
        NSLayoutConstraint.activate([
            offersAppliedLabel.topAnchor.constraint(equalTo: subtotalLabel.bottomAnchor),
            offersAppliedLabel.leadingAnchor.constraint(equalTo: subtotalLabel.leadingAnchor)
        ])
    }
    
    func loadOffersAppliedTableView() {
        offersAppliedValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        offersAppliedValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            offersAppliedValueLabel.topAnchor.constraint(equalTo: offersAppliedLabel.topAnchor),
            offersAppliedValueLabel.trailingAnchor.constraint(equalTo: subtotalValueLabel.trailingAnchor),
            offersAppliedValueLabel.leadingAnchor.constraint(equalTo: offersAppliedLabel.trailingAnchor)
        ])
    }
    
    func loadTotalLabel() {
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalLabel.text = "Grand Total: "
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: offersAppliedLabel.bottomAnchor),
            totalLabel.leadingAnchor.constraint(equalTo: offersAppliedLabel.leadingAnchor)
        ])
    }
    
    func loadTotalValueLabel() {
        totalValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        totalValueLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            totalValueLabel.topAnchor.constraint(equalTo: totalLabel.topAnchor),
            totalValueLabel.trailingAnchor.constraint(equalTo: offersAppliedValueLabel.trailingAnchor),
            totalValueLabel.leadingAnchor.constraint(equalTo: totalLabel.trailingAnchor)
        ])
    }
    
    func loadCheckOutButton() {
        checkOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        checkOutButton.addTarget(self, action: #selector(didTapCheckOut), for: .touchUpInside)
        
        checkOutButton.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            checkOutButton.trailingAnchor.constraint(equalTo: totalValueLabel.trailingAnchor),
            checkOutButton.topAnchor.constraint(equalTo: totalValueLabel.bottomAnchor, constant: 5),
            checkOutButton.widthAnchor.constraint(equalToConstant: checkOutButton.intrinsicContentSize.width + 30),
            checkOutButton.heightAnchor.constraint(equalToConstant: checkOutButton.intrinsicContentSize.height - 5)
        ])
    }
    
    @objc func didTapCheckOut(_ sender: UIButton) {
        delegate?.didTapCheckOut()
    }
}
