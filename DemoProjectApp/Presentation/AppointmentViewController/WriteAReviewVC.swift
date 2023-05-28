//
//  WriteAReviewVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 01/11/22.
//

import UIKit

class WriteAReviewVC: UIViewController, WriteAReviewProtocol {
    
    let doctorImage: String
    let doctorName: String
    let doctorId: Int
    
    lazy var viewForImage: UIView = {
        let view = UIView()
        
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    lazy var doctorImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.downloaded(from: doctorImage)
        
        return imageView
    }()
    
    lazy var doctorLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.text = "How was your experience with \(doctorName)?"
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.contentMode = .center
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy var starOne: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 1
        button.setImage(notSelectedStar, for: .normal)
        
        return button
    }()
    
    lazy var starTwo: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 2
        button.setImage(notSelectedStar, for: .normal)
        
        return button
    }()
    
    lazy var starThree: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 3
        button.setImage(notSelectedStar, for: .normal)
        
        return button
    }()
    
    lazy var starFour: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 4
        button.setImage(notSelectedStar, for: .normal)
        
        return button
    }()
    
    lazy var starFive: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 5
        button.setImage(notSelectedStar, for: .normal)
        
        return button
    }()
    
    lazy var leftView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0.2*view.frame.width, height: starOne.frame.height))
        
        return view
    }()
    
    lazy var rightView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0.2*view.frame.width, height: starOne.frame.height))
        
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .secondarySystemBackground
        
        return view
    }()
    
    lazy var writeYourReviewLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.text = "Write Your Review"
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        
        textView.keyboardType = .alphabet
        textView.returnKeyType = .default
        textView.font = UIFont(name: "Helvetica", size: 15)
        
        return textView
    }()
    
    lazy var cancelButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Cancel", for: .normal)
        
        return button
    }()
    
    lazy var submitButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Submit", for: .normal)
        
        return button
    }()
    
    lazy var recomendationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.text = "Would you recommend \(doctorName) to your friends?"
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy var yesView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var yesImageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .secondarySystemBackground
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.image = notSelectedRadioButton
        
        return view
    }()
    
    lazy var yesLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.text = "Yes"
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy var noView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var noImageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .secondarySystemBackground
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.image = notSelectedRadioButton
        
        return view
    }()
    
    lazy var noLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.text = "No"
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy var importantLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.text = "*"
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.dateFormat = "dd-MM-yyyy"
        
        return formatter
    }()
    
    var buttons: [ResizedButton] = []
    let notSelectedStar = UIImage(systemName: "star")
    let selectedStar = UIImage(systemName: "star.fill")
    var selectedRatings = 0
    let notSelectedRadioButton = UIImage(systemName: "circle")
    let selectedRadioButton = UIImage(systemName: "circle.circle.fill")
    
    var isRated: Bool = false
    var isRecommended: Bool = false
    let validator = Validators()
    let writeAReviewHelper: WriteAReviewHelper
    
    var isFromSplitView: Bool = false
    
    var isAlertViewRated = false
    var starsToFillFromAlertView = 0
    var alertStarButtons: [UIButton] = []
    
    init(doctorImage: String, doctorName: String, doctorId: Int, isFromSplitView: Bool) {
        self.doctorName = doctorName
        self.doctorImage = doctorImage
        self.doctorId = doctorId
        writeAReviewHelper = WriteAReviewHelper(doctorId: doctorId)
        self.isFromSplitView = isFromSplitView
        
        super.init(nibName: nil, bundle: nil)
        
        writeAReviewHelper.delegate = self
        writeAReviewHelper.doctorName = doctorName
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Write a Review"
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        view.addSubview(viewForImage)
        viewForImage.addSubview(doctorImageView)
        view.addSubview(doctorLabel)
    
        view.addSubview(stackView)
        stackView.addArrangedSubview(leftView)
        stackView.addArrangedSubview(starOne)
        stackView.addArrangedSubview(starTwo)
        stackView.addArrangedSubview(starThree)
        stackView.addArrangedSubview(starFour)
        stackView.addArrangedSubview(starFive)
        stackView.addArrangedSubview(rightView)
        
        view.addSubview(importantLabel)
        view.addSubview(lineView)
        view.addSubview(writeYourReviewLabel)
        view.addSubview(reviewTextView)
        view.addSubview(recomendationLabel)
        view.addSubview(yesView)
        yesView.addSubview(yesImageView)
        yesView.addSubview(yesLabel)
        view.addSubview(noView)
        noView.addSubview(noImageView)
        noView.addSubview(noLabel)
        view.addSubview(cancelButton)
        view.addSubview(submitButton)
        
        loadContents()
        
        reviewTextView.delegate = self
        buttons = [starOne, starTwo, starThree, starFour, starFive]
        
        addButtonTargets(forButtons: buttons)
        addTapGesture(toView: leftView)
        addTapGesture(toView: rightView)
        addTapGesture(toView: yesView)
        addTapGesture(toView: noView)
    }
    
    @objc func keyBoardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - 50
            }
        }
    }
    
    @objc func keyBoardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    func loadContents() {
        loadViewForImage()
        loadDoctorImageView()
        loadDoctorLabel()
        loadStackView()
        loadImportantLabel()
        loadLineView()
        loadWriteYourReviewLabel()
        loadReviewTextView()
        loadRecommendationLabel()
        loadYesView()
        loadYesImageView()
        loadYesLabel()
        loadNoView()
        loadNoImageView()
        loadNoLabel()
        loadCancelButton()
        loadSubmitButton()
        
        addTapGesture(toView: self.view)
        addTapGesture(toView: writeYourReviewLabel)
        addTapGesture(toView: lineView)
        addTapGesture(toView: recomendationLabel)
    }
    
    func loadViewForImage() {
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewForImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            viewForImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            viewForImage.heightAnchor.constraint(equalTo: viewForImage.widthAnchor),
            viewForImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        viewForImage.layer.cornerRadius = (0.4*view.frame.width)/2
    }
    
    func loadDoctorImageView() {
        doctorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doctorImageView.topAnchor.constraint(equalTo: viewForImage.topAnchor, constant: 5),
            doctorImageView.leadingAnchor.constraint(equalTo: viewForImage.leadingAnchor, constant: 5),
            doctorImageView.trailingAnchor.constraint(equalTo: viewForImage.trailingAnchor, constant: -5),
            doctorImageView.bottomAnchor.constraint(equalTo: viewForImage.bottomAnchor, constant: -5),
        ])
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            doctorImageView.layer.cornerRadius = 30
        }
        else{
            doctorImageView.layer.cornerRadius = ((0.4*view.frame.width) - 10)/2
        }
    }
    
    func loadDoctorLabel() {
        doctorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doctorLabel.topAnchor.constraint(equalTo: doctorImageView.bottomAnchor, constant: 5),
            doctorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            doctorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    func loadStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: doctorLabel.bottomAnchor, constant: 5),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func loadImportantLabel() {
        importantLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            importantLabel.centerYAnchor.constraint(equalTo: starFive.topAnchor, constant: 5),
            importantLabel.leadingAnchor.constraint(equalTo: starFive.trailingAnchor)
        ])
    }
    
    func addButtonTargets(forButtons: [ResizedButton]) {
        for button in forButtons {
            button.addTarget(self, action: #selector(didTapStarButton), for: .touchUpInside)
        }
    }
    
    func resetButtons() {
        isRated = false
        for button in buttons {
            button.setImage(notSelectedStar, for: .normal)
        }
        
        selectedRatings = 0
        print("Selected Stars: \(selectedRatings)")
    }
    
    func fillNStars(_ number: Int) {
        if(number <= 5){
            isRated = true
            for index in 0..<number {
                buttons[index].setImage(selectedStar, for: .normal)
            }
            
            selectedRatings = number
            print("Selected Stars: \(selectedRatings)")
        }
    }
    
    @objc func fillAllStars(_ sender: UITapGestureRecognizer) {
        isRated = true
        for button in buttons {
            button.setImage(selectedStar, for: .normal)
        }
        
        selectedRatings = 5
        print("Selected Stars: \(selectedRatings)")
    }
    
    @objc func emptyAllStars(_ sender: UITapGestureRecognizer) {
        isRated = false
        resetButtons()
    }
    
    func addTapGesture(toView: UIView){
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == leftView) {
            tapGesture.addTarget(self, action: #selector(emptyAllStars))
        }
        else if(toView == rightView) {
            tapGesture.addTarget(self, action: #selector(fillAllStars))
        }
        else if(toView == yesView || toView == noView) {
            tapGesture.addTarget(self, action: #selector(didTapRadioButton))
        }
        else if(toView == self.view || toView == writeYourReviewLabel || toView == lineView || toView == recomendationLabel) {
            tapGesture.addTarget(self, action: #selector(didTapOutsideToDismissKeyboard))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapOutsideToDismissKeyboard(_ sender: UITapGestureRecognizer) {
        reviewTextView.resignFirstResponder()
    }
    
    @objc func didTapRadioButton(_ sender: UITapGestureRecognizer) {
        isRecommended = true
        guard let view = sender.view else {
            return
        }
        
        if(view == yesView) {
            noImageView.image = notSelectedRadioButton
            yesImageView.image = selectedRadioButton
        }
        else{
            yesImageView.image = notSelectedRadioButton
            noImageView.image = selectedRadioButton
        }
    }
    
    @objc func didTapStarButton(_ sender: UIButton) {
        resetButtons()
        isRated = true
        for button in buttons {
            if(button.tag <= sender.tag){
                button.setImage(selectedStar, for: .normal)
            }
        }
        
        selectedRatings = sender.tag
        print("Selected Stars: \(selectedRatings)")
    }
    
    func loadLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: doctorLabel.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: doctorLabel.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func loadWriteYourReviewLabel() {
        writeYourReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            writeYourReviewLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 5),
            writeYourReviewLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            writeYourReviewLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor)
        ])
    }
    
    func loadReviewTextView() {
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        
        reviewTextView.backgroundColor = .secondarySystemBackground
        reviewTextView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            reviewTextView.topAnchor.constraint(equalTo: writeYourReviewLabel.bottomAnchor, constant: 5),
            reviewTextView.leadingAnchor.constraint(equalTo: writeYourReviewLabel.leadingAnchor),
            reviewTextView.trailingAnchor.constraint(equalTo: writeYourReviewLabel.trailingAnchor),
            reviewTextView.bottomAnchor.constraint(equalTo: recomendationLabel.topAnchor, constant: -5)
        ])
    }
    
    func loadRecommendationLabel() {
        recomendationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            recomendationLabel.leadingAnchor.constraint(equalTo: reviewTextView.leadingAnchor),
            recomendationLabel.trailingAnchor.constraint(equalTo: reviewTextView.trailingAnchor),
            recomendationLabel.bottomAnchor.constraint(equalTo: yesView.topAnchor, constant: -5)
        ])
    }
    
    func loadYesView() {
        yesView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yesView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -30),
            yesView.leadingAnchor.constraint(equalTo: reviewTextView.leadingAnchor),
            yesView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            yesView.heightAnchor.constraint(equalTo: writeYourReviewLabel.heightAnchor)
        ])
    }
    
    func loadYesImageView() {
        yesImageView.translatesAutoresizingMaskIntoConstraints = false
        
        yesImageView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            yesImageView.leadingAnchor.constraint(equalTo: yesView.leadingAnchor),
            yesImageView.centerYAnchor.constraint(equalTo: yesView.centerYAnchor),
            yesImageView.heightAnchor.constraint(equalTo: yesView.heightAnchor),
            yesImageView.widthAnchor.constraint(equalTo: yesImageView.heightAnchor)
        ])
    }
    
    func loadYesLabel() {
        yesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yesLabel.centerYAnchor.constraint(equalTo: yesImageView.centerYAnchor),
            yesLabel.leadingAnchor.constraint(equalTo: yesImageView.trailingAnchor, constant: 5),
            yesLabel.trailingAnchor.constraint(equalTo: yesView.trailingAnchor, constant: -5)
        ])
    }
    
    func loadNoView() {
        noView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noView.bottomAnchor.constraint(equalTo: yesView.bottomAnchor),
            noView.leadingAnchor.constraint(equalTo: yesView.trailingAnchor, constant: 5),
            noView.widthAnchor.constraint(equalTo: yesView.widthAnchor),
            noView.heightAnchor.constraint(equalTo: yesView.heightAnchor)
        ])
    }
    
    func loadNoImageView() {
        noImageView.translatesAutoresizingMaskIntoConstraints = false

        noImageView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            noImageView.leadingAnchor.constraint(equalTo: noView.leadingAnchor),
            noImageView.centerYAnchor.constraint(equalTo: noView.centerYAnchor),
            noImageView.heightAnchor.constraint(equalTo: noView.heightAnchor),
            noImageView.widthAnchor.constraint(equalTo: noImageView.heightAnchor)
        ])
    }
    
    func loadNoLabel() {
        noLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noLabel.centerYAnchor.constraint(equalTo: noImageView.centerYAnchor),
            noLabel.leadingAnchor.constraint(equalTo: noImageView.trailingAnchor, constant: 5),
            noLabel.trailingAnchor.constraint(equalTo: noView.trailingAnchor, constant: -5)
        ])
    }
    
    func loadCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.backgroundColor = UIColor(red: 233/255, green: 240/255, blue: 255/255, alpha: 1)
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        var bottomPadding = view.safeAreaInsets.bottom
        
        if(view.frame.height > 750) {
            bottomPadding += 10
        }
        
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomPadding + 20)),
            cancelButton.leadingAnchor.constraint(equalTo: writeYourReviewLabel.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalTo: reviewTextView.widthAnchor, multiplier: 0.47)
        ])
        
        cancelButton.layer.cornerRadius = cancelButton.intrinsicContentSize.height / 2
    }
    
    func loadSubmitButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.backgroundColor = .systemBlue
        submitButton.addTarget(self, action: #selector(didTapSubmit), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor),
            submitButton.trailingAnchor.constraint(equalTo: writeYourReviewLabel.trailingAnchor),
            submitButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)
        ])
        
        submitButton.layer.cornerRadius = submitButton.intrinsicContentSize.height / 2
    }
    
    @objc func didTapCancel(_ sender: UIButton) {
        print("Cancel Tapped")
        
        navigationController?.popViewController(animated: true)
    }
    
    func showSuccessResultVC() {
        let successVC = SuccessResultVC(isSuccess: true, resultTitle: "Review Successful!", message: "Your review has been successfully submitted, thank you very much!", consultation: nil, isFromPayments: false)
        successVC.delegateForSegue = self
        
        self.present(successVC, animated: true)
    }
    
    @objc func didTapSubmit(_ sender: UIButton) {
        print("Submit Tapped")
        
        print(reviewTextView.text ?? "")
        
        if(isRated){
            let successVC = SuccessResultVC(isSuccess: true, resultTitle: "Review Successful!", message: "Your review has been successfully submitted, thank you very much!", consultation: nil, isFromPayments: false)
            successVC.delegateForSegue = self
            
            guard let rating = Rating(rawValue: selectedRatings),
                  let userName = UserDefaults.standard.string(forKey: "User - Name") else {
                return
            }
            
            var review = Reviews(id: doctorId,
                                 title: rating.doctorRatingDescription,
                                 body: "",
                                 numberOfRatingStars: selectedRatings,
                                 dateOfReview: formatter.string(from: Date.now),
                                 reviewerName: userName,
                                 category: .doctor)
            
            if(validator.isContentValid(reviewTextView.text ?? "")){
                review.body = reviewTextView.text ?? ""
            }
            
            writeAReviewHelper.addsNewRating(selectedRatings, userName: userName)
            writeAReviewHelper.addReview(review, userName: userName)
            
            present(successVC, animated: true)
        }
        else{
            
            let yetToRateAlertView = UIAlertController(title: "Please Rate", message: nil, preferredStyle: .alert)
            
            lazy var alertStackView = UIStackView()
            
            alertStarButtons = []
            
            for index in 1...5{
                let button = getAlertStarButtons()
                button.tag = index
                
                alertStackView.addArrangedSubview(button)
                alertStarButtons.append(button)
            }
            
            yetToRateAlertView.view.addSubview(alertStackView)
            
            alertStackView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                alertStackView.centerXAnchor.constraint(equalTo: yetToRateAlertView.view.centerXAnchor),
                alertStackView.centerYAnchor.constraint(equalTo: yetToRateAlertView.view.centerYAnchor),
            ])
            
            let height = NSLayoutConstraint(item: yetToRateAlertView.view ?? (Any).self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 150)

            yetToRateAlertView.view.addConstraints([
                height
            ])
            
            yetToRateAlertView.addAction(UIAlertAction(title: "Cancel", style: .default))
            
            yetToRateAlertView.addAction(UIAlertAction(title: "Rate", style: .default, handler: { [weak self] _ in
                
                if(self?.isAlertViewRated == true){
                    self?.fillNStars(self?.starsToFillFromAlertView ?? 0)
            
                    guard let rating = Rating(rawValue: self?.starsToFillFromAlertView ?? 0),
                          let userName = UserDefaults.standard.string(forKey: "User - Name"),
                          let doctorId = self?.doctorId,
                          let selectedRatings = self?.starsToFillFromAlertView,
                          let dateOfReview = self?.formatter.string(from: Date.now) else {
                        return
                    }
                    
                    var reviewText = ""
                    if(self?.reviewTextView.text.count == 0) {
                        reviewText = "This review is only rated."
                    }
                    else{
                        reviewText = self?.reviewTextView.text ?? ""
                    }
        
                    var review = Reviews(id: doctorId,
                                         title: rating.doctorRatingDescription,
                                         body: reviewText,
                                         numberOfRatingStars: selectedRatings,
                                         dateOfReview: dateOfReview,
                                         reviewerName: userName,
                                         category: .doctor)
                    
                    guard let boolFlag = self?.validator.isContentValid(self?.reviewTextView.text ?? "") else {
                        return
                    }
                    
                    if(boolFlag){
                        review.body = self?.reviewTextView.text ?? ""
                    }
                    
                    self?.writeAReviewHelper.addsNewRating(selectedRatings, userName: userName)
                    self?.writeAReviewHelper.addReview(review, userName: userName)
                    
                    self?.showSuccessResultVC()
                }
                
            }))
            
            present(yetToRateAlertView, animated: true)
        }
    }
    
    func loadRatingAndReviewIfAlreadyGiven() {
        guard let userName = UserDefaults.standard.string(forKey: "User - Name") else {
            return
        }
        
        for review in writeAReviewHelper.reviews {
            if(review.reviewerName == userName) {
                fillNStars(review.numberOfRatingStars)
                reviewTextView.text = review.body
                break
            }
        }
    }
    
    func getAlertStarButtons() -> ResizedButton {
        lazy var starButton: ResizedButton = {
            let button = ResizedButton()

            let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
            
            button.setImage(image?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1)), for: .normal)
            button.addTarget(self, action: #selector(didTapAlertStarButtons), for: .touchUpInside)
            
            return button
        }()
        
        return starButton
    }
    
    @objc func didTapAlertStarButtons(_ sender: UIButton){
        starsToFillFromAlertView = sender.tag
        isAlertViewRated = true
        for button in alertStarButtons {
            if(button.tag <= sender.tag){
                let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
                button.setImage(image?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1)), for: .normal)
            }
            else{
                let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
                button.setImage(image?.withTintColor(UIColor(red: 253/255, green: 130/255, blue: 4/255, alpha: 1)), for: .normal)
            }
        }
    }
}

extension WriteAReviewVC: UITextViewDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadRatingAndReviewIfAlreadyGiven()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}

extension WriteAReviewVC: SegueToParentProtocol {
    func segueToParent() {
        if(isFromSplitView){
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
