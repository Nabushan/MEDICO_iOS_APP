//
//  CartCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 20/12/22.
//

import UIKit

class CartVCItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "CartVCItemCollectionViewCell"
    
    lazy var productNameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        return label
    }()
    
    lazy var productCostLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .right
        label.textAlignment = .right
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 13)
        
        return label
    }()
    
    lazy var productQuantityLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Helvatica", size: 13)
        
        return label
    }()
    
    lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    lazy var starLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.font = UIFont(name: "Helvatica", size: 13)
        
        return label
    }()
    
    lazy var totalPurhcasedPeopleLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 13)
        
        return label
    }()
    
    lazy var maxLimitReachedLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 13)
        
        let text = "(Limit Reached)"
        
        let attributedText = NSMutableAttributedString(string: text)
        
        attributedText.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 10), range: NSRange(location: 0, length: text.count))
        attributedText.addAttribute(.foregroundColor, value: UIColor.systemRed, range: NSRange(location: 0, length: text.count))
        
        label.attributedText = attributedText
        
        return label
    }()
    
    var cart: Cart? {
        didSet {
            guard let cart = cart else {
                return
            }
            
            productImageView.downloaded(from: cart.productImage)
            productNameLabel.text = cart.productName
            productCostLabel.text = "₹ \(String(format: "%.1f", (Double(cart.productQuantity) * (Double(cart.productCost) ?? 0.0))))"
            productQuantityLabel.text = "Quantity: \(cart.productQuantity) items"
            starLabel.attributedText = getRatedAttributedString(forRating: cart.productRating)
        }
    }
    
    var quantity: Int? {
        didSet {
            guard let quantity = quantity,
                  let cart = cart else {
                return
            }
            
            productCostLabel.text = "₹ \(String(format: "%.1f", (Double(quantity) * (Double(cart.productCost) ?? 0.0))))"
            productQuantityLabel.text = "Quantity: \(quantity) items"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productCostLabel)
        contentView.addSubview(productQuantityLabel)
        contentView.addSubview(starLabel)
        contentView.addSubview(maxLimitReachedLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.image = nil
        shouldShowMaxLimitReachedLabel(false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        loadProductImageView()
        loadProductNameLabel()
        loadProductQuantityLabel()
        loadProductCostLabel()
        loadStarLabel()
        loadMaxLimitReachedLabel()
    }
    
    func loadProductImageView() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            productImageView.widthAnchor.constraint(equalTo: productImageView.heightAnchor)
        ])
        
        productImageView.layer.cornerRadius = 10
    }
    
    func loadProductNameLabel() {
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        productNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            productNameLabel.bottomAnchor.constraint(equalTo: productQuantityLabel.topAnchor, constant: 3),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func loadProductQuantityLabel() {
        productQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productQuantityLabel.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            productQuantityLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
            productQuantityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func loadProductCostLabel() {
        productCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productCostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            productCostLabel.topAnchor.constraint(equalTo: starLabel.topAnchor)
        ])
    }
    
    func loadStarLabel() {
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        
        starLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            starLabel.topAnchor.constraint(equalTo: productQuantityLabel.bottomAnchor, constant: -3),
            starLabel.leadingAnchor.constraint(equalTo: productQuantityLabel.leadingAnchor),
            starLabel.trailingAnchor.constraint(equalTo: productCostLabel.leadingAnchor, constant: -5)
        ])
    }
    
    func loadMaxLimitReachedLabel() {
        maxLimitReachedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        maxLimitReachedLabel.alpha = 0
        
        NSLayoutConstraint.activate([
            maxLimitReachedLabel.centerYAnchor.constraint(equalTo: productQuantityLabel.centerYAnchor),
            maxLimitReachedLabel.trailingAnchor.constraint(equalTo: productQuantityLabel.trailingAnchor)
        ])
    }
    
    func getStarLabelText(forRating: Double) -> NSMutableAttributedString {
        let val = forRating
        
        guard let starImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1)) else {
            return NSMutableAttributedString(string: "")
        }
        
        let textAttachment = NSTextAttachment(image: starImage)
        textAttachment.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
        
        let attributedString = NSMutableAttributedString(attachment: textAttachment)
        
        attributedString.append(NSAttributedString(string: " \(val)"))
        
        return attributedString
    }
    
    func getRatedAttributedString(forRating: Double) -> NSMutableAttributedString {
        let fullStarImage = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
        
        let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")?.withRenderingMode(.alwaysOriginal)
        
        let emptyStarImage = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        let fullStars = Int(forRating)
        
        let roundedValue = round(forRating)
        
        var starsAdded = 0
        
        let mutableString = NSMutableAttributedString()
        
        for _ in 0..<fullStars {
            let imageToAppend = NSTextAttachment()
            
            imageToAppend.image = fullStarImage?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
            
            imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
            
            mutableString.append(NSMutableAttributedString(attachment: imageToAppend))
            
            starsAdded+=1
        }
        
        if(Int(roundedValue) > fullStars) {
            
            let imageToAppend = NSTextAttachment()
            
            imageToAppend.image = halfStarImage?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
            
            imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
            
            mutableString.append(NSAttributedString(attachment: imageToAppend))
            
            starsAdded+=1
        }
        
        for _ in starsAdded..<5 {
            let imageToAppend = NSTextAttachment()
            
            imageToAppend.image = emptyStarImage?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1))
            
            imageToAppend.bounds = CGRect(x: 0, y: -1, width: 15, height: 15)
            
            mutableString.append(NSAttributedString(attachment: imageToAppend))
        }
        
        mutableString.append(NSAttributedString(string: " (\(forRating))"))
        
        return mutableString
    }
    
    func shouldShowMaxLimitReachedLabel(_ flag: Bool) {
        if(flag) {
            maxLimitReachedLabel.alpha = 1
        }
        else{
            maxLimitReachedLabel.alpha = 0
        }
    }
}
