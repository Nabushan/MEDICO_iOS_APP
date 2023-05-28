//
//  AppointmentsSplitViewBackgroundVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 19/12/22.
//

import UIKit

class AppointmentsSplitViewBackgroundVC: UIViewController {

    let appointmentSplitViewController = AppointmentsSplitViewVC(style: .doubleColumn)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        addChild(appointmentSplitViewController)
        view.addSubview(appointmentSplitViewController.view)
        appointmentSplitViewController.didMove(toParent: self)
        
        loadSplitViewController()
    }

    func loadSplitViewController() {
        appointmentSplitViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appointmentSplitViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appointmentSplitViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            appointmentSplitViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            appointmentSplitViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
