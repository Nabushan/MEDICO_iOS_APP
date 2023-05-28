//
//  BookAppointmentReviewSummaryVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 18/10/22.
//

import UIKit

class PaymentReviewSummaryVC: UIViewController, ShowAvailableCardForChangeProtocol, ChangeCardForPaymentProtocol {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(AppointmentPaymentTimingAndPackageCollectionViewCell.self,
                                forCellWithReuseIdentifier: AppointmentPaymentTimingAndPackageCollectionViewCell.identifier)
        collectionView.register(AppointmentPaymentProfileCollectionViewCell.self,
                                forCellWithReuseIdentifier: AppointmentPaymentProfileCollectionViewCell.identifier)
        collectionView.register(PaymentsCollectionViewCell.self, forCellWithReuseIdentifier: PaymentsCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    lazy var nextButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    var reviewSummary: ReviewSummary
    var consultation: ConsultationGetter
    var isProfilePresent: Bool = false
    var isConcultationHourPresent: Bool = false
    var isAmountAndDurationPresent: Bool = false
    var cardImages: [UIImage]
    var cardDetails: [CardDetails]
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    init(reviewSummary: ReviewSummary, consultation: ConsultationGetter, cardImages: [UIImage], cardDetails: [CardDetails]) {
        self.reviewSummary = reviewSummary
        self.consultation = consultation
        self.cardImages = cardImages
        self.cardDetails = cardDetails
        
        super.init(nibName: nil, bundle: nil)
        
        isProfilePresent = true
        isConcultationHourPresent = true
        isAmountAndDurationPresent = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "Review Summary"
        
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        
        configureDelegates()
        loadContents()
    }
    
    func configureDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        loadContents()
        collectionView.reloadData()
    }
    
    func loadContents(){
        loadCollectionView()
        loadNextButton()
    }
    
    func loadCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = view.backgroundColor
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.1*view.frame.width),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -0.1*view.frame.width),
                collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
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
            previousConstraintsToDeActivate.append(constraint)
        }
        
        if(view.frame.height > 800){
            let constraint = nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065)
            
            constraint.isActive = true
            
            previousConstraintsToDeActivate.append(constraint)
        }
        
        nextButton.layer.cornerRadius = 10
    }
    
    @objc func didTapNextButton(_ sender: UIButton) {
        print("Raview Summary next button tapped.")
        
        let pinValidationVC = PaymentsPinCheckerVC(consultation: consultation)
        
        navigationController?.pushViewController(pinValidationVC, animated: true)
    }
    
    func showAvailableCards(selectedCardNumber: String) {
        
        let availableCardsVC = PaymentsVC(cardImages: cardImages, cardDetails: cardDetails, selectedCardNumber: selectedCardNumber)
        availableCardsVC.delegateForAvailableCardDisplay = self
        availableCardsVC.isPresented = true
        
        present(UINavigationController(rootViewController: availableCardsVC), animated: true)
    }
    
    func changeSelectedCardOfReviewSummary(to selectedCard: SelectedCard) {
        reviewSummary.selectedCardType = selectedCard
    }
    
    func reloadPaymentCardRow() {
        if(isProfilePresent && isConcultationHourPresent && isAmountAndDurationPresent){
            let indexPath = IndexPath(row: 3, section: 0)
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

extension PaymentReviewSummaryVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isProfilePresent && isConcultationHourPresent && isAmountAndDurationPresent){
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(isProfilePresent && isConcultationHourPresent && isAmountAndDurationPresent){
            
            if(indexPath.row == 0){
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentPaymentProfileCollectionViewCell.identifier, for: indexPath) as? AppointmentPaymentProfileCollectionViewCell else{
                    return UICollectionViewCell()
                }
                
                cell.layer.cornerRadius = 10
                cell.backgroundColor = .secondarySystemBackground
                
                cell.profileImageView.downloaded(from: reviewSummary.docImage ?? "")
                
                cell.nameLabel.text = reviewSummary.docName
                cell.designationLabel.text = reviewSummary.docDesignation.specializationType
                cell.addressLabel.text = reviewSummary.docAddress
                
                
                return cell
            }
            else if(indexPath.row == 1){
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentPaymentTimingAndPackageCollectionViewCell.identifier, for: indexPath) as? AppointmentPaymentTimingAndPackageCollectionViewCell else{
                    return UICollectionViewCell()
                }
                
                cell.layer.cornerRadius = 10
                cell.backgroundColor = .secondarySystemBackground
                cell.shouldShowLineView = false
                
                cell.leftTopText = "Date & Hour"
                cell.leftMiddleText = "Package"
                cell.leftBottomText = "Duration"
                
                cell.rightTopText = "\(reviewSummary.date ?? "") | \(reviewSummary.hourSlot ?? "")"
                cell.rightMiddleText = "\(reviewSummary.package ?? "nil")"
                cell.rightBottomText = "\(reviewSummary.duration ?? "-")"
                
                return cell
            }
            else if(indexPath.row == 2){
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppointmentPaymentTimingAndPackageCollectionViewCell.identifier, for: indexPath) as? AppointmentPaymentTimingAndPackageCollectionViewCell else{
                    return UICollectionViewCell()
                }
                
                cell.layer.cornerRadius = 10
                cell.backgroundColor = .secondarySystemBackground
                cell.shouldShowLineView = true
                
                cell.leftTopText = "Amount"
                cell.leftMiddleText = "Duration(30 mins)"
                cell.leftBottomText = "Total"
                
                cell.rightTopText = "Rs. 600"
                cell.rightMiddleText = "1 x Rs.600"
                cell.rightBottomText = "600"
                
                return cell
            }
            
            else if(indexPath.row == 3){
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentsCollectionViewCell.identifier, for: indexPath) as? PaymentsCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.showRadioButton = false
                cell.delegate = self
                
                cell.contentView.layer.cornerRadius = 10
                guard let cardDetail = reviewSummary.selectedCardType else {
                    return UICollectionViewCell()
                }
                
                cell.paymentImageView.image = cardDetail.cardImage
                cell.paymentLabel.attributedText = cardDetail.arrtibutedCardNumber
                cell.cardNumber = cardDetail.cardNumber
                
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            if(indexPath.row == 3){
                return CGSize(width: view.frame.width - (0.2*view.frame.width), height: 100)
            }
            else{
                return CGSize(width: view.frame.width - (0.2*view.frame.width), height: 130)
            }
        }
        else{
            if(indexPath.row == 3){
                return CGSize(width: view.frame.width - 20, height: 80)
            }
            else{
                return CGSize(width: view.frame.width - 20, height: 130)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
