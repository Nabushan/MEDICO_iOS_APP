//
//  ProfileVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/09/22.
//



import UIKit

class ProfileVC: UIViewController, ProfileProtocol {

    lazy var imagePicker = UIImagePickerController()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: 50,
                                                bottom: 0,
                                                right: 0)
        
        tableView.separatorStyle = .singleLine
        
        tableView.register(ProfileVCImageAndNameTableViewCell.self, forCellReuseIdentifier: ProfileVCImageAndNameTableViewCell.identifier)
        
        tableView.register(ProfileVCOtherOptionsTableViewCell.self, forCellReuseIdentifier: ProfileVCOtherOptionsTableViewCell.identifier)
        
        return tableView
    }()
    
    let profileHelperVC: ProfileVCHelper
    
    weak var delegate: SplitViewCommunicationProtocol?
    
    init() {
        profileHelperVC = ProfileVCHelper()
        
        super.init(nibName: nil, bundle: nil)
        
        profileHelperVC.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "Profile"
        
        view.addSubview(tableView)
        
        configureTableView()
        loadTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func didTapEditProfile() {
        print("Edit Profile Tapped.")
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            delegate?.didSelectInParentView(0)
        }
        else{
            let secondVC = ProfileInfoVC()
            
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    func didTapHelpCenter() {
        print("Help Center Tapped.")
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            delegate?.didSelectInParentView(1)
        }
        else{
            let secondVC = HelpCenterVC()
            
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    func didTapAppearance() {
        print("Appearance Tapped.")
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            delegate?.didSelectInParentView(2)
        }
    }
    
    func didTapPersonDetails() {
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            delegate?.didSelectInParentView(3)
        }
        else{
            let viewController = PersonDetailsTableVC(isToAddOrEditPersonDetails: false, isEditingDetails: nil, personDetails: nil)
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func didTapLogOut() {
        print("Log Out Tapped.")
    
        let alertVC = UIAlertController(title: "Log Out", message: "Are you sure you want to Log Out", preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .default){_ in
            self.dismiss(animated: true)
        })
        
        alertVC.addAction(UIAlertAction(title: "Log Out", style: .destructive){_ in
            UserDefaults.standard.setValue(false, forKey: "User_Logged_In")
            
            UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: LogInViewController(isFromSignUp: false))
        })
        
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
            let detailVC = self.splitViewController?.viewControllers.last
            
            detailVC?.present(alertVC, animated: true)
        }
        else{
            present(alertVC, animated: true)
        }
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0 || section == 3){
            return 1
        }
        else {
            if(section == 1) {
                return profileHelperVC.profileOptions[0].count
            }
            else{
                return profileHelperVC.profileOptions[1].count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileVCImageAndNameTableViewCell.identifier, for: indexPath) as? ProfileVCImageAndNameTableViewCell else {
                return UITableViewCell()
            }
            
            cell.accessoryType = .disclosureIndicator
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileVCOtherOptionsTableViewCell.identifier, for: indexPath) as? ProfileVCOtherOptionsTableViewCell else {
                return UITableViewCell()
            }
            
            if(UITraitCollection.current.userInterfaceIdiom == .phone) {
                if(indexPath.row == 1){
                    cell.shouldShowToggleSwitch = true
                }
                else{
                    cell.shouldShowToggleSwitch = false
                    cell.accessoryType = .disclosureIndicator
                }
            }
            else {
                cell.shouldShowToggleSwitch = false
                cell.accessoryType = .disclosureIndicator
            }
            
            cell.contentImageView.image = UIImage(systemName: profileHelperVC.profileOptionsImages[0][indexPath.row])
            
            cell.contentImageView.layer.cornerRadius = 5
            
            cell.contentLabel.text = profileHelperVC.profileOptions[0][indexPath.row]
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileVCOtherOptionsTableViewCell.identifier, for: indexPath) as? ProfileVCOtherOptionsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.shouldShowToggleSwitch = false
            cell.accessoryType = .disclosureIndicator
            
            
            cell.contentImageView.image = UIImage(systemName: profileHelperVC.profileOptionsImages[1][indexPath.row])
            
            cell.contentImageView.layer.cornerRadius = 5
            
            cell.contentLabel.text = profileHelperVC.profileOptions[1][indexPath.row]
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileVCOtherOptionsTableViewCell.identifier, for: indexPath) as? ProfileVCOtherOptionsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.shouldHideToggleAndChevron = true
            
            cell.contentImageView.image = UIImage(systemName: "power.circle.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            
            cell.contentImageView.layer.cornerRadius = 5
            
            cell.contentLabel.text = "Log Out"
            cell.contentLabel.textColor = .systemRed
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch(indexPath.section){
        case 0:
            if(UITraitCollection.current.userInterfaceIdiom == .phone) {
                self.tabBarController?.tabBar.isHidden = true
            }
            didTapEditProfile()
        case 1:
            switch(indexPath.row){
            case 0:
                if(UITraitCollection.current.userInterfaceIdiom == .phone) {
                    self.tabBarController?.tabBar.isHidden = true
                }
                didTapHelpCenter()
            case 1:
                if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                    didTapAppearance()
                }
            default:
                ()
            }
        case 2:
            if(UITraitCollection.current.userInterfaceIdiom == .phone) {
                self.tabBarController?.tabBar.isHidden = true
            }
            didTapPersonDetails()
        case 3:
            didTapLogOut()
        default:
            ()
        }
    }
}

extension ProfileVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
}
