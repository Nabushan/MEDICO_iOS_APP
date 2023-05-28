//
//  EditCartVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 23/12/22.
//

import UIKit

class EditCartVC: UIViewController, UISheetPresentationControllerDelegate {
    
    override var sheetPresentationController: UISheetPresentationController {
        (presentationController as? UISheetPresentationController)!
    }
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var leftButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = UIColor(red: 233/255, green: 240/255, blue: 255/255, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    lazy var rightButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Update", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
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
        
        label.contentMode = .left
        label.textAlignment = .left
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
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        
        stepper.stepValue = 1
        stepper.isContinuous = true
        stepper.autorepeat = false
        stepper.minimumValue = 1
        stepper.maximumValue = 50
        
        return stepper
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
    
    weak var delegate: EditCartObjectDetailProtocol?
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    let cart: Cart
    let indexPath: IndexPath
    
    init(cart: Cart, indexPath: IndexPath) {
        self.cart = cart
        self.indexPath = indexPath
        
        super.init(nibName: nil, bundle: nil)
        
        if(cart.productQuantity >= 50){
            maxLimitReachedLabel.alpha = 1
        }
        else{
            maxLimitReachedLabel.alpha = 0
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .clear
        
        view.addSubview(contentView)
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(maxLimitReachedLabel)
        contentView.addSubview(productQuantityLabel)
        contentView.addSubview(stepper)
        contentView.addSubview(starLabel)
        contentView.addSubview(productCostLabel)
        contentView.addSubview(leftButton)
        contentView.addSubview(rightButton)
        
        configureSheetPresentationController()
        loadContents()
    }
    
    func loadContents() {
        loadContentView()
        loadProductImageView()
        loadProductNameLabel()
        loadMaxLimitReachedLabel()
        loadProductQuantityLabel()
        loadStepper()
        loadStarLabel()
        loadProductCostLabel()
        loadLeftButton()
        loadRightButton()
        
        loadComponentContents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        loadContents()
    }
    
    func configureSheetPresentationController() {
        var height = CGFloat(170)
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            height = 0.2*view.frame.height
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                height = 0.25*view.frame.height
            }
        }
        
        let smallId = UISheetPresentationController.Detent.Identifier("small")
        if #available(iOS 16.0, *) {
            let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                return height
            }
            sheetPresentationController.delegate = self
            sheetPresentationController.detents = [smallDetent]
            sheetPresentationController.preferredCornerRadius = 10
            sheetPresentationController.prefersGrabberVisible = false
        } else {
            sheetPresentationController.delegate = self
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.preferredCornerRadius = 10
            sheetPresentationController.prefersGrabberVisible = false
        }
    }
    
    func loadContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func loadProductImageView() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            productImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            productImageView.heightAnchor.constraint(equalTo: productImageView.widthAnchor),
            productImageView.bottomAnchor.constraint(equalTo: leftButton.topAnchor, constant: -10)
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
    
    func loadMaxLimitReachedLabel() {
        maxLimitReachedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            maxLimitReachedLabel.trailingAnchor.constraint(equalTo: stepper.trailingAnchor),
            maxLimitReachedLabel.topAnchor.constraint(equalTo: productNameLabel.topAnchor)
        ])
    }
    
    func loadProductQuantityLabel() {
        productQuantityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productQuantityLabel.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            productQuantityLabel.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor),
        ])
    }
    
    func loadStepper() {
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        stepper.addTarget(self, action: #selector(didTapStepper), for: .touchUpInside)
        
        stepper.value = Double(cart.productQuantity)
        
        NSLayoutConstraint.activate([
            stepper.centerYAnchor.constraint(equalTo: productQuantityLabel.centerYAnchor),
            stepper.leadingAnchor.constraint(equalTo: productQuantityLabel.trailingAnchor),
            stepper.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor)
        ])
    }
    
    func loadProductCostLabel() {
        productCostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productCostLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productCostLabel.topAnchor.constraint(equalTo: starLabel.topAnchor)
        ])
    }
    
    func loadStarLabel() {
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        
        starLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            starLabel.topAnchor.constraint(equalTo: productQuantityLabel.bottomAnchor, constant: -3),
            starLabel.leadingAnchor.constraint(equalTo: productQuantityLabel.leadingAnchor),
            starLabel.bottomAnchor.constraint(equalTo: leftButton.topAnchor, constant: -10)
        ])
    }
    
    func loadLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            leftButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            leftButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            leftButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.46)
        ])
        
        leftButton.layer.cornerRadius = leftButton.intrinsicContentSize.height/2
    }
    
    func loadRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        rightButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rightButton.bottomAnchor.constraint(equalTo: leftButton.bottomAnchor),
            rightButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rightButton.widthAnchor.constraint(equalTo: leftButton.widthAnchor)
        ])
        
        rightButton.layer.cornerRadius = leftButton.layer.cornerRadius
    }
    
    func loadComponentContents() {
        productImageView.downloaded(from: cart.productImage)
        productNameLabel.text = cart.productName
        productCostLabel.text = "₹ \(cart.productCost)"
        productQuantityLabel.text = "Quantity: \(cart.productQuantity) items"
        
        starLabel.attributedText = getRatedAttributedString(forRating: cart.productRating)
    }
 
    
    @objc func didTapToCloseTheEditView(_ sender: UITapGestureRecognizer) {
        dismissSelf()
    }
    
    @objc func didTapStepper(_ sender: UIStepper){
        productQuantityLabel.text = "Quantity: \(Int(sender.value)) items"
        
        if(sender.value >= 50) {
            maxLimitReachedLabel.alpha = 1
        }
        else{
            maxLimitReachedLabel.alpha = 0
        }
    }
    
    @objc func didTapSubmitButton(_ sender: UIButton) {
        print("Update Button of editCartVC Tapped.")
        if let _ = delegate {
            print("Not nil")
        }
        delegate?.updateTheMedCountAndChangeQuantityInDb(forIndexPath: indexPath, toValue: Int(stepper.value))
        dismissSelf()
    }
    
    @objc func didTapCancelButton(_ sender: UIButton) {
        dismissSelf()
    }
    
    func dismissSelf() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            self.delegate?.showTabBar()
        }
        
        self.dismiss(animated: true)
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
}
