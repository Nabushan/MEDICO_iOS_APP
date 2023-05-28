//
//  PharmacyWriteAReviewVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 10/10/22.
//

import UIKit

class PharmacyWriteAReviewVC: UIViewController, PharmacyWriteAReviewProtocol {

    lazy var starButtonOne: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 1
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starButtonTwo: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 2
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starButtonThree: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 3
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starButtonFour: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 4
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starButtonFive: ResizedButton = {
        let button = ResizedButton()
        
        button.tag = 5
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
        
        button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        button.addTarget(self, action: #selector(didTapStarRatingButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var starStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.contentMode = .right
        
        return stackView
    }()
    
    lazy var emptyAllStarView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var fillAllStarView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var tapAStarToRateLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        
        return label
    }()
    
    lazy var tapAStarToRateLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Title"
        
        return textField
    }()
    
    lazy var reviewTextView: UITextView = {
        let reviewTextView = UITextView()
        
        reviewTextView.text = "Review (Optional)"
        reviewTextView.contentMode = .topLeft
        reviewTextView.textColor = .secondaryLabel
        reviewTextView.font = .systemFont(ofSize: 15, weight: .light)
        
        return reviewTextView
    }()
    
    lazy var titleLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.timeZone = .current
        
        formatter.dateFormat = "MMM d, yyyy"
        
        return formatter
    }()
    
    var starsToFillFromAlertView: Int = 0
    
    var reviewTextFieldBottomAnchor: NSLayoutConstraint?
    
    var starButtonArray: [ResizedButton] = []
    var alertStarButtons: [ResizedButton] = []
    
    var isRated: Bool = false
    var isAlertViewRated: Bool = false
    var previousSelectedStars: Int
    var pharmacyReviewId: Int = 0
    var isAlreadyReviewed: Bool = false
    var review: Reviews? = nil
    
    var userReviewText: String = ""
    var sendBarButton = UIBarButtonItem()
    
    let pharmacyWriteAReviewHelperVC: PharmacyWriteAReviewHelperVC
    
    init(previouslyFilledStars: Int, pharmacyReviewId: Int) {
        self.previousSelectedStars = previouslyFilledStars
        self.pharmacyReviewId = pharmacyReviewId
        if(previouslyFilledStars > 0){
            isRated = true
        }
        pharmacyWriteAReviewHelperVC = PharmacyWriteAReviewHelperVC()
        
        super.init(nibName: nil, bundle: nil)
        pharmacyWriteAReviewHelperVC.delegate = self
        
        print("Previeusly filled Stars : ", previouslyFilledStars)
    }
    
    init(review: Reviews, previouslyFilledStars: Int, pharmacyReviewId: Int) {
        self.previousSelectedStars = previouslyFilledStars
        self.pharmacyReviewId = pharmacyReviewId
        if(previouslyFilledStars > 0){
            isRated = true
        }
        pharmacyWriteAReviewHelperVC = PharmacyWriteAReviewHelperVC()
        
        super.init(nibName: nil, bundle: nil)
        pharmacyWriteAReviewHelperVC.delegate = self
        isAlreadyReviewed = true
        self.review = review
        
        print("Previeusly filled Stars : ", previouslyFilledStars)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        if(isAlreadyReviewed){
            self.title = "Edit Review"
        }
        else{
            self.title = "Write a Review"
        }
        
        sendBarButton = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(didTapSend))
        
        view.addSubview(emptyAllStarView)
        view.addSubview(starStackView)
        starStackView.addArrangedSubview(starButtonOne)
        starStackView.addArrangedSubview(starButtonTwo)
        starStackView.addArrangedSubview(starButtonThree)
        starStackView.addArrangedSubview(starButtonFour)
        starStackView.addArrangedSubview(starButtonFive)
        
        view.addSubview(fillAllStarView)
        view.addSubview(tapAStarToRateLabel)
        view.addSubview(tapAStarToRateLineView)
        view.addSubview(titleTextField)
        view.addSubview(titleLineView)
        view.addSubview(reviewTextView)
        
        setUpNavigationBarContents()
        configureDelegates()
        loadEmptyAllStarView()
        loadStarStackView()
        loadFillAllStarView()
        loadTapAStarToRateLabel()
        loadTapAStarToRateLineView()
        loadTitleTextField()
        loadTitleLineView()
        loadReviewTextField()
        
        starButtonArray = [starButtonOne, starButtonTwo, starButtonThree, starButtonFour, starButtonFive]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        fillNStars(previousSelectedStars)
        
        if(reviewTextView.text.count != 0){
            userReviewText = reviewTextView.text
        }
        
        sendBarButton.isEnabled = false
        
        if let _ = review {
            sendBarButton.isEnabled = true
        }
    }
    
    func setUpNavigationBarContents() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        self.navigationItem.rightBarButtonItem = sendBarButton
    }
    
    func configureDelegates() {
        titleTextField.delegate = self
        reviewTextView.delegate = self
    }
    
    func loadEmptyAllStarView() {
        emptyAllStarView.translatesAutoresizingMaskIntoConstraints = false
        
        emptyAllStarView.backgroundColor = view.backgroundColor
        
        addTapGesture(toView: emptyAllStarView)
        
        NSLayoutConstraint.activate([
            emptyAllStarView.topAnchor.constraint(equalTo: starStackView.topAnchor),
            emptyAllStarView.bottomAnchor.constraint(equalTo: starStackView.bottomAnchor),
            emptyAllStarView.trailingAnchor.constraint(equalTo: starStackView.leadingAnchor),
            emptyAllStarView.widthAnchor.constraint(equalToConstant: 0.15*view.frame.width),
        ])
    }
    
    func loadStarStackView() {
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            starStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    func loadFillAllStarView() {
        fillAllStarView.translatesAutoresizingMaskIntoConstraints = false
        
        fillAllStarView.backgroundColor = view.backgroundColor
        
        addTapGesture(toView: fillAllStarView)
        
        NSLayoutConstraint.activate([
            fillAllStarView.topAnchor.constraint(equalTo: starStackView.topAnchor),
            fillAllStarView.bottomAnchor.constraint(equalTo: starStackView.bottomAnchor),
            fillAllStarView.leadingAnchor.constraint(equalTo: starStackView.trailingAnchor),
            fillAllStarView.widthAnchor.constraint(equalToConstant: 0.15*view.frame.width),
        ])
    }
    
    func loadTapAStarToRateLabel() {
        tapAStarToRateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tapAStarToRateLabel.text = "Tap a Star to Rate"
        
        tapAStarToRateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        tapAStarToRateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            tapAStarToRateLabel.topAnchor.constraint(equalTo: starStackView.bottomAnchor,constant: -5),
            tapAStarToRateLabel.leadingAnchor.constraint(equalTo: starStackView.leadingAnchor),
            tapAStarToRateLabel.trailingAnchor.constraint(equalTo: starStackView.trailingAnchor)
        ])
    }
    
    func loadTapAStarToRateLineView() {
        tapAStarToRateLineView.translatesAutoresizingMaskIntoConstraints = false
        
        tapAStarToRateLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            tapAStarToRateLineView.topAnchor.constraint(equalTo: tapAStarToRateLabel.bottomAnchor),
            tapAStarToRateLineView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            tapAStarToRateLineView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            tapAStarToRateLineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func loadTitleTextField() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
    
        titleTextField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleTextField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        if(isAlreadyReviewed){
            titleTextField.text = review?.title
        }
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: tapAStarToRateLineView.bottomAnchor, constant: 10),
            titleTextField.leadingAnchor.constraint(equalTo: tapAStarToRateLineView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: tapAStarToRateLineView.trailingAnchor),
        ])
    }
    
    func loadTitleLineView() {
        titleLineView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            titleLineView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor,constant: 10),
            titleLineView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            titleLineView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            titleLineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    func loadReviewTextField() {
        reviewTextView.translatesAutoresizingMaskIntoConstraints = false
        
        if(isAlreadyReviewed){
            reviewTextView.text = review?.body
            
            if(reviewTextView.text == "This review was only rated with a title.") {
                reviewTextView.text = "Review (Optional)"
            }
        }
        
        NSLayoutConstraint.activate([
            reviewTextView.topAnchor.constraint(equalTo: titleLineView.bottomAnchor,constant: 10),
            reviewTextView.leadingAnchor.constraint(equalTo: titleLineView.leadingAnchor),
            reviewTextView.trailingAnchor.constraint(equalTo: titleLineView.trailingAnchor),
        ])
        
        reviewTextFieldBottomAnchor = reviewTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        
        NSLayoutConstraint.activate([
            reviewTextFieldBottomAnchor!
        ])
    }
    
    @objc func didTapCancel(_ sender: UIBarButtonItem) {
        print("Write a Review Cancel Tapped")
        self.dismiss(animated: true)
    }
    
    func writeTheUserGivenReview() {
        var review: Reviews?
        if(titleTextField.text?.count ?? 0 > 0){
            
            if(reviewTextView.text == "Review (Optional)") {
                userReviewText = "This review was only rated with a title."
            }
            
            review = Reviews(
                id: pharmacyReviewId,
                title: titleTextField.text ?? "",
                body: userReviewText,
                numberOfRatingStars: previousSelectedStars,
                dateOfReview: formatter.string(from: Date.now),
                reviewerName: UserDefaults.standard.string(forKey: "User - Name") ?? "Unknown",
                category: .pharmacy)
        }
        
        guard let review = review else {
            return
        }
        
        if(isAlreadyReviewed == false){
            pharmacyWriteAReviewHelperVC.addReviewToReviewDB(review)
            
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_ReviewAdded"), object: nil)
        }
        else{
            pharmacyWriteAReviewHelperVC.updateReview(for: UserDefaults.standard.string(forKey: "User - Name") ?? "", to: review, forPharmacyId: pharmacyReviewId)
            
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_ReviewAdded"), object: nil)
        }
    }
    
    @objc func didTapSend(_ sender: UIBarButtonItem) {
        print("Write a Review Send Tapped")
        
        if(isRated && titleTextField.text?.count != 0){
            writeTheUserGivenReview()
            
            var ratedAlertView = UIAlertController(
                title: "Review Status",
                message: "Your review has been sent",
                preferredStyle: .alert)
            
            if(self.isAlreadyReviewed){
                ratedAlertView = UIAlertController(
                    title: "Review Status",
                    message: "Your review has been updated",
                    preferredStyle: .alert)
            }
            
            ratedAlertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak self] _ in
                self?.dismiss(animated: true)
            }))
            
            let userInfo = ["userSelectedStarRating" : previousSelectedStars]
            
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_StarRating"), object: nil, userInfo: userInfo)
            
            present(ratedAlertView, animated: true)
        }
        else if(titleTextField.text?.count == 0){
            let alertView = UIAlertController(title: "Empty Title", message: "Please fill the title field to send your review", preferredStyle: .alert)
            
            alertView.addAction(UIAlertAction(title: "Write", style: .cancel))
            
            present(alertView, animated: true)
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
            
            yetToRateAlertView.addAction(UIAlertAction(title: "Rate", style: .cancel, handler: { [weak self] _ in
                
                if(self?.isAlertViewRated == true){
                    self?.fillNStars(self?.starsToFillFromAlertView ?? 0)
                    
                    self?.previousSelectedStars = self?.starsToFillFromAlertView ?? 0
                    
                    let userInfo = ["userSelectedStarRating" : self?.starsToFillFromAlertView]
                    
                    self?.writeTheUserGivenReview()
                    
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_StarRating"), object: nil, userInfo: userInfo as [AnyHashable : Any])
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self?.dismiss(animated: true)
                    }
                }
                
            }))
            
            present(yetToRateAlertView, animated: true)
        }
    }
    
    @objc func didTapEmptyAllStarsView(_ sender: UITapGestureRecognizer) {
        resetButtons()
        isRated = false
        
        let userInfo = ["userSelectedStarRating" : 0]
        
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_StarRating"), object: nil, userInfo: userInfo)
    }
    
    @objc func didTapFillAllStarsView(_ sender: UITapGestureRecognizer) {
        for button in starButtonArray {
            let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
            button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        }
        isRated = true
        
        let userInfo = ["userSelectedStarRating" : 5]
        
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier_StarRating"), object: nil, userInfo: userInfo)
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == emptyAllStarView){
            tapGesture.addTarget(self, action: #selector(didTapEmptyAllStarsView))
        }
        else if(toView == fillAllStarView){
            tapGesture.addTarget(self, action: #selector(didTapFillAllStarsView))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    func resetButtons() {
        for button in starButtonArray {
            let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
            button.setImage(image?.withTintColor(.systemBlue), for: .normal)
        }
    }
    
    func fillNStars(_ value: Int){
        for index in 0..<starButtonArray.count {
            if(index < value){
                let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
                starButtonArray[index].setImage(image?.withTintColor(.systemBlue), for: .normal)
            }
            else{
                let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
                starButtonArray[index].setImage(image?.withTintColor(.systemBlue), for: .normal)
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
    
    @objc func didTapStarRatingButton(_ sender: UIButton) {
        print(sender.tag)
        resetButtons()
        isRated = true
        
        for button in starButtonArray {
            if(button.tag <= sender.tag){
                let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
                button.setImage(image?.withTintColor(.systemBlue), for: .normal)
            }
        }
        
        previousSelectedStars = sender.tag
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            NSLayoutConstraint.deactivate([
                reviewTextFieldBottomAnchor!
            ])
            
            reviewTextFieldBottomAnchor = reviewTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(keyboardSize.height + 15))
            
            NSLayoutConstraint.activate([
                reviewTextFieldBottomAnchor!
            ])
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        NSLayoutConstraint.deactivate([
            reviewTextFieldBottomAnchor!
        ])
        
        reviewTextFieldBottomAnchor = reviewTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        
        NSLayoutConstraint.activate([
            reviewTextFieldBottomAnchor!
        ])
    }
}

extension PharmacyWriteAReviewVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if(textField.text?.count != 0) {
            sendBarButton.isEnabled = true
        }
        else {
            sendBarButton.isEnabled = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
        
        if(textField == titleTextField){
            if(textField.text?.count != 0) {
                sendBarButton.isEnabled = true
            }
            else{
                sendBarButton.isEnabled = false
            }
        }
    }
}

extension PharmacyWriteAReviewVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        userReviewText = textView.text
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text == "Review (Optional)") {
            textView.text = ""
        }
                
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView == reviewTextView && textView.text.count == 0){
            textView.text = "Review (Optional)"
        }
        
        self.view.frame.origin.y = 0
        textView.resignFirstResponder()
    }
}
