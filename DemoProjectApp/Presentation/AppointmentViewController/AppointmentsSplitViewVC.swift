//
//  HistoryVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/09/22.
//

import UIKit

class AppointmentsSplitViewVC: UISplitViewController {

    var primaryVC: AppointmentsListVC?
    var secondaryVC: UIViewController?
    var navVC: UINavigationController?
    
    override init(style: UISplitViewController.Style) {
        super.init(style: style)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveNotificationToReloadParent), name: NSNotification.Name("Should-Reload-CollectionView"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("Should-Reload-CollectionView"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        loadViewControllers()
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            self.preferredDisplayMode = UISplitViewController.DisplayMode.oneBesideSecondary
            self.preferredSplitBehavior = .tile
        }
        else{
            self.preferredDisplayMode = UISplitViewController.DisplayMode.oneOverSecondary
        }
        
        if let navController = self.viewControllers[0] as? UINavigationController {
            navController.popViewController(animated: true)
        }
        
        self.minimumPrimaryColumnWidth = UISplitViewController.automaticDimension
        self.maximumPrimaryColumnWidth = UISplitViewController.automaticDimension
        
        loadPresentsWithGesture()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        loadPresentsWithGesture()
    }
    
    func loadPresentsWithGesture() {
        if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
            self.presentsWithGesture = false
        }
        else{
            self.presentsWithGesture = true
        }
    }
    
    func loadViewControllers() {
        primaryVC = AppointmentsListVC()
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
        
        var secondVC: UIViewController?
        
        if(primaryVC.appointmentsListHelperVC.upcomingAppointments.count == 0) {
            secondVC = AppointmentInfoVC()
        }
        else{
            if(UITraitCollection.current.userInterfaceIdiom == .phone) {
                secondVC = AppointmentInfoVC()
            }
            else {
                secondVC = AppointmentInfoVC(consultation: primaryVC.appointmentsListHelperVC.upcomingAppointments[0], isFromPayment: false)
            }
        }
        
        secondaryVC = secondVC
        
        self.setViewController(navVC, for: .primary)
        self.setViewController(secondVC, for: .secondary)
        
        if(primaryVC.appointmentsListHelperVC.upcomingAppointments.count > 0){
            didSelectInParentView(primaryVC.appointmentsListHelperVC.upcomingAppointments[0])
        }
    }
    
    @objc func didRecieveNotificationToReloadParent(_ notification: NSNotification) {
        shouldReloadParentView()
    }
}

extension AppointmentsSplitViewVC: SplitViewCommunicationProtocol {
    func didSelectInParentView(_ consultation: ConsultationGetter) {
        
        (self.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: false)
        
        let secondVC = AppointmentInfoVC(consultation: consultation, isFromPayment: false)
        secondVC.completionAndCancellingDelegate = self
        
        let secondaryNavVC = UINavigationController(rootViewController: secondVC)
        
        self.showDetailViewController(secondaryNavVC, sender: nil)
    }
    
    func didSelectInParentView(_ index: Int) {
        if(index == -1) {
            let secondVC = AppointmentInfoVC()
            
            self.showDetailViewController(secondVC, sender: nil)
        }
        if(index == -2) {
            let secondVC = AppointmentInfoVC(isSearchActive: true)
            
            self.showDetailViewController(secondVC, sender: nil)
        }
    }
    
    func shouldReloadParentView() {
        primaryVC?.appointmentsListHelperVC.getAppointments()
        primaryVC?.appointmentTableView.reloadData()
    }
}

extension AppointmentsSplitViewVC: AppointmentMarkingCompletedAndCancellingProtocol {
    func fetchAndReloadCollectionView() {
        shouldReloadParentView()
    }
}

extension AppointmentsSplitViewVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        shouldReloadParentView()
        loadPresentsWithGesture()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
}
