//
//  HelpCenterFAQCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 13/12/22.
//

import UIKit

class HelpCenterFAQCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "HelpCenterFAQCollectionViewCell"
    
    lazy var questionLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 2
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .left
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var answerLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        questionLabel.text = nil
        answerLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(questionLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(answerLabel)
        
        contentView.backgroundColor = Theme.lightMode.subViewBackGroundColor
        contentView.layer.cornerRadius = 10
        
        loadQuestionLabel()
        loadLineView()
        loadAnswerLabel()
    }
    
    func loadQuestionLabel() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func loadLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = .systemGray3
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 2),
            lineView.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: questionLabel.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func loadAnswerLabel() {
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 5),
            answerLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
