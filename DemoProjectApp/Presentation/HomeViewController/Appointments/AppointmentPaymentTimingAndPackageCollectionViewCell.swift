//
//  AppointmentPaymentTimingAndPackageTableViewCellTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 18/10/22.
//

import UIKit

class AppointmentPaymentTimingAndPackageCollectionViewCell: UICollectionViewCell {

    static let identifier = "AppointmentPaymentTimingAndPackageTableViewCell"
    
    lazy var topLabelLeft: ResizedLabel = {
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
    
    lazy var topLabelRight: ResizedLabel = {
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
    
    lazy var middleLabelLeft: ResizedLabel = {
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
    
    lazy var middleLabelRight: ResizedLabel = {
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
    
    lazy var bottomLabelLeft: ResizedLabel = {
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
    
    lazy var bottomLabelRight: ResizedLabel = {
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
    
    var leftTopText: String? {
        didSet{
            topLabelLeft.text = leftTopText
        }
    }
    
    var leftMiddleText: String? {
        didSet{
            middleLabelLeft.text = leftMiddleText
        }
    }
    
    var leftBottomText: String? {
        didSet{
            bottomLabelLeft.text = leftBottomText
        }
    }
    
    var rightTopText: String? {
        didSet{
            topLabelRight.text = rightTopText
        }
    }
    
    var rightMiddleText: String? {
        didSet{
            middleLabelRight.text = rightMiddleText
        }
    }
    
    var rightBottomText: String? {
        didSet{
            bottomLabelRight.text = rightBottomText
        }
    }
    
    lazy var lineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    var shouldShowLineView: Bool = false
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        if(shouldShowLineView){
            lineView.removeFromSuperview()
        }
        
        shouldShowLineView = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(topLabelLeft)
        contentView.addSubview(middleLabelLeft)
        contentView.addSubview(bottomLabelLeft)
        contentView.addSubview(topLabelRight)
        
        if(shouldShowLineView){
            contentView.addSubview(lineView)
        }
        
        contentView.addSubview(middleLabelRight)
        contentView.addSubview(bottomLabelRight)
        
        loadContents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        loadContents()
    }
    
    func loadContents() {
        loadTopLeftLabel()
        loadMiddleLeftLabel()
        loadBottomLeftLabel()
        loadTopRightLabel()
        
        if(shouldShowLineView){
            loadShowLineView()
        }
        
        loadMiddleRightLabel()
        loadBottomRightLabel()
    }

    func loadTopLeftLabel() {
        topLabelLeft.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            topLabelLeft.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            topLabelLeft.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMiddleLeftLabel() {
        middleLabelLeft.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            middleLabelLeft.topAnchor.constraint(equalTo: topLabelLeft.bottomAnchor, constant: 5),
            middleLabelLeft.leadingAnchor.constraint(equalTo: topLabelLeft.leadingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadBottomLeftLabel() {
        bottomLabelLeft.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            bottomLabelLeft.leadingAnchor.constraint(equalTo: middleLabelLeft.leadingAnchor),
            bottomLabelLeft.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        if(shouldShowLineView){
            let constraint = bottomLabelLeft.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 5)
            
            previousConstraintsToDeActivate.append(constraint)
            
            constraint.isActive = true
        }
        else{
            let constraint = bottomLabelLeft.topAnchor.constraint(equalTo: middleLabelLeft.bottomAnchor, constant: 5)
            
            previousConstraintsToDeActivate.append(constraint)
            
            constraint.isActive = true
        }
    }
    
    func loadShowLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = .systemGray4
        
        let constraints = [
            lineView.topAnchor.constraint(equalTo: middleLabelLeft.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: middleLabelLeft.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: middleLabelRight.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadTopRightLabel(){
        topLabelRight.translatesAutoresizingMaskIntoConstraints = false
        
        topLabelRight.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let constraints = [
            topLabelRight.topAnchor.constraint(equalTo: topLabelLeft.topAnchor),
            topLabelRight.leadingAnchor.constraint(equalTo: topLabelLeft.trailingAnchor),
            topLabelRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMiddleRightLabel(){
        middleLabelRight.translatesAutoresizingMaskIntoConstraints = false
        
        middleLabelRight.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let constraints = [
            middleLabelRight.topAnchor.constraint(equalTo: middleLabelLeft.topAnchor),
            middleLabelRight.leadingAnchor.constraint(equalTo: middleLabelLeft.trailingAnchor),
            middleLabelRight.trailingAnchor.constraint(equalTo: topLabelRight.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadBottomRightLabel() {
        bottomLabelRight.translatesAutoresizingMaskIntoConstraints = false
        
        bottomLabelRight.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let constraints = [
            bottomLabelRight.topAnchor.constraint(equalTo: bottomLabelLeft.topAnchor),
            bottomLabelRight.leadingAnchor.constraint(equalTo: bottomLabelLeft.trailingAnchor),
            bottomLabelRight.trailingAnchor.constraint(equalTo: middleLabelRight.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
}
