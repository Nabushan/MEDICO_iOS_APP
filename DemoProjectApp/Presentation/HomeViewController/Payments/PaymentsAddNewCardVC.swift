//
//  BookAppointmentPaymentsAddNewCardVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 17/10/22.
//

import UIKit

class PaymentsAddNewCardVC: UIViewController, PaymentsAddNewCardProtocol {

    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var cardNameLabel: ResizedLabel = {
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
    
    lazy var cardNameField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 15,
            left: 20,
            bottom: 15,
            right: 20
        )
        
        textField.textColor = .label
        textField.returnKeyType = .next
        textField.keyboardType = .alphabet
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        
        return textField
    }()
    
    lazy var cardNumberLabel: ResizedLabel = {
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
    
    lazy var cardNumberField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 15,
            left: 20,
            bottom: 15,
            right: 20
        )
        
        textField.textColor = .label
        textField.returnKeyType = .next
        textField.keyboardType = .decimalPad
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        
        return textField
    }()
    
    lazy var expiryDateLabel: ResizedLabel = {
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
    
    lazy var expiryDateField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 15,
            left: 20,
            bottom: 15,
            right: 20
        )
        
        textField.textColor = .label
        textField.returnKeyType = .next
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        
        return textField
    }()
    
    lazy var cvvLabel: ResizedLabel = {
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
    
    lazy var cvvField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 15,
            left: 20,
            bottom: 15,
            right: 20
        )
        
        textField.textColor = .label
        textField.returnKeyType = .next
        textField.keyboardType = .decimalPad
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        
        return textField
    }()
    
    lazy var cardTypeLabel: ResizedLabel = {
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
    
    lazy var cardTypeField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        
        textField.textPadding = UIEdgeInsets(
            top: 15,
            left: 20,
            bottom: 15,
            right: 20
        )
        
        textField.textColor = .label
        textField.returnKeyType = .done
        textField.keyboardType = .alphabet
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.isUserInteractionEnabled = true
        
        return textField
    }()
    
    lazy var addNewCardButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("Add Card", for: .normal)
        button.layer.cornerRadius = button.intrinsicContentSize.height/2
        
        return button
    }()
    
    let calendar = Calendar.current
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.timeZone = .current
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        var minDateComponents = DateComponents()
        minDateComponents.year = -3
        
        datePicker.minimumDate = calendar.date(byAdding: minDateComponents, to: Date.now)
        
        var maxDateComponents = DateComponents()
        maxDateComponents.year = 3
        
        datePicker.maximumDate = calendar.date(byAdding: maxDateComponents, to: Date.now)
        
        return datePicker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter
    }()
    
    lazy var cardNumberToolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
                
        return toolBar
    }()
    
    lazy var expiryDateToolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        return toolBar
    }()
    
    lazy var cvvToolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        return toolBar
    }()
    
    lazy var cardHolderImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
    }()
    
    lazy var cardNumberImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
    }()
    
    lazy var expiryDateImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
    }()
    
    lazy var cvvImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
    }()
    
    lazy var cardTypeImportantMarkLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "*"
        
        return label
    }()
    
    lazy var viewForPickerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = self.view.backgroundColor
        
        return view
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    lazy var pickerViewToolBarLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        label.text = "Select Card"
        
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    var toolBar: UIToolbar!
    
    var initialOriginY = 0.0
    var cardHolderNameWasFirstResponder = false
    var chosenCardType: PaymentType?
    var trackCount = 4
    var paymentsAddNewCardHelperVC: PaymentsAddNewCardHelperVC
    
    weak var cardsListVCDelegate: AddedCardDetailUpdationProtocol?
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    var cardChoice = ["Master Card", "Visa"]
    
    init(){
        paymentsAddNewCardHelperVC = PaymentsAddNewCardHelperVC()
        
        super.init(nibName: nil, bundle: nil)
        
        paymentsAddNewCardHelperVC.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "Add New Card"
        
        toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolBar.sizeToFit()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(cardImageView)
        scrollView.addSubview(cardNameLabel)
        scrollView.addSubview(cardNameField)
        scrollView.addSubview(cardHolderImportantMarkLabel)
        scrollView.addSubview(cardNumberLabel)
        scrollView.addSubview(cardNumberField)
        scrollView.addSubview(cardNumberImportantMarkLabel)
        scrollView.addSubview(expiryDateLabel)
        scrollView.addSubview(expiryDateField)
        scrollView.addSubview(expiryDateImportantMarkLabel)
        scrollView.addSubview(cvvLabel)
        scrollView.addSubview(cvvField)
        scrollView.addSubview(cvvImportantMarkLabel)
        scrollView.addSubview(cardTypeLabel)
        scrollView.addSubview(cardTypeField)
        scrollView.addSubview(cardTypeImportantMarkLabel)
        scrollView.addSubview(addNewCardButton)
        
        view.addSubview(viewForPickerView)
        
        viewForPickerView.addSubview(toolBar)
        toolBar.addSubview(pickerViewToolBarLabel)
        viewForPickerView.addSubview(pickerView)
        
        configureDelegates()
        
        loadScrollView()
        loadPickerView()
        
        loadContents()
        
        viewForPickerView.isHidden = true
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        addTapGesture(toView: view)
        addTapGesture(toView: cardTypeField)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        viewForPickerView.isHidden = true
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if(UITraitCollection.current.userInterfaceIdiom == .pad){
                if (self.view.frame.origin.y == 0 || cardNameField.isFirstResponder) {
                    if(cardNameField.isFirstResponder && self.view.frame.origin.y != 0){
                        self.view.frame.origin.y = initialOriginY + 220
                    }
                    else{
                        if(cardNameField.isFirstResponder && cardHolderNameWasFirstResponder == false){
                            cardHolderNameWasFirstResponder = true
                        }
                        self.view.frame.origin.y -= (keyboardSize.height - 220)
                        initialOriginY = self.view.frame.origin.y
                        print(self.view.frame.origin.y)
                    }
                }
            }
            else if self.view.frame.origin.y == 0 || cardNameField.isFirstResponder {
                if(cardNameField.isFirstResponder && self.view.frame.origin.y != 0){
                    self.view.frame.origin.y = initialOriginY + 70
                }
                else{
                    if(cardNameField.isFirstResponder && cardHolderNameWasFirstResponder == false){
                        cardHolderNameWasFirstResponder = true
                    }
                    self.view.frame.origin.y -= (keyboardSize.height - 70)
                    initialOriginY = self.view.frame.origin.y
                    print(self.view.frame.origin.y)
                }
            }
            else {
                if(cardHolderNameWasFirstResponder == true){
                    if(view.frame.height < 800){
                        self.view.frame.origin.y = initialOriginY - 70
                    }
                    else if(view.frame.height > 800 && expiryDateField.isFirstResponder){
                        self.view.frame.origin.y = initialOriginY + 20
                    }
                    else{
                        self.view.frame.origin.y = initialOriginY - 65
                    }
                }
                else{
                    self.view.frame.origin.y = initialOriginY - 60
                }
                print(self.view.frame.origin.y)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        self.view.frame.origin.y = 0
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        loadContents()
    }
    
    func configureDelegates() {
        cardNameField.delegate = self
        cardNumberField.delegate = self
        expiryDateField.delegate = self
        cvvField.delegate = self
        cardTypeField.delegate = self
        
        scrollView.delegate = self
        pickerView.delegate = self
        
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapPickerViewCancel))
        let nextBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapPickerViewNext))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelBarButton, flexibleSpace, nextBarButton], animated: true)
    }
    
    func loadScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func didTapPickerViewCancel(_ sender: UIBarButtonItem) {
        dismissKeyBoard()
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapPickerViewNext(_ sender: UIBarButtonItem) {
        dismissKeyBoard()
    }
    
    func loadContents() {
        loadCardImageView()
        loadCardNameLabel()
        loadCardNameField()
        loadCardHolderImportantMarkLabel()
        loadCardNumberLabel()
        loadCardNumberField()
        loadCardNumberImportantMarkLabel()
        loadExpiryDateLabel()
        loadExpiryDateField()
        loadExpiryDateImportantMarkLabel()
        loadCvvLabel()
        loadCvvField()
        loadCvvImportantMarkLabel()
        loadCardTypeLabel()
        loadCardTypeField()
        loadCardTypeImportantMarkLabel()
        loadAddNewCardButtonButton()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        else{
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    func loadPickerView() {
        viewForPickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        pickerViewToolBarLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var toolBarHeight = CGFloat(50)
        
        let constraints = [
            viewForPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewForPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewForPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            viewForPickerView.heightAnchor.constraint(equalToConstant: (0.3 * view.frame.height) + toolBarHeight),
            
            pickerView.widthAnchor.constraint(equalTo: viewForPickerView.widthAnchor),
            pickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            pickerView.centerXAnchor.constraint(equalTo: viewForPickerView.centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: viewForPickerView.bottomAnchor),
            
            toolBar.bottomAnchor.constraint(equalTo: pickerView.topAnchor),
            toolBar.centerXAnchor.constraint(equalTo: viewForPickerView.centerXAnchor),
            toolBar.widthAnchor.constraint(equalTo: viewForPickerView.widthAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: toolBarHeight),
            
            pickerViewToolBarLabel.centerXAnchor.constraint(equalTo: toolBar.centerXAnchor),
            pickerViewToolBarLabel.centerYAnchor.constraint(equalTo: toolBar.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadCardImageView() {
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        
        cardImageView.image = UIImage(named: "Card")
        
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5),
            cardImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            cardImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
        
        if(view.frame.height > 800){
            cardImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        }
        else{
            
            cardImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        }
    }
    
    func loadCardNameLabel() {
        cardNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cardNameLabel.text = "Card Holder Name"
        
        cardNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        var leadingAnchor: NSLayoutConstraint?
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            leadingAnchor = cardNameLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 0.1*view.frame.width - 15)
        }
        else{
            leadingAnchor = cardNameLabel.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor)
        }
        
        guard let leadingAnchor = leadingAnchor else {
            return
        }
        
        let constraints = [
            cardNameLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 10),
            leadingAnchor
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadCardNameField() {
        cardNameField.translatesAutoresizingMaskIntoConstraints = false
        
        cardNameField.backgroundColor = .secondarySystemBackground
        cardNameField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                cardNameField.topAnchor.constraint(equalTo: cardNameLabel.bottomAnchor, constant: 5),
                cardNameField.leadingAnchor.constraint(equalTo: cardImageView.leadingAnchor, constant: 0.1*view.frame.width - 15),
                cardNameField.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: -(0.1*view.frame.width - 15))
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                cardNameField.topAnchor.constraint(equalTo: cardNameLabel.bottomAnchor, constant: 5),
                cardNameField.leadingAnchor.constraint(equalTo: cardNameLabel.leadingAnchor),
                cardNameField.trailingAnchor.constraint(equalTo: cardImageView.trailingAnchor),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        
        cardNameField.layer.cornerRadius = 10
    }
    
    func loadCardHolderImportantMarkLabel() {
        cardHolderImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardHolderImportantMarkLabel.topAnchor.constraint(equalTo: cardNameLabel.topAnchor),
            cardHolderImportantMarkLabel.leadingAnchor.constraint(equalTo: cardNameLabel.trailingAnchor, constant: -8)
        ])
    }
    
    func loadCardNumberLabel() {
        cardNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cardNumberLabel.text = "Card Number"
        
        cardNumberLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            cardNumberLabel.topAnchor.constraint(equalTo: cardNameField.bottomAnchor, constant: 10),
            cardNumberLabel.leadingAnchor.constraint(equalTo: cardNameField.leadingAnchor),
        ])
    }
    
    func loadCardNumberField() {
        cardNumberField.translatesAutoresizingMaskIntoConstraints = false
        
        cardNumberField.backgroundColor = .secondarySystemBackground
        cardNumberField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        cardNumberField.inputAccessoryView = cardNumberToolBar
        
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapCardNumberFieldNextButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCardNumberFieldCancelButton))
        
        cardNumberToolBar.setItems([cancelButton, flexibleSpace, nextButton], animated: true)
        cardNumberToolBar.backgroundColor = view.backgroundColor
        
        NSLayoutConstraint.activate([
            cardNumberField.topAnchor.constraint(equalTo: cardNumberLabel.bottomAnchor, constant: 5),
            cardNumberField.leadingAnchor.constraint(equalTo: cardNumberLabel.leadingAnchor),
            cardNumberField.trailingAnchor.constraint(equalTo: cardNameField.trailingAnchor),
        ])
        
        cardNumberField.layer.cornerRadius = 10
    }
    
    func loadCardNumberImportantMarkLabel() {
        cardNumberImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardNumberImportantMarkLabel.topAnchor.constraint(equalTo: cardNumberLabel.topAnchor),
            cardNumberImportantMarkLabel.leadingAnchor.constraint(equalTo: cardNumberLabel.trailingAnchor, constant: -8)
        ])
    }
    
    @objc func didTapCardNumberFieldNextButton(_ sender: UIBarButtonItem) {
        expiryDateField.becomeFirstResponder()
    }
    
    @objc func didTapCardNumberFieldCancelButton(_ sender: UIBarButtonItem) {
        cardNumberField.resignFirstResponder()
    }
    
    func loadExpiryDateLabel() {
        expiryDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        expiryDateLabel.text = "Expiry Date"
        
        expiryDateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            expiryDateLabel.topAnchor.constraint(equalTo: cardNumberField.bottomAnchor, constant: 10),
            expiryDateLabel.leadingAnchor.constraint(equalTo: cardNumberField.leadingAnchor),
        ])
    }
    
    func loadExpiryDateField(){
        expiryDateField.translatesAutoresizingMaskIntoConstraints = false
        
        expiryDateField.backgroundColor = .secondarySystemBackground
        expiryDateField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        expiryDateField.inputView = datePicker
        expiryDateField.inputAccessoryView = expiryDateToolBar
        
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapExpiryDateFieldNextButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapExpiryDateFieldCancelButton))
        
        expiryDateToolBar.setItems([cancelButton, flexibleSpace, nextButton], animated: true)
        expiryDateToolBar.backgroundColor = view.backgroundColor
        
        NSLayoutConstraint.activate([
            expiryDateField.topAnchor.constraint(equalTo: expiryDateLabel.bottomAnchor, constant: 5),
            expiryDateField.leadingAnchor.constraint(equalTo: expiryDateLabel.leadingAnchor),
            expiryDateField.widthAnchor.constraint(equalTo: cardNumberField.widthAnchor, multiplier: 0.47)
        ])
        
        expiryDateField.layer.cornerRadius = 10
    }
    
    func loadExpiryDateImportantMarkLabel() {
        expiryDateImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            expiryDateImportantMarkLabel.topAnchor.constraint(equalTo: expiryDateLabel.topAnchor),
            expiryDateImportantMarkLabel.leadingAnchor.constraint(equalTo: expiryDateLabel.trailingAnchor, constant: -8)
        ])
    }
    
    @objc func didTapExpiryDateFieldNextButton(_ sender: UIBarButtonItem) {
        expiryDateField.text = dateFormatter.string(from: datePicker.date)
        cvvField.becomeFirstResponder()
    }
    
    @objc func didTapExpiryDateFieldCancelButton(_ sender: UIBarButtonItem) {
        expiryDateField.resignFirstResponder()
    }
    
    func loadCvvLabel() {
        cvvLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cvvLabel.text = "CVV"
        cvvLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            cvvLabel.topAnchor.constraint(equalTo: expiryDateLabel.topAnchor),
            cvvLabel.leadingAnchor.constraint(equalTo: cvvField.leadingAnchor)
        ])
    }
    
    func loadCvvField() {
        cvvField.translatesAutoresizingMaskIntoConstraints = false
        
        cvvField.backgroundColor = .secondarySystemBackground
        cvvField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        cvvField.inputAccessoryView = cvvToolBar
        
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapCvvFieldNextButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCvvFieldCancelButton))
        
        cvvToolBar.setItems([cancelButton, flexibleSpace, nextButton], animated: true)
        cvvToolBar.backgroundColor = view.backgroundColor
        
        NSLayoutConstraint.activate([
            cvvField.topAnchor.constraint(equalTo: cvvLabel.bottomAnchor, constant: 5),
            cvvField.trailingAnchor.constraint(equalTo: cardNumberField.trailingAnchor),
            cvvField.widthAnchor.constraint(equalTo: cardNumberField.widthAnchor, multiplier: 0.47)
        ])
        
        cvvField.layer.cornerRadius = 10
    }
    
    func loadCvvImportantMarkLabel() {
        cvvImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cvvImportantMarkLabel.topAnchor.constraint(equalTo: cvvLabel.topAnchor),
            cvvImportantMarkLabel.leadingAnchor.constraint(equalTo: cvvLabel.trailingAnchor, constant: -8)
        ])
    }
    
    @objc func didTapCvvFieldNextButton(_ sender: UIBarButtonItem) {
        cvvField.resignFirstResponder()
        
        showViewForPickerView()
    }
    
    @objc func didTapCvvFieldCancelButton(_ sender: UIBarButtonItem) {
        cvvField.resignFirstResponder()
    }
    
    func loadCardTypeLabel() {
        cardTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cardTypeLabel.text = "Card Type"
        cardTypeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            cardTypeLabel.topAnchor.constraint(equalTo: expiryDateField.bottomAnchor, constant: 10),
            cardTypeLabel.leadingAnchor.constraint(equalTo: expiryDateField.leadingAnchor),
        ])
    }
    
    func loadCardTypeField() {
        cardTypeField.translatesAutoresizingMaskIntoConstraints = false
        
        cardTypeField.backgroundColor = .secondarySystemBackground
        cardTypeField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            cardTypeField.topAnchor.constraint(equalTo: cardTypeLabel.bottomAnchor, constant: 5),
            cardTypeField.leadingAnchor.constraint(equalTo: cardTypeLabel.leadingAnchor),
            cardTypeField.trailingAnchor.constraint(equalTo: cvvField.trailingAnchor),
        ])
        
        cardTypeField.layer.cornerRadius = 10
    }
    
    func loadCardTypeImportantMarkLabel() {
        cardTypeImportantMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardTypeImportantMarkLabel.topAnchor.constraint(equalTo: cardTypeLabel.topAnchor),
            cardTypeImportantMarkLabel.leadingAnchor.constraint(equalTo: cardTypeLabel.trailingAnchor, constant: -8)
        ])
    }
    
    func getMenu() -> UIMenu {
        
        let masterCardAction = UIAction(title: "Master Card") { [weak self] _ in
            self?.chosenCardType = .masterCard
            self?.cardTypeField.text = self?.chosenCardType?.typeName
        }
        
        let visaAction = UIAction(title: "Visa") { [weak self] _ in
            self?.chosenCardType = .visa
            self?.cardTypeField.text = self?.chosenCardType?.typeName
        }
        
        return UIMenu(options: .singleSelection ,children: [masterCardAction, visaAction])
    }
    
    func loadAddNewCardButtonButton() {
        addNewCardButton.translatesAutoresizingMaskIntoConstraints = false
        
        addNewCardButton.addTarget(self, action: #selector(didTapAddCardButton), for: .touchUpInside)
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            addNewCardButton.topAnchor.constraint(equalTo: cardTypeField.bottomAnchor, constant: 10).isActive = true
            addNewCardButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
        }
        else {
            addNewCardButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        }
        
        NSLayoutConstraint.activate([
            addNewCardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addNewCardButton.leadingAnchor.constraint(equalTo: expiryDateField.leadingAnchor),
            addNewCardButton.trailingAnchor.constraint(equalTo: cvvField.trailingAnchor),
        ])
        
        if(view.frame.height > 800){
            addNewCardButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065).isActive = true
        }
        
        addNewCardButton.layer.cornerRadius = 10
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == view){
            tapGesture.addTarget(self, action: #selector(didTapToDismissKeyBoard))
        }
        if(toView == cardTypeField) {
            tapGesture.addTarget(self, action: #selector(didTapCardTypeField))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapToDismissKeyBoard(_ sender: UITapGestureRecognizer) {
        dismissKeyBoard()
    }
    
    @objc func didTapCardTypeField(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: UIResponder.keyboardWillHideNotification, object: nil)
        showViewForPickerView()
    }
    
    func showViewForPickerView() {
        if(cardTypeField.text?.count == 0) {
            cardTypeField.text = cardChoice[0]
        }
        viewForPickerView.isHidden = false
    }
    
    func dismissKeyBoard() {
        if(cardNameField.isFirstResponder) {
            cardNameField.resignFirstResponder()
        }
        else if(cardNumberField.isFirstResponder) {
            cardNumberField.resignFirstResponder()
        }
        else if(expiryDateField.isFirstResponder) {
            expiryDateField.resignFirstResponder()
        }
        else if(cvvField.isFirstResponder) {
            cvvField.resignFirstResponder()
        }
        else if(cardTypeField.isFirstResponder) {
            cardTypeField.resignFirstResponder()
        }
        
        viewForPickerView.isHidden = true
    }
    
    @objc func didTapAddCardButton(_ sender: UIButton) {
        print("Payment details next button tapped.")
        
        
        guard let name = cardNameField.text,
              let number = cardNumberField.text,
              let expiryDate = expiryDateField.text,
              let cvv = cvvField.text,
              let cardtype = cardTypeField.text
        else {
            return
        }
        
        let card = CardDetails(cardType: chosenCardType ?? .masterCard,
                               cardName: name,
                               cardNumber: number,
                               expiryDate: expiryDate,
                               cvvNumber: cvv)
        
        let alertMessage = paymentsAddNewCardHelperVC.validateCardDetail(card)
        
        let alertVC = UIAlertController(title: "Successfully Added", message: "Your card Details have been added Successfully.", preferredStyle: .alert)
        
        if(alertMessage.state) {
            alertVC.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
                self.cardTypeField.resignFirstResponder()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }))
            
            present(alertVC, animated: true)
            
            paymentsAddNewCardHelperVC.addCardDetailsToDB(card)
            cardsListVCDelegate?.previouslySelectedRowText = number
            cardsListVCDelegate?.updateTableView()
        }
        else {
            alertVC.title = alertMessage.title
            alertVC.message = alertMessage.body
            
            alertVC.addAction(UIAlertAction(title: "Okay", style: .default))
            
            present(alertVC, animated: true)
        }
    }
}

extension PaymentsAddNewCardVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == cardNameField) {
            
            cardNumberField.becomeFirstResponder()
        }
        else if(textField == cardNumberField) {
            
            expiryDateField.becomeFirstResponder()
        }
        else if(textField == expiryDateField) {
            
            cvvField.becomeFirstResponder()
            
            showViewForPickerView()
        }
        else if(textField == cvvField) {
            
            cvvField.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == cardNumberField){
            if((textField.text?.count ?? 1) == trackCount){
                let text = textField.text ?? ""
                
                if(trackCount-1 != 18){
                    textField.text = text + " "
                }
                
                print(textField.text ?? "")
                
                trackCount += 4
                trackCount += 1
            }
            
            let maxLength = 19
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)

            return newString.count <= maxLength
        }
        else if(textField == cvvField){
            let maxLength = 3
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)

            return newString.count <= maxLength
        }
        
        return true
    }
}

extension PaymentsAddNewCardVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        cardChoice.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        cardChoice[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        cardTypeField.text = cardChoice[row]
        
        chosenCardType = PaymentType(rawValue: row + 3)
    }
}

extension PaymentsAddNewCardVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyBoard()
    }
}
