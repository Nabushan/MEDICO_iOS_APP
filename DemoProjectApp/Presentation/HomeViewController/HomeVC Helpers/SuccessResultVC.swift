//
//  PaymentFinalResultVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 19/10/22.
//

import UIKit

class SuccessResultVC: UIViewController {

    lazy var visualEffect: UIVisualEffectView = {
        let visualEffect = UIVisualEffectView()
        
        
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        
        visualEffect.effect = blurEffect
        
        return visualEffect
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var resultLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemBlue
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var messageLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 3
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    
    lazy var resultButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        return button
    }()
    
    lazy var cancelButton: ResizedButton = {
        let button = ResizedButton()
        
        button.backgroundColor = UIColor(red: 233/255, green: 240/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    var isSuccess: Bool
    var resultTitle: String
    var message: String
    
    var consultationGetter: ConsultationGetter?
    
    weak var delegateForSegue: SegueToParentProtocol?
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    var isFromPayments: Bool = false
    
    init(isSuccess: Bool, resultTitle: String, message: String, consultation: ConsultationGetter?, isFromPayments: Bool){
        self.isSuccess = isSuccess
        self.resultTitle = resultTitle
        self.message = message

        self.consultationGetter = consultation
        self.isFromPayments = isFromPayments
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        view.addSubview(visualEffect)
        view.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(resultLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(resultButton)
        
        if(isFromPayments){
            contentView.addSubview(cancelButton)
        }
        
        loadContents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        loadContents()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        loadContents()
    }
    
    func loadContents() {
        loadVisualEffects()
        loadContentView()
        loadImageView()
        loadResultLabel()
        loadMessageLabel()
        loadResultButton()
        
        if(isFromPayments){
            loadCancelButton()
        }
    }
    
    private func addTapGesture(toView: UIView){
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == visualEffect){
            tapGesture.addTarget(self, action: #selector(didTapDissmissView))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapDissmissView(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    func loadVisualEffects() {
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            visualEffect.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffect.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            visualEffect.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            visualEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        var widthAnchor: NSLayoutConstraint?
        var heightAnchor: NSLayoutConstraint?
        
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
            widthAnchor = contentView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        }
        else{
            widthAnchor = contentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        }
        
        if(view.frame.height > 800){
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                heightAnchor = contentView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45)
            }
            else{
                heightAnchor = contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45)
            }
        }
        else{
            heightAnchor = contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58)
        }
        
        guard let widthAnchor = widthAnchor,
              let heightAnchor = heightAnchor else {
            return
        }
        
        let constraints = [
            widthAnchor,
            heightAnchor,
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        contentView.layer.cornerRadius = 40
    }
    
    func loadImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 20
        
        if(isSuccess){
            imageView.image = UIImage(named: "Appointment Success")
        }
        else{
            imageView.image = UIImage(named: "Appointment Failure")
        }
        
        let constraints = [
            imageView.bottomAnchor.constraint(equalTo: resultLabel.topAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadResultLabel() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        resultLabel.text = resultTitle
        
        if(isSuccess){
            resultLabel.textColor = .systemBlue
        }
        else{
            resultLabel.textColor = UIColor(red: 255/255, green: 102/255, blue: 125/255, alpha: 1)
        }
        
        let constraints = [
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.text = message
        
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: resultLabel.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadResultButton() {
        resultButton.translatesAutoresizingMaskIntoConstraints = false
        
        if(isSuccess){
            resultButton.setTitle("View Appointment", for: .normal)
        }
        else{
            resultButton.setTitle("Try Again", for: .normal)
        }
        
        resultButton.addTarget(self, action: #selector(didTapViewAppointment), for: .touchUpInside)
        resultButton.setTitleColor(.white, for: .normal)
        
        let constraints = [
            resultButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            resultButton.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
            resultButton.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        if(!isFromPayments){
            let bottomAnchor = resultButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60)
            
            bottomAnchor.isActive = true
            
            previousConstraintsToDeActivate.append(bottomAnchor)
            resultButton.setTitle("Okay", for: .normal)
        }
    }
    
    func loadCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        let constraints = [
            cancelButton.topAnchor.constraint(equalTo: resultButton.bottomAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: resultButton.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: resultButton.trailingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    @objc func didTapViewAppointment(_ sender: UIButton) {
        
        if(isFromPayments){
            if(sender.title(for: .normal) == "View Appointment"){
                guard let consultataion = consultationGetter else {
                    return
                }
                
                let appointmentInfoVC = AppointmentInfoVC(consultation: consultataion, isFromPayment: true)
                appointmentInfoVC.delegateForSugue = self
                
                navigationController?.pushViewController(appointmentInfoVC, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    NotificationCenter.default.post(name: NSNotification.Name("Should-Reload-CollectionView"), object: nil)
                }
            }
            else{
                self.dismiss(animated: true)
            }
        }
        else{
            self.dismiss(animated: true)
            
            delegateForSegue?.segueToParent()
        }
    }
    
    @objc func didTapCancel(_ sender: UIButton) {
        self.dismiss(animated: true)
        delegateForSegue?.segueToParent()
        NotificationCenter.default.post(name: NSNotification.Name("Should-Reload-CollectionView"), object: nil)
    }
}

extension SuccessResultVC: SegueToParentProtocol {
    func segueToParent() {
        self.dismiss(animated: true)
        delegateForSegue?.segueToParent()
    }
}
