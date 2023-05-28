//
//  ProfileSplitViewVC.swift
//  Medico
//
//  Created by nabushan-pt5611 on 03/01/23.
//

import UIKit

class ProfileSplitViewVC: UISplitViewController {

    var primaryVC: ProfileVC?
    var navVC: UINavigationController?
    
    override init(style: UISplitViewController.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        loadViewControllers()
        
        self.preferredDisplayMode = UISplitViewController.DisplayMode.oneBesideSecondary
        self.preferredSplitBehavior = .tile
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            self.presentsWithGesture = self.preferredDisplayMode != .oneBesideSecondary
        }
        
        if let navController = self.viewControllers[0] as? UINavigationController {
            navController.popViewController(animated: true)
        }
        
        self.minimumPrimaryColumnWidth = UISplitViewController.automaticDimension
        self.maximumPrimaryColumnWidth = UISplitViewController.automaticDimension
    }
    
    func loadViewControllers() {
        primaryVC = ProfileVC()
        primaryVC?.delegate = self
        
        guard let primaryVC = primaryVC else {
            return
        }
        
        navVC = UINavigationController(rootViewController: primaryVC)
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .secondarySystemGroupedBackground
        
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
               
        navVC?.navigationBar.standardAppearance = coloredAppearance
        navVC?.navigationBar.scrollEdgeAppearance = coloredAppearance
        
        let secondVC = ProfileInfoVC()
        secondVC.hidesBackButton = true
        
        self.setViewController(navVC, for: .primary)
        self.setViewController(secondVC, for: .secondary)
        
        didSelectInParentView(0)
    }
}

extension ProfileSplitViewVC: SplitViewCommunicationProtocol {
    func didSelectInParentView(_ index: Int) {
        
        (self.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: false)
        
        var secondVC: UIViewController?
        
        if(index == 0) {
            secondVC = ProfileInfoVC()
        }
        else if(index == 1) {
            secondVC = HelpCenterVC()
        }
        else if(index == 2) {
            secondVC = InformationDetailVC(.appearance)
        }
        else if(index == 3) {
            secondVC = PersonDetailsTableVC(isToAddOrEditPersonDetails: false, isEditingDetails: nil, personDetails: nil)
        }
        
        guard let secondVC = secondVC else {
            return
        }

        let secondaryNavVC = UINavigationController(rootViewController: secondVC)

        self.showDetailViewController(secondaryNavVC, sender: nil)
    }
    
    func shouldReloadParentView() {
        ()
    }
}

extension ProfileSplitViewVC: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, shouldHide vc: UIViewController, in orientation: UIInterfaceOrientation) -> Bool {
        switch(orientation){
        case .portrait:
            return false
        default:
            return true
        }
    }
}
