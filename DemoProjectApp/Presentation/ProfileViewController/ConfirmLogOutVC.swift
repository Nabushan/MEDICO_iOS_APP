//
//  ConfirmLogOutVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 14/12/22.
//

import UIKit

class ConfirmLogOutVC: UIViewController {

    lazy var nonContentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var logOutLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.text = "Log Out"
        label.font = UIFont(name: "Helvetica", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.contentMode = .center
        label.textAlignment = .center
        label.textColor = .systemRed
        
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var confirmationLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.font = UIFont(name: "Helvetica", size: 17)
        label.adjustsFontSizeToFitWidth = true
        label.contentMode = .center
        label.textAlignment = .center
        label.textColor = .label
        
        return label
    }()
    
    lazy var cancelButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = UIColor(red: 233/255, green: 240/255, blue: 255/255, alpha: 1)
        button.setTitleColor(.systemBlue, for: .normal)
        
        return button
    }()
    
    lazy var logOutButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Yes, Log Out", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(nonContentView)
        view.addSubview(contentView)
        
        contentView.addSubview(logOutLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(confirmationLabel)
        contentView.addSubview(cancelButton)
        contentView.addSubview(logOutButton)
        
        loadNonContentView()
        loadContentView()
        loadLogOutLabel()
        loadLineView()
        loadConfirmationLabel()
        loadCancelButton()
        loadLogOutButton()
    }
    
    func loadNonContentView() {
        nonContentView.translatesAutoresizingMaskIntoConstraints = false
        
        nonContentView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            nonContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nonContentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nonContentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nonContentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        addTapGesture(toView: nonContentView)
    }
    
    func loadContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        var multiplyBy: Double = 1
        
        if(view.frame.height > 800) {
            multiplyBy = 1.0/3.5
        }
        else{
            multiplyBy = 1/3
        }
        
        print("Multiply By : \(multiplyBy)")
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplyBy),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let shapeLayer = CAShapeLayer()
        
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 40, height: 40))
        
        shapeLayer.path = path.cgPath
        
        contentView.layer.mask = shapeLayer
    }
    
    func loadLogOutLabel() {
        logOutLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logOutLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            logOutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            logOutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
    func loadLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: logOutLabel.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: logOutLabel.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: logOutLabel.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func loadConfirmationLabel() {
        confirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        confirmationLabel.text = "Are you sure you want to log out?"
        
        NSLayoutConstraint.activate([
            confirmationLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 10),
            confirmationLabel.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            confirmationLabel.trailingAnchor.constraint(equalTo: lineView.trailingAnchor)
        ])
    }
    
    func loadCancelButton() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: confirmationLabel.bottomAnchor, constant: 10),
            cancelButton.leadingAnchor.constraint(equalTo: confirmationLabel.leadingAnchor),
            cancelButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45)
        ])
        
        cancelButton.layer.cornerRadius = cancelButton.intrinsicContentSize.height / 2
    }
    
    func loadLogOutButton() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            logOutButton.trailingAnchor.constraint(equalTo: confirmationLabel.trailingAnchor),
            logOutButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)
        ])
        
        logOutButton.layer.cornerRadius = cancelButton.layer.cornerRadius
    }
    
    func dismissScreen() {
        self.dismiss(animated: true)
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == nonContentView) {
            tapGesture.addTarget(self, action: #selector(didTapNonContentViewToCancel))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapCancel(_ sender: UIButton) {
        dismissScreen()
    }
    
    @objc func didTapNonContentViewToCancel(_ sender: UITapGestureRecognizer) {
        dismissScreen()
    }
    
    @objc func didTapLogOut(_ sender: UIButton) {
        print("Log Out Tapped.")
        
        UserDefaults.standard.setValue(false, forKey: "User_Logged_In")
        
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LogInViewController(isFromSignUp: false))
        
    }
    
}
