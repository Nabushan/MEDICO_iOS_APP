//
//  BookAppointmentPaymentsTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 17/10/22.
//

import UIKit

class PaymentsCollectionViewCell: UICollectionViewCell {

    static let identifier = "PaymentsCollectionViewCell"
    
    lazy var paymentImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    lazy var paymentLabel: ResizedLabel = {
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
    
    lazy var radioButtonImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var changeButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Change", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        
        return button
    }()
    
    lazy var notSelectedImage = UIImage(systemName: "circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
    
    lazy var selectedImage = UIImage(systemName: "circle.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
    
    var showRadioButton: Bool = false
    
    var cardImage: String = ""
    var cardRawValue: PaymentType = .applePay
    var cardNumber: String = ""
    
    weak var delegate: ShowAvailableCardForChangeProtocol?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        delegate = nil
        paymentImageView.image = nil
        radioButtonImageView.image = nil
    }    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Configure the view for the selected state
        
        contentView.addSubview(paymentImageView)
        contentView.addSubview(paymentLabel)
        
        if(showRadioButton){
            contentView.addSubview(radioButtonImageView)
        }
        else{
            contentView.addSubview(changeButton)
        }
        contentView.backgroundColor = .secondarySystemBackground
        
        loadPaymentImageView()
        loadPaymentLabel()
        if(showRadioButton){
            loadRadioButtonImageView()
        }
        else{
            loadChangeButton()
        }
    }
    
    func loadPaymentImageView() {
        paymentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        paymentImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        paymentImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            paymentImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            paymentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            paymentImageView.trailingAnchor.constraint(equalTo: paymentLabel.leadingAnchor, constant: -15),
            paymentImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            paymentImageView.widthAnchor.constraint(equalTo: paymentImageView.heightAnchor)
        ])
    }
    
    func loadPaymentLabel() {
        paymentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        paymentLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        paymentLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        
        NSLayoutConstraint.activate([
            paymentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            paymentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func loadRadioButtonImageView() {
        radioButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        radioButtonImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        radioButtonImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        
        NSLayoutConstraint.activate([
            radioButtonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioButtonImageView.heightAnchor.constraint(equalTo: paymentImageView.heightAnchor, multiplier: 0.5),
            radioButtonImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            radioButtonImageView.leadingAnchor.constraint(equalTo: paymentLabel.trailingAnchor),
            radioButtonImageView.widthAnchor.constraint(equalTo: radioButtonImageView.heightAnchor)
        ])
    }
    
    func loadChangeButton() {
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        
        changeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        changeButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        changeButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        changeButton.addTarget(self, action: #selector(didTapChange), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            changeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            changeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            changeButton.leadingAnchor.constraint(equalTo: paymentLabel.trailingAnchor),
        ])
    }
    
    func isRowSelected(_ flag: Bool){
        if(flag){
            radioButtonImageView.image = selectedImage
        }
        else{
            radioButtonImageView.image = notSelectedImage
        }
    }
    
    @objc func didTapChange(_ sender: UIButton) {
        delegate?.showAvailableCards(selectedCardNumber: cardNumber)
    }
}
