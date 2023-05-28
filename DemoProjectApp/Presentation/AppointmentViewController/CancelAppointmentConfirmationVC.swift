//
//  CancelAppointmentVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/10/22.
//

import UIKit

class CancelAppointmentConfirmationVC: UIViewController, UISheetPresentationControllerDelegate {
    
    lazy var cancelAppointmentLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .systemRed
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var appointmentLabelOne: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var appointmentLabelTwo: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var upperLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var bottomLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    lazy var leftButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = UIColor(red: 233/255, green: 240/255, blue: 255/255, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        
        return button
    }()
    
    lazy var rightButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Yes, Cancel", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        
        return button
    }()
    
    var initialOrigin: CGPoint?
    
    weak var delegate: AppointmentCancellingProtocol?
    var consultation: ConsultationGetter
    
    override var sheetPresentationController: UISheetPresentationController {
        (presentationController as? UISheetPresentationController)!
    }
    
    init(_ consultation: ConsultationGetter) {
        self.consultation = consultation
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        view.addSubview(contentView)
        
        contentView.addSubview(cancelAppointmentLabel)
        contentView.addSubview(upperLineView)
        contentView.addSubview(appointmentLabelOne)
        contentView.addSubview(appointmentLabelTwo)
        contentView.addSubview(bottomLineView)
        contentView.addSubview(leftButton)
        contentView.addSubview(rightButton)
        
        configureDelegates()
        loadContents()
    }
    
    func loadContents() {
        loadContentView()
        loadCancelAppointmentLabel()
        loadUpperLineView()
        loadAppointmentOne()
        loadAppointmentTwo()
        loadBottomLineView()
        loadLeftButton()
        loadRightButton()
    }
    
    func configureDelegates() {
        let smallId = UISheetPresentationController.Detent.Identifier("small")
        if #available(iOS 16.0, *) {
            let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
                return 310
            }
            sheetPresentationController.delegate = self
            sheetPresentationController.detents = [smallDetent]
            sheetPresentationController.preferredCornerRadius = 10
            sheetPresentationController.prefersGrabberVisible = true
        } else {
            sheetPresentationController.delegate = self
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.preferredCornerRadius = 10
            sheetPresentationController.prefersGrabberVisible = true
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
    
    func loadCancelAppointmentLabel() {
        cancelAppointmentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cancelAppointmentLabel.text = "Cancel Appointment"
        
        NSLayoutConstraint.activate([
            cancelAppointmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cancelAppointmentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cancelAppointmentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
    func loadUpperLineView() {
        upperLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            upperLineView.topAnchor.constraint(equalTo: cancelAppointmentLabel.bottomAnchor, constant: 20),
            upperLineView.leadingAnchor.constraint(equalTo: cancelAppointmentLabel.leadingAnchor),
            upperLineView.trailingAnchor.constraint(equalTo: cancelAppointmentLabel.trailingAnchor),
            upperLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        upperLineView.layer.cornerRadius = 1/2
    }
    
    func loadAppointmentOne() {
        appointmentLabelOne.translatesAutoresizingMaskIntoConstraints = false
        
        appointmentLabelOne.text = "Are you sure you want to cancel our appointment?"
        
        NSLayoutConstraint.activate([
            appointmentLabelOne.topAnchor.constraint(equalTo: upperLineView.bottomAnchor, constant: 20),
            appointmentLabelOne.leadingAnchor.constraint(equalTo: upperLineView.leadingAnchor),
            appointmentLabelOne.trailingAnchor.constraint(equalTo: upperLineView.trailingAnchor),
        ])
    }
    
    func loadAppointmentTwo() {
        appointmentLabelTwo.translatesAutoresizingMaskIntoConstraints = false
        
        appointmentLabelTwo.text = "Only 50% of the funds will be returned to your account."
        
        NSLayoutConstraint.activate([
            appointmentLabelTwo.topAnchor.constraint(equalTo: appointmentLabelOne.bottomAnchor, constant: 20),
            appointmentLabelTwo.leadingAnchor.constraint(equalTo: appointmentLabelOne.leadingAnchor),
            appointmentLabelTwo.trailingAnchor.constraint(equalTo: appointmentLabelOne.trailingAnchor),
        ])
    }
    
    func loadBottomLineView() {
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomLineView.topAnchor.constraint(equalTo: appointmentLabelTwo.bottomAnchor, constant: 20),
            bottomLineView.leadingAnchor.constraint(equalTo: appointmentLabelTwo.leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: appointmentLabelTwo.trailingAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        bottomLineView.layer.cornerRadius = 1/2
    }
    
    func loadLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: bottomLineView.bottomAnchor, constant: 20),
            leftButton.leadingAnchor.constraint(equalTo: bottomLineView.leadingAnchor),
            leftButton.widthAnchor.constraint(equalTo: bottomLineView.widthAnchor, multiplier: 0.47),
        ])
        
        leftButton.layer.cornerRadius = leftButton.intrinsicContentSize.height / 2
    }
    
    func loadRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        rightButton.addTarget(self, action: #selector(didTapConfirmCancel), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            rightButton.topAnchor.constraint(equalTo: leftButton.topAnchor),
            rightButton.trailingAnchor.constraint(equalTo: bottomLineView.trailingAnchor),
            rightButton.widthAnchor.constraint(equalTo: leftButton.widthAnchor)
        ])
        
        rightButton.layer.cornerRadius = rightButton.intrinsicContentSize.height / 2
    }
    
    @objc func didTapConfirmCancel(_ sender: UIButton) {
        print("Showing Confirm Cancel reason.")
        delegate?.hideTabBar()
        self.dismiss(animated: true)
        delegate?.showCancelReason(consultation)
    }
    
    @objc func didTapBack(_ sender: UIButton) {
        print("Back button tapped")
        
        self.dismiss(animated: true)
    }
}
