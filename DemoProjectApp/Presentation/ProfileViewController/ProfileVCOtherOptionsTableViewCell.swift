//
//  ProfileVCOtherOptionsTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import UIKit

class ProfileVCOtherOptionsTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileVCOtherOptionsTableViewCell"
    
    lazy var contentLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .left
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 15)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["System", "Dark", "Light"])
        
        segmentedControl.selectedSegmentTintColor = .systemBlue
        segmentedControl.selectedSegmentIndex = 0
        
        let attribute =  [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        segmentedControl.setTitleTextAttributes(attribute, for: .selected)
        
        return segmentedControl
    }()
    
    var shouldShowToggleSwitch: Bool = false
    var shouldHideToggleAndChevron: Bool = false
    var shouldHideContentImageView: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        contentView.addSubview(contentLabel)
        
        if(!shouldHideContentImageView){
            contentView.addSubview(contentImageView)
        }
        
        if(!shouldHideToggleAndChevron && shouldShowToggleSwitch){
            contentView.addSubview(segmentedControl)
        }
        
        
        loadContentLabel()
        
        if(!shouldHideContentImageView){
            loadContentImageView()
        }
        
        if(!shouldHideToggleAndChevron && shouldShowToggleSwitch){
            loadModeSegmentedControl()
        }
    }
    
    func loadContentLabel() {
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
        
        if(!shouldHideContentImageView) {
            contentLabel.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 10).isActive = true
        }
        else{
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        }
        
        if(!shouldHideToggleAndChevron && shouldShowToggleSwitch){
            contentLabel.trailingAnchor.constraint(equalTo: segmentedControl.leadingAnchor, constant: -5).isActive = true
        }
        else{
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        }
    }
    
    func loadContentImageView() {
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentImageView.heightAnchor.constraint(equalTo: contentLabel.heightAnchor),
            contentImageView.widthAnchor.constraint(equalTo: contentImageView.heightAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentImageView.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor)
        ])
    }
    
    func loadModeSegmentedControl() {        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.addTarget(self, action: #selector(didTapSegmentedControlSwitch), for: .valueChanged)
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
            segmentedControl.transform = CGAffineTransform(scaleX: 0.6, y: 0.8)
        }
        else{
            segmentedControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.9)
        }
        
        if(UserDefaults.standard.bool(forKey: "Is_DarkMode_Enabled") == true) {
            segmentedControl.selectedSegmentIndex = 1
        }
        else{
            if(UserDefaults.standard.bool(forKey: "Is_SystemPreference_Enabled") == true){
                segmentedControl.selectedSegmentIndex = 0
            }
            else {
                segmentedControl.selectedSegmentIndex = 2
            }
        }
        
        NSLayoutConstraint.activate([
            segmentedControl.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            segmentedControl.leadingAnchor.constraint(equalTo: contentLabel.trailingAnchor, constant: 5)
        ])
    }
    
    func didTapDarkMode(_ isOn: Bool) {
        print("Dark Mode Tapped.")
    
        if(!isOn){
            print("Switch Toggled On by Tap Gesture.")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.setValue(true, forKey: "Is_DarkMode_Enabled")
        }
        else {
            print("Switch Toggled Off by Tap Gesture.")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
            UserDefaults.standard.setValue(false, forKey: "Is_DarkMode_Enabled")
        }
    }
    
    func didTapDarkMode() {
        print("Dark Mode Tapped.")
        
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            UserDefaults.standard.setValue(true, forKey: "Is_SystemPreference_Enabled")
            UserDefaults.standard.setValue(false, forKey: "Is_DarkMode_Enabled")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
        case 1:
            UserDefaults.standard.setValue(false, forKey: "Is_SystemPreference_Enabled")
            UserDefaults.standard.setValue(false, forKey: "Is_DarkMode_Enabled")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        case 2:
            UserDefaults.standard.setValue(false, forKey: "Is_SystemPreference_Enabled")
            UserDefaults.standard.setValue(true, forKey: "Is_DarkMode_Enabled")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
        default:
            ()
        }
        
    }
    
    @objc func didTapSegmentedControlSwitch(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex) {
        case 0:
            UserDefaults.standard.setValue(true, forKey: "Is_SystemPreference_Enabled")
            UserDefaults.standard.setValue(false, forKey: "Is_DarkMode_Enabled")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
        case 1:
            UserDefaults.standard.setValue(false, forKey: "Is_SystemPreference_Enabled")
            UserDefaults.standard.setValue(true, forKey: "Is_DarkMode_Enabled")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
        case 2:
            UserDefaults.standard.setValue(false, forKey: "Is_SystemPreference_Enabled")
            UserDefaults.standard.setValue(false, forKey: "Is_DarkMode_Enabled")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        default:
            ()
        }
    }
    
    @objc func didToggleSwitch(_ sender: UISwitch) {
        if(sender.isOn) {
            print("Switch Toggled On.")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.setValue(true, forKey: "Is_DarkMode_Enabled")
        }
        else {
            print("Switch Toggled Off.")
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
            UserDefaults.standard.setValue(false, forKey: "Is_DarkMode_Enabled")
        }
    }
}
