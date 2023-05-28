//
//  PharmacyProductVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 12/10/22.
//

import UIKit

class PharmacyProductVC: UIViewController, UISheetPresentationControllerDelegate, AddToCartProtocol {
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var closeImageView: UIImageView = {
        let view = UIImageView()
        
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var medicineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var medicineImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var medicineName: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 23, weight: .regular)
        
        return label
    }()
    
    lazy var medicineLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var dosageLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
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
    
    lazy var expiryDateLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
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
    
    lazy var quantityLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        
        stepper.stepValue = 1
        stepper.isContinuous = true
        stepper.autorepeat = false
        stepper.minimumValue = 0
        stepper.maximumValue = 50
        
        
        return stepper
    }()
    
    lazy var priceLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var addToCartImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    lazy var quantityCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(PharmacyProductQuantityCollectionViewCell.self, forCellWithReuseIdentifier: PharmacyProductQuantityCollectionViewCell.identifier)
        
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    lazy var medicineDescription: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 0
        label.textColor = .label
        label.contentMode = .topLeft
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    lazy var medicineDescriptionLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    lazy var discountsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayoutProvider().getPharmacyProductInfoLayout())
        
        collectionView.register(PharmacyProductInfoCollectionViewCell.self, forCellWithReuseIdentifier: PharmacyProductInfoCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    override var sheetPresentationController: UISheetPresentationController {
        (presentationController as? UISheetPresentationController)!
    }
    
    var previouslySelectedCell: PharmacyProductQuantityCollectionViewCell? = nil
    let medCounts = [0,5,10,15,20]
    
    let infoImages = [
        "https://static.thenounproject.com/png/4172945-200.png",
        "https://cdn-icons-png.flaticon.com/512/93/93375.png",
        "https://cdn-icons-png.flaticon.com/512/2947/2947554.png"
    ]
    
    let infoMessages = ["Safe No-Contact Delivery","Free Delivery To Home","Cash Back upto 100%"]
    let product: PharmacyProduct
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    let pharmacyProductHelper: PharmacyProductHelper
    
    var initialOrigin: CGPoint?
    let pharmacyId: Int
    
    lazy var visualEffects: UIVisualEffectView = {
        let visualEffects = UIVisualEffectView()
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        visualEffects.effect = blurEffect
        
        return visualEffects
    }()
    
    var quantityCollectionViewCells: [PharmacyProductQuantityCollectionViewCell] = []
    var delegate: ViewInCartProtocol?
    var isFromReOrdering: Bool = false
    
    init(product: PharmacyProduct, pharmacyId: Int) {
        self.product = product
        self.pharmacyId = pharmacyId
        self.pharmacyProductHelper = PharmacyProductHelper()
        
        super.init(nibName: nil, bundle: nil)
        
        pharmacyProductHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.backgroundColor = .clear
        
        view.addSubview(contentView)
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(medicineView)
        medicineView.addSubview(medicineImageView)
        medicineView.addSubview(medicineName)
        medicineView.addSubview(medicineLineView)
        medicineView.addSubview(dosageLabel)
        medicineView.addSubview(expiryDateLabel)
        scrollView.addSubview(quantityLabel)
        scrollView.addSubview(stepper)
        
        scrollView.addSubview(priceLabel)
//        scrollView.addSubview(addToCart)
        scrollView.addSubview(addToCartImageView)
        
        scrollView.addSubview(quantityCollectionView)
        scrollView.addSubview(medicineDescriptionLabel)
        scrollView.addSubview(medicineDescription)
        scrollView.addSubview(discountsCollectionView)
        
        configureDelegates()
        configureSheetPresentationController()
        
        loadContents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        loadContents()
        
        quantityCollectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        loadContents()
        
        quantityCollectionView.reloadData()
    }
    
    func loadContents() {
        loadContentView()
        loadScrollView()
        loadMedicineView()
        loadMedicineImageView()
        loadMedicineNameLabel()
        loadMedicineNameLabel()
        loadMedicineLineView()
        loadDosageLabel()
        loadExpiryDateLabel()
        loadQuantityLabel()
        loadStepper()
        loadPriceLabel()
        loadAddToCartImageView()
        loadQuantityCollectionView()
        loadMedicineDescriptionLabel()
        loadMedicineDescription()
        loadDiscountsCollectionView()
    }
    
    func configureSheetPresentationController() {
        sheetPresentationController.delegate = self
        sheetPresentationController.detents = [.medium(), .large()]
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.preferredCornerRadius = 10
    }
    
    func configureDelegates() {
        quantityCollectionView.delegate = self
        quantityCollectionView.dataSource = self
        
        discountsCollectionView.delegate = self
        discountsCollectionView.dataSource = self
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
    
    func loadScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func loadMedicineView() {
        medicineView.translatesAutoresizingMaskIntoConstraints = false
        
        medicineView.backgroundColor = .systemGroupedBackground
        
        var heightAnchor: NSLayoutConstraint?
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            heightAnchor = medicineView.heightAnchor.constraint(equalToConstant: 0.25*view.frame.height)
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                heightAnchor = medicineView.heightAnchor.constraint(equalToConstant: 0.25*view.frame.width)
            }
        }
        else{
            if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                heightAnchor = medicineView.heightAnchor.constraint(equalToConstant: 0.25*view.frame.height)
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    heightAnchor = medicineView.heightAnchor.constraint(equalToConstant: 0.25*view.frame.width)
                }
            }
            else{
                heightAnchor = medicineView.heightAnchor.constraint(equalToConstant: 0.35*view.frame.height)
            }
        }
        
        guard let heightAnchor = heightAnchor else {
            return
        }
        
        let constraints = [
            medicineView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            medicineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            medicineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            heightAnchor
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        medicineView.layer.cornerRadius = 10
    }
    
    func loadMedicineImageView() {
        medicineImageView.translatesAutoresizingMaskIntoConstraints = false
        
        medicineImageView.downloaded(from: product.imageLink)
        
        let constraints = [
            medicineImageView.heightAnchor.constraint(equalTo: medicineView.heightAnchor, multiplier: 0.8),
            medicineImageView.widthAnchor.constraint(equalTo: medicineImageView.heightAnchor),
            medicineImageView.centerYAnchor.constraint(equalTo: medicineView.centerYAnchor),
            medicineImageView.leadingAnchor.constraint(equalTo: medicineView.leadingAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        medicineImageView.layer.cornerRadius = 10
    }
    
    func loadMedicineNameLabel() {
        medicineName.translatesAutoresizingMaskIntoConstraints = false
        
        medicineName.text = product.name
        
        let constraints = [
            medicineName.topAnchor.constraint(equalTo: medicineImageView.topAnchor),
            medicineName.leadingAnchor.constraint(equalTo: medicineImageView.trailingAnchor, constant: 10),
            medicineName.trailingAnchor.constraint(equalTo: medicineView.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMedicineLineView() {
        medicineLineView.translatesAutoresizingMaskIntoConstraints = false
        
        medicineLineView.backgroundColor = .tertiaryLabel
        
        let constraints = [
            medicineLineView.topAnchor.constraint(equalTo: medicineName.bottomAnchor),
            medicineLineView.leadingAnchor.constraint(equalTo: medicineName.leadingAnchor),
            medicineLineView.trailingAnchor.constraint(equalTo: medicineName.trailingAnchor),
            medicineLineView.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadDosageLabel() {
        dosageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dosageLabel.text = "Dosage: \(product.dosage)"
        
        let constraints = [
            dosageLabel.topAnchor.constraint(equalTo: medicineLineView.bottomAnchor),
            dosageLabel.leadingAnchor.constraint(equalTo: medicineLineView.leadingAnchor),
            dosageLabel.trailingAnchor.constraint(equalTo: medicineLineView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadExpiryDateLabel() {
        expiryDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        expiryDateLabel.text = "Exp Date: \(product.expiryDate)"
        
        let constraints = [
            expiryDateLabel.topAnchor.constraint(equalTo: dosageLabel.bottomAnchor),
            expiryDateLabel.leadingAnchor.constraint(equalTo: dosageLabel.leadingAnchor),
            expiryDateLabel.trailingAnchor.constraint(equalTo: dosageLabel.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadQuantityLabel() {
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        quantityLabel.text = "Quantity: \(Int(stepper.value))"
        
        let constraints = [
            quantityLabel.topAnchor.constraint(equalTo: medicineView.bottomAnchor, constant: 15),
            quantityLabel.leadingAnchor.constraint(equalTo: medicineView.leadingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadStepper() {
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            stepper.topAnchor.constraint(equalTo: quantityLabel.topAnchor),
            stepper.bottomAnchor.constraint(equalTo: quantityLabel.bottomAnchor),
            stepper.trailingAnchor.constraint(equalTo: medicineView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        stepper.addTarget(self, action: #selector(didTapStepper), for: .touchUpInside)
    }
    
    func loadPriceLabel() {
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        priceLabel.text = "Price Per Medicine: ₹ \(product.cost)"
        
        let constraints: [NSLayoutConstraint] = [
            priceLabel.topAnchor.constraint(equalTo: quantityCollectionView.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: quantityLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: stepper.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadAddToCartImageView() {
        addToCartImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(systemName: "cart.badge.plus")
        addToCartImageView.image = image
        
        addToCartImageView.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        
        if(stepper.value != 0) {
            addTapGesture(toView: addToCartImageView)
            addToCartImageView.tintColor = .systemBlue
        }
        else{
            addToCartImageView.tintColor = .secondaryLabel
        }
        
        let constraints = [
            addToCartImageView.centerYAnchor.constraint(equalTo: quantityCollectionView.centerYAnchor),
            addToCartImageView.centerXAnchor.constraint(equalTo: stepper.centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadQuantityCollectionView() {
        quantityCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        var heightAnchor: NSLayoutConstraint?
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            heightAnchor = quantityCollectionView.heightAnchor.constraint(equalToConstant: 0.15*view.frame.width)
        }
        else{
            heightAnchor = quantityCollectionView.heightAnchor.constraint(equalToConstant: 0.15*view.frame.height)
        }
        
        guard let heightAnchor = heightAnchor else {
            return
        }
        
        let constraints = [
            quantityCollectionView.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor,constant: 10),
            quantityCollectionView.leadingAnchor.constraint(equalTo: quantityLabel.leadingAnchor),
            quantityCollectionView.trailingAnchor.constraint(equalTo: stepper.leadingAnchor),
            heightAnchor
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMedicineDescriptionLabel() {
        medicineDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        medicineDescriptionLabel.text = "Medicine Description:"
        
        let constraints = [
            medicineDescriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            medicineDescriptionLabel.leadingAnchor.constraint(equalTo: quantityCollectionView.leadingAnchor),
            medicineDescriptionLabel.trailingAnchor.constraint(equalTo: stepper.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMedicineDescription() {
        medicineDescription.translatesAutoresizingMaskIntoConstraints = false
        
        medicineDescription.backgroundColor = contentView.backgroundColor
        medicineDescription.text = product.medDescription
        
        let constraints = [
            medicineDescription.topAnchor.constraint(equalTo: medicineDescriptionLabel.bottomAnchor),
            medicineDescription.leadingAnchor.constraint(equalTo: medicineDescriptionLabel.leadingAnchor),
            medicineDescription.trailingAnchor.constraint(equalTo: medicineDescriptionLabel.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadDiscountsCollectionView() {
        discountsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        discountsCollectionView.backgroundColor = contentView.backgroundColor
        
        var heightAnchor: NSLayoutConstraint?
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            if(view.frame.width > 800){
                heightAnchor = discountsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width*0.07)
            }
            else{
                heightAnchor = discountsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.width*0.15)
            }
        }
        else{
            if(view.frame.height > 800){
                heightAnchor = discountsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height*0.07)
            }
            else{
                heightAnchor = discountsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height*0.15)
            }
        }
        
        guard let heightAnchor = heightAnchor else {
            return
        }
        
        NSLayoutConstraint.activate([
            discountsCollectionView.topAnchor.constraint(equalTo: medicineDescription.bottomAnchor, constant: 5),
            discountsCollectionView.leadingAnchor.constraint(equalTo: medicineDescription.leadingAnchor),
            discountsCollectionView.trailingAnchor.constraint(equalTo: medicineDescription.trailingAnchor),
            discountsCollectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            heightAnchor
        ])
    }
    
    func disableCartButton() {
        addToCartImageView.gestureRecognizers?.forEach(addToCartImageView.removeGestureRecognizer)
        addToCartImageView.tintColor = .secondaryLabel
    }
    
    func enableCartButton() {
        addTapGesture(toView: addToCartImageView)
        addToCartImageView.tintColor = .systemBlue
    }
    
    @objc func didTapStepper(_ sender: UIStepper){
        let value = Int(sender.value)
        quantityLabel.text = "Quantity: \(value)"
        
        previouslySelectedCell?.isSelected(false)
        if(value >= 0 && value < 5) {
            if(value == 0) {
                disableCartButton()
            }
            else{
                enableCartButton()
            }
            previouslySelectedCell = quantityCollectionViewCells[0]
        }
        else if(value >= 5 && value < 10) {
            previouslySelectedCell = quantityCollectionViewCells[1]
        }
        else if(value >= 10 && value < 15) {
            previouslySelectedCell = quantityCollectionViewCells[2]
        }
        else if(value >= 15 && value < 20) {
            previouslySelectedCell = quantityCollectionViewCells[3]
        }
        else {
            previouslySelectedCell = quantityCollectionViewCells[4]
        }
        previouslySelectedCell?.isSelected(true)
    }
    
    @objc func didTapAddToCart(_ sender: UITapGestureRecognizer) {
        print("Tapped Add to Cart")
        
        print("Quantity Label text : \(quantityLabel.text ?? "no text")")
        
        let quantity = Int(stepper.value)
        
        var title = "Added To Cart"
        var message = "Your medicine has been added to cart successfully"
        var isSuccess = true
        
        if(!pharmacyProductHelper.addProductToCart(product, quantity: quantity, pharmacyId: pharmacyId)) {
            title = "Zero Quantity Chosen"
            message = "Please make sure that you've selected a proper quantity"
            isSuccess = false
        }
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "Okay", style: .default){_ in
            if(isSuccess){
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    if(self.isFromReOrdering) {
                        self.delegate?.showCartVC()
                    }
                    self.dismiss(animated: true)
                }
            }
        })
        
        if(isSuccess && !isFromReOrdering){
            alertViewController.addAction(UIAlertAction(title: "View item in Cart", style: .default){
                _ in
                self.dismiss(animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.delegate?.showCartVC()
                }
            })
        }
        
        self.present(alertViewController, animated: true)
    }
    
    func addTapGesture(toView: UIView){
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == closeImageView) {
            tapGesture.addTarget(self, action: #selector(didTapOnMainView))
        }
        else if(toView == addToCartImageView){
            tapGesture.addTarget(self, action: #selector(didTapAddToCart))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapOnMainView(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: true)
    }
    
}

extension PharmacyProductVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(collectionView == quantityCollectionView) {
            quantityCollectionViewCells = []
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == quantityCollectionView){
            return medCounts.count
        }
        else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print(CGSize(width: quantityCollectionView.frame.width/5.5, height: quantityCollectionView.frame.height))
        return CGSize(width: quantityCollectionView.frame.width/5.5, height: quantityCollectionView.frame.height*0.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == quantityCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyProductQuantityCollectionViewCell.identifier, for: indexPath) as? PharmacyProductQuantityCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.count = medCounts[indexPath.row]
            cell.backgroundColor = .tertiarySystemGroupedBackground
            
            if(previouslySelectedCell == nil){
                cell.isSelected(true)
                previouslySelectedCell = cell
            }
            
            cell.layer.cornerRadius = 10
            quantityCollectionViewCells.append(cell)
            
            return cell
        }
        else if(collectionView == discountsCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyProductInfoCollectionViewCell.identifier, for: indexPath) as? PharmacyProductInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.contentView.layer.cornerRadius = cell.contentView.frame.height / 2
            
            cell.backgroundColor = .systemGray3
            cell.layer.cornerRadius = cell.frame.height/2
            
            cell.text = infoMessages[indexPath.row]
            cell.imageLink = infoImages[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if(collectionView == quantityCollectionView){
            guard let cell = collectionView.cellForItem(at: indexPath) as? PharmacyProductQuantityCollectionViewCell else{
                return
            }
            
            previouslySelectedCell?.isSelected(false)
            
            cell.isSelected(true)
            previouslySelectedCell = cell
            
            if(indexPath.row == 0) {
                disableCartButton()
            }
            else{
                enableCartButton()
            }
            
            quantityLabel.text = "Quantity: \(cell.countLabel.text ?? "0")"
            stepper.value = Double(cell.countLabel.text ?? "0") ?? 0.0
        }
        else if(collectionView == discountsCollectionView){
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: 5,
            left: 5,
            bottom: 5,
            right: 5)
    }
}
