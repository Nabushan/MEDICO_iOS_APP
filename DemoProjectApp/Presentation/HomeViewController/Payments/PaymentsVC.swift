//
//  BookAppointmentPaymentsVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 17/10/22.
//

import UIKit

class PaymentsVC: UIViewController, PaymentProtocol, AddedCardDetailUpdationProtocol, PaymentsAddNewCardProtocol {
   
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(PaymentsCollectionViewCell.self, forCellWithReuseIdentifier: PaymentsCollectionViewCell.identifier)
        
        collectionView.register(PaymentsCVCollectionReusableFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PaymentsCVCollectionReusableFooterView.identifier)
        
        collectionView.register(PaymentsCVCollectionReusableHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PaymentsCVCollectionReusableHeaderView.identifier)
        
        collectionView.contentMode = .center
        
        return collectionView
    }()
    
    lazy var nextButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    var previouslySelectedRow: PaymentsCollectionViewCell? = nil
    var previouslySelectedRowText: String = ""
    var selectedCardFromReviewSummary: String = ""
    
    let paymentsHelperVC: PaymentsHelperVC?
    
    var reviewSummary: ReviewSummary?
    var consultation: ConsultationGetter?
    var isNextButtonHidden: Bool = false
    var isAddnewCardButtonHidden: Bool = false
    
    var cardImages: [UIImage]?
    var cardDetails: [CardDetails]?
    var isPresented = false
    
    weak var delegateForAvailableCardDisplay: ChangeCardForPaymentProtocol?
    var previouslySelectedConstraints: [NSLayoutConstraint] = []
    
    init(reviewSummary: ReviewSummary, consultation: ConsultationGetter) {
        
        paymentsHelperVC = PaymentsHelperVC()
        self.reviewSummary = reviewSummary
        self.consultation = consultation
        
        super.init(nibName: nil, bundle: nil)
        self.title = "Payments"
        
        paymentsHelperVC?.delegate = self
    }
    
    init(cardImages: [UIImage], cardDetails: [CardDetails], selectedCardNumber: String){
        isNextButtonHidden = true
        isAddnewCardButtonHidden = true
        self.paymentsHelperVC = nil
        self.reviewSummary = nil
        self.selectedCardFromReviewSummary = selectedCardNumber
        
        self.cardDetails = cardDetails
        self.cardImages = cardImages
        isPresented = true
        
        super.init(nibName: nil, bundle: nil)
        self.title = "Available Cards"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        view.addSubview(collectionView)
        if(isNextButtonHidden == false){
            view.addSubview(nextButton)
        }
        
        loadNavButtons()
        configureDelegates()
        loadContents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previouslySelectedConstraints)
        previouslySelectedConstraints = []
        loadContents()
        
        collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.reloadData()
    }
    
    func loadContents() {
        loadCollectionView()
        if(isNextButtonHidden == false){
            loadNextButton()
        }
    }
    
    func configureDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func loadNavButtons() {
        if(isNextButtonHidden && isAddnewCardButtonHidden){
            let rightButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapNavBarDoneButton))
            let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapNavBarCancelButton))
            
            navigationItem.rightBarButtonItem = rightButton
            navigationItem.leftBarButtonItem = leftButton
        }
    }
    
    @objc func didTapNavBarDoneButton(_ sender: UIBarButtonItem){
        
        guard let previouslySelectedRow = previouslySelectedRow,
              let number = previouslySelectedRow.paymentLabel.attributedText,
              let image = previouslySelectedRow.paymentImageView.image else {
            
            let alertViewController = UIAlertController(title: "Empty Choice", message: "Please make sure that you've selected a Choice", preferredStyle: .alert)
            
            alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
            
            present(alertViewController, animated: true)
            
            return
        }
    
        let selectedCard = SelectedCard(
            cardImage: image,
            cardDetail: previouslySelectedRow.cardRawValue,
            arrtibutedCardNumber: number,
            cardNumber: previouslySelectedRow.cardNumber)
        
        delegateForAvailableCardDisplay?.changeSelectedCardOfReviewSummary(to: selectedCard)
        delegateForAvailableCardDisplay?.reloadPaymentCardRow()
        
        self.dismiss(animated: true)
    }
    
    @objc func didTapNavBarCancelButton(_ sender: UIBarButtonItem){
        self.dismiss(animated: true)
    }
    
    func loadCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = view.backgroundColor
        print("Loading CollectionView")
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            var padding = 0.1*view.frame.width
            if(isPresented){
                padding = 20
            }
            let constraints = [
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraints.append(constraint)
            }
        }
        else{
            let constraints = [
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previouslySelectedConstraints.append(constraint)
            }
        }
        
        if(isNextButtonHidden == false){
            collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10).isActive = true
            previouslySelectedConstraints.append(collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10))
        }
        else{
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            
            previouslySelectedConstraints.append(collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10))
        }
    }
    
    func loadNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        let window = UIApplication.shared.keyWindow
        
        var bottomPadding = CGFloat.zero
        
        if let value = window?.safeAreaInsets.bottom, value != .zero {
            bottomPadding = value
        }
        else{
            bottomPadding = 10
        }
        
        let constraints = [
                nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomPadding)),
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
                nextButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previouslySelectedConstraints.append(constraint)
        }
        
        if(view.frame.height > 800){
            nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065).isActive = true
            previouslySelectedConstraints.append(nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065))
            nextButton.layer.cornerRadius = 10
        }
    }
    
    @objc func didTapNextButton(_ sender: UIButton) {
        print("Payment details next button tapped.")
     
        guard let cell = previouslySelectedRow,
              let attributedCardNumber = cell.paymentLabel.attributedText,
              let cardImages = paymentsHelperVC?.cardImages,
              let cardDetails = paymentsHelperVC?.cardDetails,
              let image = previouslySelectedRow?.paymentImageView.image,
              let cardNumber = previouslySelectedRow?.cardNumber  else {
            
            let alertViewController = UIAlertController(title: "Insufficient Detials", message: "Please ensure that the required fields are marked.", preferredStyle: .alert)
            
            alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
            
            present(alertViewController, animated: true)
            
            return
        }
        
        reviewSummary?.selectedCardType = SelectedCard(
            cardImage: image,
            cardDetail: cell.cardRawValue,
            arrtibutedCardNumber: attributedCardNumber,
            cardNumber: cardNumber)
        
        guard let reviewSummary = reviewSummary,
              let consultation = consultation else {
            return
        }
        
        let reviewSummaryVC = PaymentReviewSummaryVC(reviewSummary: reviewSummary,
                                                     consultation: consultation,
                                                     cardImages: cardImages,
                                                     cardDetails: cardDetails)
        
        navigationController?.pushViewController(reviewSummaryVC, animated: true)
    }
    
    func addNewCard() {
        print("Add New Card Button Tapped.")
        
        let addNewCardVC = PaymentsAddNewCardVC()
        
        addNewCardVC.cardsListVCDelegate = self
        
        navigationController?.pushViewController(addNewCardVC, animated: true)
    }
    
    func updateTableView() {
        paymentsHelperVC?.fetchCardDetails()
        
        previouslySelectedRow = nil
        
        collectionView.reloadData()
    }
}

extension PaymentsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isNextButtonHidden && isAddnewCardButtonHidden){
            return cardDetails?.count ?? 0
        }
        else{
            return paymentsHelperVC?.cardDetails.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentsCollectionViewCell.identifier, for: indexPath) as? PaymentsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.showRadioButton = true
        
        var cardDetail: CardDetails?
        var image: UIImage?
        
        if(isNextButtonHidden && isAddnewCardButtonHidden){
            cardDetail = self.cardDetails?[indexPath.row]
            image = self.cardImages?[cardDetail?.cardType.rawValue ?? 0]
        }
        else{
            cardDetail = paymentsHelperVC?.cardDetails[indexPath.row]
            image = paymentsHelperVC?.cardImages[cardDetail?.cardType.rawValue ?? 0]
        }
        
        guard let cardDetail = cardDetail,
              let image = image else {
            return UICollectionViewCell()
        }
        
        cell.cardRawValue = cardDetail.cardType
        
        if(indexPath.row == 0){
            cell.paymentImageView.image = image
        }
        else{
            cell.paymentImageView.image = image
        }
        
        if(indexPath.row <= 2){
            cell.paymentLabel.text = cardDetail.cardName
            cell.cardNumber = cardDetail.cardName
        }
        else{
            var tempText: String = ""
            cell.cardNumber = cardDetail.cardNumber
            
            if(isNextButtonHidden && isAddnewCardButtonHidden){
                guard let val = self.cardDetails?[indexPath.row].cardNumber else {
                    return UICollectionViewCell()
                }
                
                tempText = val
            }
            else{
                guard let val = paymentsHelperVC?.cardDetails[indexPath.row].cardNumber else {
                    return UICollectionViewCell()
                }
                
                tempText = val
            }
            
            let showString = NSMutableAttributedString(string: "")
            
            for index in 0..<tempText.count {
                if(index < tempText.count - 4){
                    if(tempText[tempText.index(tempText.startIndex, offsetBy: index)] != " "){
                        guard let image = UIImage(systemName: "staroflife.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.label) else{
                            return UICollectionViewCell()
                        }
                        
                        let imageToAppend = NSTextAttachment(image: image.withTintColor(UIColor.label))
                        imageToAppend.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
                        
                        showString.append(NSMutableAttributedString(attachment: imageToAppend))
                    }
                    else{
                        showString.append(NSMutableAttributedString(string: " "))
                    }
                }
                else{
                    let val = String(tempText[tempText.index(tempText.startIndex, offsetBy: index)])
                    showString.append(NSMutableAttributedString(string: val))
                }
            }
            
            cell.paymentLabel.attributedText = showString
            cell.paymentLabel.baselineAdjustment = .alignCenters
        }
        
        cell.contentView.layer.cornerRadius = 10
        
        if (isAddnewCardButtonHidden == false && cell.cardNumber == previouslySelectedRowText) {
            previouslySelectedRow?.isRowSelected(false)
            previouslySelectedRow = cell
            
            previouslySelectedRow?.isRowSelected(true)
            
            UserDefaults.standard.set(indexPath.row, forKey: "User-\(UserDefaults.standard.integer(forKey: "User - Id"))-Selected-Payment-Option")
        }
        else if(isAddnewCardButtonHidden && cell.cardNumber == selectedCardFromReviewSummary){
            previouslySelectedRow?.isRowSelected(false)
            previouslySelectedRow = cell
            
            previouslySelectedRow?.isRowSelected(true)
        }
        else if(UserDefaults.standard.integer(forKey: "User-\(UserDefaults.standard.integer(forKey: "User - Id"))-Selected-Payment-Option") == indexPath.row && !isPresented){
            previouslySelectedRow?.isRowSelected(false)
            previouslySelectedRow = cell
            
            previouslySelectedRow?.isRowSelected(true)
        }
        else{
            cell.isRowSelected(false)
        }
        
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PaymentsCollectionViewCell else {
            return
        }
        
        if(cell.showRadioButton == false){
            return
        }
        
        print("Cell selected")
        
        if(previouslySelectedRow == nil){
            previouslySelectedRow = cell
            previouslySelectedRow?.isRowSelected(true)
            
            previouslySelectedRowText = cell.cardNumber
        }
        else{
            previouslySelectedRow?.isRowSelected(false)
            previouslySelectedRow = cell
            previouslySelectedRow?.isRowSelected(true)
            
            previouslySelectedRowText = cell.cardNumber
        }
        
        UserDefaults.standard.set(indexPath.row, forKey: "User-\(UserDefaults.standard.integer(forKey: "User - Id"))-Selected-Payment-Option")
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            var padding = CGFloat.zero
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
                padding = 70
                if(isPresented) {
                    padding = 20
                }
                return CGSize(width: view.frame.width/3 - (padding), height: 100)
            }
            
            padding = 0.11*view.frame.width
            if(isPresented) {
                padding = 30
            }
            return CGSize(width: view.frame.width/2 - (padding), height: 100)
        }
        else{
            return CGSize(width: view.frame.width - 20, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
        else{
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if(isAddnewCardButtonHidden == true){
            return .zero
        }
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            return CGSize(width: view.frame.width - (0.05*view.frame.width), height: 100)
        }
        else{
            return CGSize(width: view.frame.width - 40, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            return CGSize(width: view.frame.width/2 - 20, height: 100)
        }
        else{
            return CGSize(width: view.frame.width - 40, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print(kind)
        switch(kind){
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PaymentsCVCollectionReusableFooterView.identifier, for: indexPath) as? PaymentsCVCollectionReusableFooterView else {
                return UICollectionReusableView()
            }
            
            footer.delegateForFooter = self
            
            return footer
            
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PaymentsCVCollectionReusableHeaderView.identifier, for: indexPath) as? PaymentsCVCollectionReusableHeaderView else {
                return UICollectionReusableView()
            }
            
            return header
            
        default:
            break
        }
        return UICollectionReusableView()
    }
}
