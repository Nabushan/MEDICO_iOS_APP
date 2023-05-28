//
//  CancelAppointmentVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 30/10/22.
//

import UIKit

class ChangeAppointmentVC: UIViewController {
    
    var consultation: ConsultationGetter
    var shouldCancel: Bool?
    
    let cancelReasons: [String] = [
        "I want to change to another doctor",
        "I want to change the package",
        "I don't want to consult",
        "I have recovered from the disease",
        "I have found a suitable medicine",
        "I just want to cancel",
        "I just don't want to tell",
        "others"
    ]
    
    let rescheduleReasons: [String] = [
        "I'm having a schedule clash",
        "I'm not available on schedule",
        "I have an activity that can't be left behind",
        "I don't want to tell",
        "others"
    ]
    
    weak var delegate: AppointmentCancellingProtocol?
    
    lazy var reasonHeaderLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    lazy var reasonCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(ChangeAppointmentCollectionViewCell.self, forCellWithReuseIdentifier: ChangeAppointmentCollectionViewCell.identifier)
        
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    lazy var otherReasonTextView: UITextView = {
        let textView = UITextView()
        
        textView.keyboardType = .alphabet
        
        return textView
    }()
    
    lazy var submitButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Submit", for: .normal)
        
        return button
    }()
    
    let validator = Validators()
    var contents: [String] = []
    var previouslySelectedCell: ChangeAppointmentCollectionViewCell?
    var isOtherReasonTextPresent: Bool = false
    var isFromPayment: Bool = false
    
    init(_ consultation: ConsultationGetter, shouldCancel: Bool, isFromPayment: Bool) {
        self.consultation = consultation
        self.shouldCancel = shouldCancel
        self.isFromPayment = isFromPayment
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor

        view.addSubview(reasonHeaderLabel)
        view.addSubview(reasonCollectionView)
        view.addSubview(otherReasonTextView)
        view.addSubview(submitButton)
        
        if(shouldCancel ?? false){
            self.title = "Cancel Appointment"
        }
        else{
            self.title = "Reschedule Appointment"
        }
        
        configureDelegates()
        loadContents()
    }
    
    func configureDelegates() {
        reasonCollectionView.delegate = self
        reasonCollectionView.dataSource = self
        
        otherReasonTextView.delegate = self
    }
    
    func loadContents() {
        loadReasonHeaderLabel()
        loadReasonCollectionView()
        loadOtherReasonTextView()
        loadSubmitButton()
    }
    
    func loadReasonHeaderLabel() {
        reasonHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        reasonHeaderLabel.text = "Reason for Schedule Change"
        
        NSLayoutConstraint.activate([
            reasonHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            reasonHeaderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            reasonHeaderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }
    
    func loadReasonCollectionView() {
        reasonCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        var count = 0
        
        if(shouldCancel ?? false){
            count = cancelReasons.count
        }
        else{
            count = rescheduleReasons.count
        }
        
        NSLayoutConstraint.activate([
            reasonCollectionView.topAnchor.constraint(equalTo: reasonHeaderLabel.bottomAnchor, constant: 5),
            reasonCollectionView.leadingAnchor.constraint(equalTo: reasonHeaderLabel.leadingAnchor),
            reasonCollectionView.trailingAnchor.constraint(equalTo: reasonHeaderLabel.trailingAnchor),
            reasonCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(count * 40))
        ])
    }
    
    func loadOtherReasonTextView(){
        otherReasonTextView.translatesAutoresizingMaskIntoConstraints = false
        
        otherReasonTextView.backgroundColor = .secondarySystemBackground
        otherReasonTextView.layer.cornerRadius = 10
        otherReasonTextView.alpha = 0
        
        NSLayoutConstraint.activate([
            otherReasonTextView.topAnchor.constraint(equalTo: reasonCollectionView.bottomAnchor, constant: 5),
            otherReasonTextView.leadingAnchor.constraint(equalTo: reasonCollectionView.leadingAnchor),
            otherReasonTextView.trailingAnchor.constraint(equalTo: reasonCollectionView.trailingAnchor),
            otherReasonTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
    
    func loadSubmitButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.backgroundColor = .systemBlue
        
        submitButton.isEnabled = false
        submitButton.alpha = 0.3
        
        submitButton.layer.cornerRadius = 10
        
        var bottomPadding = view.safeAreaInsets.bottom
        
        if(view.frame.height > 750) {
            bottomPadding+=10
        }
        
        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomPadding + 20)),
            submitButton.leadingAnchor.constraint(equalTo: reasonCollectionView.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: reasonCollectionView.trailingAnchor)
        ])
        
        if(shouldCancel == false){
            submitButton.setTitle("Next", for: .normal)
        }
    }
    
    @objc func didTapSubmitButton(_ sender: UIButton) {
        if(isOtherReasonTextPresent){
            if(!validator.isContentValid(otherReasonTextView.text) && otherReasonTextView.text.count != 0) {
                let alertViewController = UIAlertController(title: "Invalid Content Entered", message: "Please make sure that the content entered is Valid", preferredStyle: .alert)
                
                alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
                
                present(alertViewController, animated: true)
                
                return
            }
            else if(otherReasonTextView.text.count == 0){
                let alertViewController = UIAlertController(title: "Description Not Entered", message: "Other option description is not entered please enter a valid description to continue.", preferredStyle: .alert)
                
                alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
                
                present(alertViewController, animated: true)
                
                return
            }
        }
        
        if previouslySelectedCell != nil, shouldCancel == true {
            let successVC = SuccessResultVC(isSuccess: true, resultTitle: "Cancel Appointment Success!", message: "We are very sad that that you have cancelled your appointment. We will always improve our service to satisfy you in the next appointment", consultation: consultation, isFromPayments: false)
            
            successVC.delegateForSegue = self
            
            present(successVC, animated: true)
        }
        else if previouslySelectedCell != nil, shouldCancel == false {
            
            let bookAppointmentsVC = BookAppointmentVC(consultation)
            
            navigationController?.pushViewController(bookAppointmentsVC, animated: true)
        }
        else{
            let alertViewController = UIAlertController(title: "Option Not Selected", message: "Please make sure that you have selected an option", preferredStyle: .alert)
            
            alertViewController.addAction(UIAlertAction(title: "Okay", style: .default))
            
            present(alertViewController, animated: true)
        }
    }
}

extension ChangeAppointmentVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(shouldCancel ?? false){
            return cancelReasons.count
        }
        else{
            return rescheduleReasons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(shouldCancel ?? false){
            contents = cancelReasons
        }
        else{
            contents = rescheduleReasons
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChangeAppointmentCollectionViewCell.identifier, for: indexPath) as? ChangeAppointmentCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = contents[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var contents: [String] = []
        
        if(shouldCancel ?? false){
            contents = cancelReasons
        }
        else{
            contents = rescheduleReasons
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChangeAppointmentCollectionViewCell else {
            return
        }
        
        if(previouslySelectedCell == nil){
            previouslySelectedCell = cell
            previouslySelectedCell?.isCellSelected(true)
        }
        else{
            previouslySelectedCell?.isCellSelected(false)
            previouslySelectedCell = cell
            previouslySelectedCell?.isCellSelected(true)
        }
        
//        if(shouldCancel ?? false){
            if(cell.label.text == contents[contents.count - 1]){
                otherReasonTextView.alpha = 1
                isOtherReasonTextPresent = true
            }
            else{
                otherReasonTextView.alpha = 0
                otherReasonTextView.resignFirstResponder()
                isOtherReasonTextPresent = false
            }
//        }
        
        submitButton.isEnabled = true
        submitButton.alpha = 1
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}

extension ChangeAppointmentVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}

extension ChangeAppointmentVC: SegueToParentProtocol {
    func segueToParent() {
        delegate?.confirmCancelAppointment(consultation)
        
        if(isFromPayment) {
            guard let vc = self.navigationController?.viewControllers.filter({$0 is AppointmentInfoVC}).first else {
                return
            }
            
            self.navigationController?.popToViewController(vc, animated: true)
        }
        else {
            guard let vc = self.navigationController?.viewControllers.filter({$0 is AppointmentsListVC}).first else {
                return
            }
            
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
}

extension ChangeAppointmentVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
}
