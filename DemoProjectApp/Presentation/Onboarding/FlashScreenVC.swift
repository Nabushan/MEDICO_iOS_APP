//
//  FlashScreenVC.swift
//  Medico
//
//  Created by nabushan-pt5611 on 30/12/22.
//

import UIKit

class FlashScreenVC: UIViewController {

    lazy var appImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Transparent App Icon")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        return imageView
    }()
    
    lazy var appNameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.lineBreakMode = .byTruncatingTail
//        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.tintColor = .systemBlue
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    init() {
        let  _ = DBContents()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        view.addSubview(appImageView)
        view.addSubview(appNameLabel)
        view.addSubview(activityIndicator)
        
        loadAppImageView()
        loadAppNameLabel()
        loadActivityIndicator()
    }
    
    func loadAppImageView() {
        appImageView.translatesAutoresizingMaskIntoConstraints = false
        
        appImageView.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            appImageView.widthAnchor.constraint(equalToConstant: 50),
            appImageView.heightAnchor.constraint(equalTo: appImageView.widthAnchor),
            appImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            appImageView.trailingAnchor.constraint(equalTo: appNameLabel.leadingAnchor, constant: -10)
        ])
        
        appImageView.layer.cornerRadius = 25
    }
    
    func loadAppNameLabel() {
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        appNameLabel.text = "Medico"
        
        NSLayoutConstraint.activate([
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            appNameLabel.centerYAnchor.constraint(equalTo: appImageView.centerYAnchor)
        ])
    }
    
    func loadActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.color = .systemBlue
        activityIndicator.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        
        NSLayoutConstraint.activate([
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
