//
//  ProfileVCImageAndNameTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import UIKit

class ProfileVCImageAndNameTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileVCImageAndNameTableViewCell"
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var nameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.font = UIFont(name: "Helvetica", size: 20)
        label.contentMode = .left
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var contactLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.font = UIFont(name: "Helvetica", size: 15)
        label.contentMode = .left
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        NotificationCenter.default.removeObserver(self,
                                                      name: NSNotification.Name("Profile-ImageChange-From-HomeVC"),
                                                      object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Profile-ImageChange-From-ProfileVC"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Profile-UserName-Changed-From-ProfileInfoValueChangeVC"), object: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(contactLabel)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(isProfileImageChaged),
                                                       name: NSNotification.Name("Profile-ImageChange-From-HomeVC"),
                                                       object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(isProfileImageChaged),
                                                       name: NSNotification.Name("Profile-ImageChange-From-ProfileVC"),
                                                       object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(isUserNameChanged), name: NSNotification.Name("Profile-UserName-Changed-From-ProfileInfoValueChangeVC"), object: nil)
        
        loadProfileImageView()
        loadNameLabel()
        loadContactLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Profile-ImageChange-From-HomeVC"), object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Profile-ImageChange-From-ProfileVC"), object: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func loadProfileImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let image = UserDefaults.standard.image(forKey: "User Selected Image" + "-\(UserDefaults.standard.integer(forKey: "User - Id"))"){
            profileImageView.image = image
        }
        else {
            profileImageView.image = UserDefaults.standard.image(forKey: "Default Image")
        }
        
        let width = 0.2
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: width*contentView.frame.width),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        print(profileImageView.frame.height)
        profileImageView.layer.cornerRadius = (width*contentView.frame.width)/2
    }
    
    func loadNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = UserDefaults.standard.string(forKey: "User - Name")
        
        nameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func loadContactLabel() {
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contactLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        contactLabel.text = "Mail ID, Contact Number, Password"
        
        NSLayoutConstraint.activate([
            contactLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -5),
            contactLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            contactLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contactLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    @objc func isProfileImageChaged(_ sender: Notification) {
        guard let userInfo = sender.userInfo as? [String: UIImage],
                let image = userInfo["selected-Image"]  else {
            return
        }
        
        profileImageView.image = image
    }
    
    @objc func isUserNameChanged(_ sender: Notification) {
        nameLabel.text = UserDefaults.standard.string(forKey: "User - Name")
    }
}
