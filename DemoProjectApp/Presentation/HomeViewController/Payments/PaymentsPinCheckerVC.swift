//
//  PaymentsPinCheckerVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 18/10/22.
//

import UIKit

class PaymentsPinCheckerVC: UIViewController, PinCheckerProtocol, SegueToParentProtocol {

    let consultation: ConsultationGetter
    let paymentsPinCheckerHelperVC: PaymentsPinCheckerHelperVC
    
    lazy var infoLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var pinOneTextView: UITextView = {
        let textView = UITextView()
        
        textView.isSecureTextEntry = false
        textView.contentMode = .center
        textView.textAlignment = .center
        textView.font = .systemFont(ofSize: 30, weight: .medium)
        textView.keyboardType = .decimalPad
        textView.textColor = .label
        textView.isScrollEnabled = false
        textView.contentInset = UIEdgeInsets(
            top: textView.intrinsicContentSize.height/2 - 7,
            left: 0,
            bottom: textView.intrinsicContentSize.height/2 - 5,
            right: 0)
        
        return textView
    }()
    
    lazy var pinOneImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "circle")
        imageView.backgroundColor = .clear
        imageView.tintColor = .label
        
        return imageView
    }()
    
    lazy var pinTwoImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "circle")
        imageView.backgroundColor = .clear
        imageView.tintColor = .label
        
        return imageView
    }()
    
    lazy var pinThreeImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "circle")
        imageView.backgroundColor = .clear
        imageView.tintColor = .label
        
        return imageView
    }()
    
    lazy var pinFourImageView: UIImageView = {
        let imageView = UIImageView()
    
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "circle")
        imageView.backgroundColor = .clear
        imageView.tintColor = .label
        
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        view.axis = .horizontal
        view.contentMode = .center
        view.distribution = .equalSpacing
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var nextButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    var password = ""
    var nextButtonBottomAnchor: NSLayoutConstraint?
    var previousConstraintsToDeactivate: [NSLayoutConstraint] = []
    var isAddedToDB: Bool = false
    var isFromCart: Bool = false
    
    var cartPaymentCompletionDelegate: CartPaymentCompletionProtocol?
    
    init(consultation: ConsultationGetter){
        self.consultation = consultation
        self.paymentsPinCheckerHelperVC = PaymentsPinCheckerHelperVC()
        
        super.init(nibName: nil, bundle: nil)
        
        paymentsPinCheckerHelperVC.delegate = self
    }
    
    init(isFromCart: Bool) {
        self.isFromCart = isFromCart
        self.paymentsPinCheckerHelperVC = PaymentsPinCheckerHelperVC()
        self.consultation = ConsultationGetter(doctorId: nil,
                                               doctorName: nil,
                                               doctorImage: nil,
                                               consultationDate: nil,
                                               consultationTime: nil,
                                               patientName: nil,
                                               patientGender: nil,
                                               patientAge: nil,
                                               patientProblem: nil,
                                               packageInfomation: nil,
                                               cost: nil,
                                               status: nil,
                                               forUserId: -1)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "Payment Page"
        
        view.addSubview(infoLabel)
        view.addSubview(stackView)
        view.addSubview(pinOneTextView)
        stackView.addArrangedSubview(pinOneImageView)
        stackView.addArrangedSubview(pinTwoImageView)
        stackView.addArrangedSubview(pinThreeImageView)
        stackView.addArrangedSubview(pinFourImageView)
        
        view.addSubview(nextButton)
        
        configureDelegates()
        loadContents()
        addTapGesture(toView: stackView)
        
        pinOneTextView.becomeFirstResponder()
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            nextButtonBottomAnchor?.isActive = false
            nextButtonBottomAnchor = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(keyboardSize.height + 20))
            nextButtonBottomAnchor?.isActive = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        nextButtonBottomAnchor?.isActive = false
        nextButtonBottomAnchor = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        nextButtonBottomAnchor?.isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeactivate)
        previousConstraintsToDeactivate = []
        loadContents()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeactivate)
        previousConstraintsToDeactivate = []
        loadContents()
    }
    
    func configureDelegates() {
        pinOneTextView.delegate = self
    }
    
    func loadContents(){
        loadInfoLabel()
        loadStarStackView()
        loadPinOneImageView()
        loadPinTwoImageView()
        loadPinThreeImageView()
        loadPinFourImageView()
        loadNextButton()
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == stackView){
            tapGesture.addTarget(self, action: #selector(didTapPassWordField))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapPassWordField(_ sender: UITapGestureRecognizer) {
        pinOneTextView.becomeFirstResponder()
    }
    
    func loadInfoLabel() {
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        infoLabel.text = "Enter you pin to confirm appointment."
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.1*view.frame.height),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func loadStarStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.2*view.frame.height),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        previousConstraintsToDeactivate = constraints
    }
    
    func loadPinOneImageView() {
        pinOneImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            pinOneImageView.widthAnchor.constraint(equalToConstant: 20),
            pinOneImageView.heightAnchor.constraint(equalTo: pinOneImageView.widthAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
        
    }
    
    func loadPinTwoImageView() {
        pinTwoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pinTwoImageView.widthAnchor.constraint(equalTo: pinOneImageView.widthAnchor),
            pinTwoImageView.heightAnchor.constraint(equalTo: pinTwoImageView.widthAnchor),
        ])
        
        pinOneImageView.layer.cornerRadius = 10
    }
    
    func loadPinThreeImageView() {
        pinThreeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pinThreeImageView.widthAnchor.constraint(equalTo: pinOneImageView.widthAnchor),
            pinThreeImageView.heightAnchor.constraint(equalTo: pinThreeImageView.widthAnchor),
        ])
        
        pinThreeImageView.layer.cornerRadius = 10
    }
    
    func loadPinFourImageView() {
        pinFourImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pinFourImageView.widthAnchor.constraint(equalTo: pinThreeImageView.widthAnchor),
            pinFourImageView.heightAnchor.constraint(equalTo: pinFourImageView.widthAnchor),
        ])
        
        pinFourImageView.layer.cornerRadius = 10
    }
    
    func loadNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        
        nextButton.alpha = 0
        
        let constraints = [
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeactivate.append(constraint)
        }
        
        var bottomPadding = view.safeAreaInsets.bottom
        
        if(view.frame.height > 750) {
            bottomPadding+=10
        }
        
        nextButtonBottomAnchor = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomPadding + 20))
        
        nextButtonBottomAnchor?.isActive = true
        
        previousConstraintsToDeactivate.append(nextButtonBottomAnchor!)
        
        if(view.frame.height > 800){
            let heightAnchor = nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.065)
            heightAnchor.isActive = true
            
            previousConstraintsToDeactivate.append(heightAnchor)
        }
        
        nextButton.layer.cornerRadius = 10
    }
    
    func fillPasswordFields(_ tillValue: Int) {
        let array = stackView.arrangedSubviews
        for index in 0..<tillValue {
            if let imageView = array[index] as? UIImageView {
                imageView.image = UIImage(systemName: "circle.fill")
            }
        }
        
        for index in tillValue..<array.count {
            if let imageView = array[index] as? UIImageView {
                imageView.image = UIImage(systemName: "circle")
            }
        }
    }
    
    @objc func didTapContinueButton(_ sender: UIButton) {
        print("Continue Button Clicked")
        
        let pin = pinOneTextView.text ?? ""
        print(pin)
        
        checkPin(pin)
    }
    
    func checkPin(_ pinValue: String) {
        var resultVC: SuccessResultVC?
        var isSuccess: Bool = false
        
        if(pinValue == "1111"){
            print("Password valid")
            
            if(isFromCart) {
                let alertViewController = UIAlertController(title: "Order Placed.", message: "Your order has been placed successfully.", preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: "Okay", style: .default){_ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.dismiss(animated: true)
                        self.cartPaymentCompletionDelegate?.didCompletePayment()
                    }
                })
                
                present(alertViewController, animated: true)
                return
            }
            
            resultVC = SuccessResultVC(isSuccess: true, resultTitle: "Congratulations!", message: "Appointment successfully booked. You will recieve a notification and the doctor you selected will contact you.", consultation: consultation, isFromPayments: true)
            
            resultVC?.delegateForSegue = self
            
            if(!isAddedToDB){
                print("Adding consultation detail to DB")
                paymentsPinCheckerHelperVC.addConsultation(consultation)
                isAddedToDB = true
            }
            
            isSuccess = true
        }
        else{
            if(isFromCart) {
                let alertViewController = UIAlertController(title: "Incorrect Pin.", message: "Please Try Again.", preferredStyle: .alert)
                
                alertViewController.addAction(UIAlertAction(title: "Cancel", style: .default){_ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.dismiss(animated: true)
                        self.cartPaymentCompletionDelegate?.didCancelPayment()
                    }
                })
                
                alertViewController.addAction(UIAlertAction(title: "Try Again", style: .default){_ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.fillPasswordFields(0)
                        self.pinOneTextView.text = ""
                    }
                })
                
                present(alertViewController, animated: true)
                return
            }
            
            resultVC = SuccessResultVC(isSuccess: false, resultTitle: "Oops, Failed!", message: "Appointment failed. Please check your internet connection and password and try again.", consultation: nil, isFromPayments: true)
            
            resultVC?.delegateForSegue = self
        }
        
        
        guard let resultVC = resultVC else {
            return
        }
        
        let resultNavVC = UINavigationController(rootViewController: resultVC)
        resultNavVC.modalPresentationStyle = .overCurrentContext
        
        present(resultNavVC, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.pinOneTextView.text = ""
            self.fillPasswordFields(0)
        }
    }
    
    func segueToParent() {
        guard let vc = self.navigationController?.viewControllers.filter({$0 is DoctorProfileVC}).first else {
            return
        }
        
        self.navigationController?.popToViewController(vc, animated: true)
    }
}

extension PaymentsPinCheckerVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""

        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        print(updatedText)
        
        fillPasswordFields(updatedText.count)
        
        if(updatedText.count == 4){
            checkPin(updatedText)
        }
        
        return updatedText.count < 4
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
        textView.contentInset = UIEdgeInsets(
            top: textView.intrinsicContentSize.height/2 - 7,
            left: 0,
            bottom: textView.intrinsicContentSize.height/2 - 5,
            right: 0)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension PaymentsPinCheckerVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pinOneTextView.becomeFirstResponder()
        pinOneTextView.text = ""
        fillPasswordFields(0)
    }
}
