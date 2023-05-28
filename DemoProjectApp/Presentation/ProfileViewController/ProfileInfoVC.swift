//
//  ProfileInfoVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import UIKit

class ProfileInfoVC: UIViewController, ProfileInfoProtocol {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.separatorInset = UIEdgeInsets(top: 0,
                                                left: 15,
                                                bottom: 0,
                                                right: 0)
        
        tableView.register(ProfileVCOtherOptionsTableViewCell.self, forCellReuseIdentifier: ProfileVCOtherOptionsTableViewCell.identifier)
        
        return tableView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = false
        
        return imageView
    }()
    
    lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        
        return imagePicker
    }()
    
    lazy var nameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.font = UIFont(name: "Helvetica", size: 20)
        label.contentMode = .center
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        
        return label
    }()
    
    lazy var mailIdLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.font = UIFont(name: "Helvetica", size: 15)
        label.contentMode = .center
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let profileInfoHelper: ProfileInfoHelperVC
    
    var hidesBackButton: Bool? {
        didSet {
            guard let hidesBackButton = hidesBackButton else {
                return
            }
            
            navigationItem.hidesBackButton = hidesBackButton
        }
    }
    
    init() {
        profileInfoHelper = ProfileInfoHelperVC()
        
        super.init(nibName: nil, bundle: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(isProfileImageChaged),
                                               name: NSNotification.Name("Profile-ImageChange-From-ProfileVC"),
                                               object: nil)
        
        profileInfoHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Profile-ImageChange-From-ProfileVC"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        self.title = "Details"
        
        configureTableView()
        configureImagePicker()
        loadTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    func loadTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.safeAreaInsets.bottom)
        ])
    }
    
    @objc func didTapProfileImage(_ sender: UITapGestureRecognizer) {
        print("Profile image Tapped.")
        
        present(imagePicker, animated: true)
    }
    
    func reloadNameAndMailId() {
        if let name = UserDefaults.standard.string(forKey: "User - Name") {
            nameLabel.text = name
        }
        else{
            nameLabel.text = "Unknown"
        }
        
        if let mailId = UserDefaults.standard.string(forKey: "User - MailID"){
            mailIdLabel.text = mailId
        }
        else{
            mailIdLabel.text = "youmail@yourdomain.com"
        }
    }
    
    @objc func isProfileImageChaged(_ sender: Notification){
        guard let userInfo = sender.userInfo as? [String: UIImage],
              let image = userInfo["selected-Image"]  else {
            return
        }
        
        imageView.image = image
    }
}

extension ProfileInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage else{
            return
        }
        
        UserDefaults.standard.setImage(image, forKey: "User Selected Image" + "-\(UserDefaults.standard.integer(forKey: "User - Id"))")
        
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name("Profile-ImageChange-From-ProfileVC"),
                                        object: nil,
                                        userInfo: ["selected-Image" : imageView.image as Any])
    }
}

extension ProfileInfoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileInfoHelper.profileInfoAvailableOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileVCOtherOptionsTableViewCell.identifier, for: indexPath) as? ProfileVCOtherOptionsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.shouldHideContentImageView = true
        cell.contentLabel.text = profileInfoHelper.profileInfoAvailableOptions[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var informationDetailVC: InformationDetailVC?
        
        switch(indexPath.row) {
        case 0:
            informationDetailVC = InformationDetailVC(.nameAndDetails)
        case 1:
            informationDetailVC = InformationDetailVC(.passwordAndSecurity)
        default:
            ()
        }
        
        guard let informationDetailVC = informationDetailVC else {
            return
        }
        
        self.navigationController?.pushViewController(informationDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        160
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let viewForImage: UIView = {
            let view = UIView()
            
            view.clipsToBounds = true
            view.isUserInteractionEnabled = true
            
            return view
        }()
        
        let editLabel: ResizedLabel = {
            let label = ResizedLabel()
            
            label.font = UIFont(name: "Helvetica", size: 10)
            label.contentMode = .center
            label.textAlignment = .center
            label.adjustsFontSizeToFitWidth = true
            label.textColor = .label
            label.text = "EDIT"
            label.backgroundColor = .black
            label.textColor = .white
            
            return label
        }()
        
        if let tempImage = UserDefaults.standard.image(forKey: "User Selected Image" + "-\(UserDefaults.standard.integer(forKey: "User - Id"))"){
            imageView.image = tempImage
        }
        else {
            imageView.image = UserDefaults.standard.image(forKey: "Default Image")
        }
        
        view.addSubview(viewForImage)
        viewForImage.addSubview(imageView)
        viewForImage.addSubview(editLabel)
        view.addSubview(nameLabel)
        view.addSubview(mailIdLabel)
        
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        editLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        mailIdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let width = 0.5
        
        NSLayoutConstraint.activate([
            viewForImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: width),
            viewForImage.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            viewForImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewForImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            
            imageView.widthAnchor.constraint(equalTo: viewForImage.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: viewForImage.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: viewForImage.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: viewForImage.centerYAnchor),
            
            editLabel.widthAnchor.constraint(equalTo: viewForImage.widthAnchor),
            editLabel.bottomAnchor.constraint(equalTo: viewForImage.bottomAnchor, constant: 3),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            mailIdLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -5),
            mailIdLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            mailIdLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            mailIdLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        
        viewForImage.layer.cornerRadius = (160 * width)/2
        
        reloadNameAndMailId()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage))
        viewForImage.addGestureRecognizer(tapGesture)
        
        return view
    }
}

extension ProfileInfoVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadNameAndMailId()
    }
}
