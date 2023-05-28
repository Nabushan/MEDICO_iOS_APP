//
//  CustomisedCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 25/09/22.
//

import UIKit

class CustomisedCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CustomisedCollectionViewCell"
    
    let imageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = false
        
        return image
    }()
    
    let label: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.textColor = .label
        label.font = UIFont(name: "Helvetica", size: 15)
        label.textAlignment = .center
        label.contentMode = .center
        
        return label
    }()
    
    var medicalSolutionContainer: MedicalSolution! {
        didSet{
            imageView.image = medicalSolutionContainer.image
            label.text = medicalSolutionContainer.description
        }
    }
    
    var specialistsContainer: Specialities! {
        didSet{
            imageView.image = specialistsContainer.image
            label.text = specialistsContainer.description
        }
    }
    
    var previousConstraints: [NSLayoutConstraint] = []
    
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
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 10
        
        loadImageView()
        loadLabel()
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = 0.4*contentView.frame.width
        let height = 0.4*contentView.frame.height
        
        let size = (width < height) ? width : height
        
        NSLayoutConstraint.deactivate(previousConstraints)
        
        let constraints = [
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0.5*height),
            imageView.widthAnchor.constraint(equalToConstant: size),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ]
        
        
        NSLayoutConstraint.activate(constraints)
        previousConstraints = constraints
    }
    
    func loadLabel(){
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 5),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15)
        ])
    }
    
    func isCellSelected(_ flag: Bool) {
        if(flag) {
            contentView.backgroundColor = .systemBlue
            contentView.tintColor = .white
            label.textColor = .white
        }
        else{
            contentView.backgroundColor = .secondarySystemGroupedBackground
            contentView.tintColor = .systemBlue
            label.textColor = .label
        }
    }
}
