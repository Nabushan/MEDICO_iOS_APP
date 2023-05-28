//
//  MedicalNewsVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 26/09/22.
//

import UIKit

class MedicalNewsVC: UIViewController {

    var article: Article! {
        didSet{
            headingLabel.text = article.title
            contentLabel.text = article.content
            authorNameLabel.text = article.author ?? "Unknown"
            
            if(imageView.image != nil){
                activityIndicator.stopAnimating()
            }
            
            if(contentLabel.text == nil){
                contentLabel.text = "Oops something went wrong"
                contentLabel.textAlignment = .center
            }
            
            guard let url = URL(string: article.urlToImage ?? "") else {
                return
            }
            
            imageView.loadImageWithUrl(url)
            
            activityIndicator.stopAnimating()
        }
    }
    
    lazy var headingLabel: ResizedLabel = {
        let headingLabel = ResizedLabel()
        
        headingLabel.numberOfLines = 0
        headingLabel.adjustsFontSizeToFitWidth = true
        headingLabel.clipsToBounds = true
        headingLabel.textAlignment = .left
        headingLabel.contentMode = .left
        headingLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        headingLabel.textColor = .label
        
        return headingLabel
    }()
    
    lazy var infoView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var authorNameLabel: ResizedLabel = {
        let authorNameLabel = ResizedLabel()
        
        authorNameLabel.numberOfLines = 1
        authorNameLabel.adjustsFontSizeToFitWidth = true
        authorNameLabel.clipsToBounds = true
        authorNameLabel.textAlignment = .left
        authorNameLabel.contentMode = .left
        authorNameLabel.font = UIFont(name: "Helvetica", size: 15)
        authorNameLabel.textColor = .label
        
        return authorNameLabel
    }()
    
    lazy var readTimeLabel: ResizedLabel = {
        let readTimeLabel = ResizedLabel()
        
        readTimeLabel.numberOfLines = 1
        readTimeLabel.adjustsFontSizeToFitWidth = true
        readTimeLabel.clipsToBounds = true
        readTimeLabel.textAlignment = .left
        readTimeLabel.contentMode = .left
        readTimeLabel.font = UIFont(name: "Helvetica", size: 15)
        readTimeLabel.textColor = .label
        
        return readTimeLabel
    }()
    
    lazy var dotView: UIView = {
        let dotView = UIView()
        
        dotView.backgroundColor = .systemGray
        
        return dotView
    }()
    
    lazy var viewForImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var imageView: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    lazy var thumbNailImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    lazy var contentLabel: ResizedLabel = {
        let contentLabel = ResizedLabel()
        
        contentLabel.numberOfLines = 4
        contentLabel.lineBreakMode = .byTruncatingTail
        contentLabel.clipsToBounds = true
        contentLabel.textAlignment = .left
        contentLabel.contentMode = .left
        contentLabel.font = UIFont(name: "Helvetica", size: 15)
        contentLabel.textColor = .label
        
        return contentLabel
    }()
    
    lazy var readMoreButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Read More On WebSite", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        view.addSubview(headingLabel)
        
        view.addSubview(infoView)
        infoView.addSubview(authorNameLabel)
        infoView.addSubview(dotView)
        infoView.addSubview(readTimeLabel)
        
        view.addSubview(viewForImage)
        viewForImage.addSubview(thumbNailImageView)
        viewForImage.addSubview(activityIndicator)
        viewForImage.addSubview(imageView)
        
        view.addSubview(contentLabel)
        view.addSubview(readMoreButton)
        
        loadTextLabel()
        
        loadInfoView()
        loadAuthorNameLabel()
        loadDotView()
        loadReadTimeLabel()
        
        loadViewForImage()
        loadThumbNailImage()
        loadActivityIndicator()
        loadImageView()
        
        loadContentLabel()
        loadReadMoreButton()
    }
    
    func loadTextLabel() {
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            NSLayoutConstraint.activate([
                headingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
                headingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 0.1*view.frame.width),
                headingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -0.1*view.frame.width),
                headingLabel.heightAnchor.constraint(equalToConstant: 0.1*view.frame.height)
            ])
        }
        else{
            NSLayoutConstraint.activate([
                headingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
                headingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
                headingLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
                headingLabel.heightAnchor.constraint(equalToConstant: 0.25*view.frame.height)
            ])
        }
    }
    
    func loadInfoView() {
        infoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor,constant: 10),
            infoView.leadingAnchor.constraint(equalTo: headingLabel.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: headingLabel.trailingAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 0.04*view.frame.height)
        ])
    }
    
    func loadAuthorNameLabel(){
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorNameLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor,constant: 0)
        ])
    }
    
    func loadDotView() {
        dotView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dotView.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            dotView.leadingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor,constant: 0),
            dotView.heightAnchor.constraint(equalToConstant: 0.01*view.frame.height),
            dotView.widthAnchor.constraint(equalToConstant: 0.01*view.frame.height)
        ])
        
        dotView.layer.cornerRadius = (0.01*view.frame.height)/2
    }
    
    func loadReadTimeLabel() {
        readTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        readTimeLabel.text = "10 minute read"
        
        NSLayoutConstraint.activate([
            readTimeLabel.leadingAnchor.constraint(equalTo: dotView.trailingAnchor,constant: 5),
            readTimeLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor)
        ])
    }
    
    func loadViewForImage() {
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForImage.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            viewForImage.topAnchor.constraint(equalTo: infoView.bottomAnchor,constant: 10),
            viewForImage.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            viewForImage.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            viewForImage.heightAnchor.constraint(equalToConstant: 0.27*view.frame.height),
        ])
    }
    
    func loadThumbNailImage() {
        thumbNailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        thumbNailImageView.layer.cornerRadius = 10
        
        thumbNailImageView.downloaded(from: "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg")
        
        NSLayoutConstraint.activate([
            thumbNailImageView.widthAnchor.constraint(equalTo: viewForImage.widthAnchor),
            thumbNailImageView.heightAnchor.constraint(equalTo: viewForImage.heightAnchor)
        ])
    }
    
    func loadActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor),
        ])
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: viewForImage.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: viewForImage.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: viewForImage.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: viewForImage.bottomAnchor),
        ])
    }
    
    func loadContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            contentLabel.heightAnchor.constraint(equalToConstant: 0.20*view.frame.height)
        ])
    }
    
    func loadReadMoreButton() {
        readMoreButton.translatesAutoresizingMaskIntoConstraints = false
        
        readMoreButton.layer.cornerRadius = 10
        readMoreButton.addTarget(self, action: #selector(didTapReadMoreButton), for: .touchUpInside)
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            NSLayoutConstraint.activate([
                readMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
                readMoreButton.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
                readMoreButton.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor),
            ])
        }
        else{
            NSLayoutConstraint.activate([
                readMoreButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor,constant: 10),
                readMoreButton.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
                readMoreButton.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor),
                readMoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            ])
        }
    }
    
    @objc func didTapReadMoreButton(_ sender: UIButton){
        guard let url = URL(string: article.url ?? "") else{
            return
        }
        
        UIApplication.shared.open(url)
    }
}
