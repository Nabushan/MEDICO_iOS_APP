//
//  HelpCenterVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 12/12/22.
//

import UIKit
import MessageUI

class HelpCenterVC: UIViewController, HelpCenterProtocol, UINavigationControllerDelegate {
    
    lazy var faqLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.text = "FAQ's"
        label.font = UIFont(name: "Helvetica", size: 17)
        label.contentMode = .center
        label.textAlignment = .center
        label.numberOfLines =  1
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    lazy var contactUsLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.text = "Contact Us"
        label.font = UIFont(name: "Helvetica", size: 17)
        label.contentMode = .center
        label.textAlignment = .center
        label.numberOfLines =  1
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.contentMode = .center
        
        return stackView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray4
        
        return view
    }()
    
    lazy var selectorLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    var selectorLineViewHorizontalAnchor: NSLayoutConstraint?
    
    let helpCenterHelperVC: HelpCenterHelperVC
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        helpCenterHelperVC = HelpCenterHelperVC()
        
        super.init(nibName: nil, bundle: nil)
        
        helpCenterHelperVC.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectedLineWidth = CGFloat(0)
    var selectedLineViewWidthAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Help Center"
        
        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(faqLabel)
        stackView.addArrangedSubview(contactUsLabel)
        
        view.addSubview(lineView)
        view.addSubview(selectorLineView)
        view.addSubview(collectionView)
        
        selectedLineWidth = (view.frame.width - 30)/2
        
        addRightSwipeGesture(toView: collectionView)
        addLeftSwipeGesture(toView: collectionView)
        
        configureCollectionView()
        loadStackView()
        loadLineView()
        loadSelectorLineView()
        loadCollectionView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        selectedLineViewWidthAnchor?.isActive = false
        
        selectedLineWidth = (view.frame.width - 30)/2
        
        selectedLineViewWidthAnchor = selectorLineView.widthAnchor.constraint(equalToConstant: selectedLineWidth)
        
        selectedLineViewWidthAnchor?.isActive = true
        
        collectionView.reloadData()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(HelpCenterFAQCollectionViewCell.self,
                                forCellWithReuseIdentifier: HelpCenterFAQCollectionViewCell.identifier)
        
        collectionView.register(HelpCenterContactUsCollectionViewCell.self,
                                forCellWithReuseIdentifier: HelpCenterContactUsCollectionViewCell.identifier)
    }

    func loadStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
        
        addTapGesture(toView: faqLabel)
        addTapGesture(toView: contactUsLabel)
    }
    
    func loadLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func loadSelectorLineView() {
        selectorLineView.translatesAutoresizingMaskIntoConstraints = false
        
        selectedLineViewWidthAnchor = selectorLineView.widthAnchor.constraint(equalToConstant: selectedLineWidth)
        
        NSLayoutConstraint.activate([
            selectorLineView.centerYAnchor.constraint(equalTo: lineView.centerYAnchor),
            selectedLineViewWidthAnchor!,
            selectorLineView.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        loadSelectorLine()
    }
    
    func loadSelectorLine() {
        selectorLineViewHorizontalAnchor?.isActive = false
        
        switch helpCenterHelperVC.selectedState {
        case .faq:
            selectorLineViewHorizontalAnchor = selectorLineView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor)
            faqLabel.textColor = .systemBlue
            contactUsLabel.textColor = .label
        case .contactUS:
            selectorLineViewHorizontalAnchor = selectorLineView.trailingAnchor.constraint(equalTo: lineView.trailingAnchor)
            faqLabel.textColor = .label
            contactUsLabel.textColor = .systemBlue
        }
        
        selectorLineViewHorizontalAnchor?.isActive = true
    }
    
    func loadCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        var bottomConstant = view.safeAreaInsets.bottom
        
        if(view.frame.height > 750) {
            bottomConstant += 30
        }
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(bottomConstant))
        ])
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        
        if(toView == faqLabel || toView == contactUsLabel) {
            tapGesture.addTarget(self, action: #selector(didTapStackViewSelection))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapStackViewSelection(_ sender: UITapGestureRecognizer) {
        changeStackViewState(for: sender.view)
    }
    
    func changeStackViewState(for customSegmentedControl: UIView?) {
        if(customSegmentedControl == faqLabel) {
            helpCenterHelperVC.selectedState = .faq
        }
        else{
            helpCenterHelperVC.selectedState = .contactUS
        }
        
        loadSelectorLine()
        collectionView.reloadData()
    }
    
    func addRightSwipeGesture(toView: UIView) {
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.numberOfTouchesRequired = 1
        swipeGesture.direction = .right
        
        if(toView == collectionView) {
            swipeGesture.addTarget(self, action: #selector(didSwipeRight))
        }
        
        toView.addGestureRecognizer(swipeGesture)
    }
    
    func addLeftSwipeGesture(toView: UIView) {
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.numberOfTouchesRequired = 1
        swipeGesture.direction = .left
        
        if(toView == collectionView) {
            swipeGesture.addTarget(self, action: #selector(didSwipeLeft))
        }
        
        toView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        changeStackViewState(for: faqLabel)
    }
    
    @objc func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        changeStackViewState(for: contactUsLabel)
    }
}

extension HelpCenterVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(helpCenterHelperVC.selectedState){
        case .faq:
            return helpCenterHelperVC.frequentlyAskedQuestions.count
        case .contactUS:
            return helpCenterHelperVC.contactUs.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch(helpCenterHelperVC.selectedState){
        case .faq:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpCenterFAQCollectionViewCell.identifier, for: indexPath) as? HelpCenterFAQCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.questionLabel.text = helpCenterHelperVC.frequentlyAskedQuestions[indexPath.row].question
            
            cell.answerLabel.text = helpCenterHelperVC.frequentlyAskedQuestions[indexPath.row].answer
            
            return cell
        case .contactUS:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpCenterContactUsCollectionViewCell.identifier, for: indexPath) as? HelpCenterContactUsCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.imageName = helpCenterHelperVC.contactUs[indexPath.row].queryImageName
            cell.textValue = helpCenterHelperVC.contactUs[indexPath.row].queryName
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch(helpCenterHelperVC.selectedState) {
        case .faq:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpCenterFAQCollectionViewCell.identifier, for: indexPath) as? HelpCenterFAQCollectionViewCell else{
                return .zero
            }
            
            cell.questionLabel.text = helpCenterHelperVC.frequentlyAskedQuestions[indexPath.row].question
            
            cell.answerLabel.text = helpCenterHelperVC.frequentlyAskedQuestions[indexPath.row].answer
            
            let questionHeight = cell.questionLabel.textHeight(withWidth: view.frame.width - 60, withFontOfSize: cell.questionLabel.font.pointSize)
            
            let answerHeight = cell.answerLabel.textHeight(withWidth: view.frame.width - 60, withFontOfSize: cell.answerLabel.font.pointSize)
            
            let padding = 10
            
            return CGSize(width: view.frame.width - 30, height: CGFloat((2*padding)) + questionHeight + answerHeight + 40)
        case .contactUS:
            return CGSize(width: view.frame.width - 30, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(helpCenterHelperVC.selectedState){
        case .faq:
            ()
        case .contactUS:
            switch(indexPath.row) {
            case 0:
                let number = "9442619108"
                
                if let phoneCallUrl = URL(string: "tel://+91\(number)"){
                    let application = UIApplication.shared
                    if(application.canOpenURL(phoneCallUrl)){
                        application.open(phoneCallUrl, options: [:], completionHandler: nil)
                    }
                }
            case 1:
                let urlString = "https://en.wikipedia.org/wiki/Web_query"
                
                if let url = URL(string: urlString),
                   UIApplication.shared.canOpenURL(url) == true{
                    UIApplication.shared.open(url)
                }
                else{
                    print("Invalid URL to open.")
                }
                
            case 2:
                if(!MFMailComposeViewController.canSendMail()){
                    print("Mail Message Services not available")
                    return
                }
                
                let composeVC = MFMailComposeViewController()
                composeVC.mailComposeDelegate = self
                
                composeVC.setToRecipients(["nabushan.bd@zohocorp.com"])
                composeVC.setSubject("Regarding Query related to: ")
                
                let name = UserDefaults.standard.string(forKey: "User - Name") ?? "Unknown"
                
                composeVC.setMessageBody("Hi !, This is from "+name, isHTML: false)
                
                self.present(composeVC, animated: true)
            case 3:
                if(!MFMessageComposeViewController.canSendText()){
                    print("Message Services not available")
                    return
                }
                
                let composeVC = MFMessageComposeViewController()
                composeVC.messageComposeDelegate = self
                
                composeVC.recipients = ["9442619108"]
                composeVC.subject = "Regarding query related to: "
                
                let name = UserDefaults.standard.string(forKey: "User - Name") ?? "Unknown"
                
                composeVC.body = "Hi !, This is from "+name
                
                self.present(composeVC, animated: true)
            default:
                ()
            }
        }
    }
}

extension HelpCenterVC: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension HelpCenterVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
