//
//  EmergencyCollectionViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 03/10/22.
//

import UIKit

class EmergencyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "EmergencyCollectionViewCell"
    
    lazy var bellImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var contentImageView: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var contentLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    var imageLink: String? {
        didSet{
            contentImageView.downloaded(from: imageLink ?? "", shouldRender: true, withColor: .label)
        }
    }
    
    var contentText: String? {
        didSet{
            contentLabel.text = contentText
        }
    }
    
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
        
        contentView.addSubview(bellImageView)
        contentView.addSubview(contentImageView)
        contentView.addSubview(contentLabel)
        
        loadBellImageView()
        loadContentImageView()
        loadContentLabel()
    }
    
    func loadBellImageView() {
        bellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "bell.and.waveform")?.withRenderingMode(.alwaysOriginal)
        
        bellImageView.image = image?.withTintColor(.systemBlue)
        
        NSLayoutConstraint.activate([
            bellImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            bellImageView.heightAnchor.constraint(equalTo: bellImageView.widthAnchor),
            bellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            bellImageView.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor)
        ])
    }
    
    func loadContentImageView() {
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentImageView.image?.withTintColor(.label)
        
        NSLayoutConstraint.activate([
            contentImageView.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor),
            contentImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            contentImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            contentImageView.heightAnchor.constraint(equalTo: contentImageView.widthAnchor)
        ])
    }
    
    func loadContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
        ])
    }
}
