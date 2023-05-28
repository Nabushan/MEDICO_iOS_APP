//
//  ProfileSplitViewBackGroundVC.swift
//  Medico
//
//  Created by nabushan-pt5611 on 03/01/23.
//

import UIKit

class ProfileSplitViewBackGroundVC: UIViewController {

    let profileSplitViewController = ProfileSplitViewVC(style: .doubleColumn)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        addChild(profileSplitViewController)
        view.addSubview(profileSplitViewController.view)
        profileSplitViewController.didMove(toParent: self)
        
        loadSplitViewController()
    }

    func loadSplitViewController() {
        profileSplitViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileSplitViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileSplitViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileSplitViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileSplitViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
