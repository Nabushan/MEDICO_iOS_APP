//
//  HomeScreenVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/09/22.
//

import UIKit

class HomeScreenVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tabBar.backgroundColor = .systemBackground
        
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            self.setViewControllers([getHomeVC(), getCartVC(), getAppointmentsSplitViewVC(), getProfileSplitViewVC()], animated: false)
        }
        else{
            self.setViewControllers([getHomeVC(), getCartVC(), getAppointmentsVC(), getProfileVC()], animated: false)
        }
        self.tabBar.tintColor = UIColor(red: 50/255, green: 130/255, blue: 255/255, alpha: 1)
        
    }
    
    func getHomeVC() -> UINavigationController {
        let home = UINavigationController(rootViewController: HomeVC())
        
        home.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house.fill"),
                                       tag: 0)
        home.title = "Home"
        
        home.customiseNavBarAppearance()
        
        return home
    }
    
    func getCartVC() -> UINavigationController {
        let shop = UINavigationController(rootViewController: CartVC())
        
        shop.tabBarItem = UITabBarItem(title: "Cart",
                                          image: UIImage(systemName: "cart.fill"),
                                          tag: 1)
        
        shop.customiseNavBarAppearance()
        
        return shop
    }
    
    func getAppointmentsVC() -> UINavigationController {
        let appointments = UINavigationController(rootViewController: AppointmentsListVC())
        
        
        appointments.tabBarItem = UITabBarItem(title: "Appointments",
                                          image: UIImage(systemName: "calendar"),
                                          tag: 3)

        appointments.customiseNavBarAppearance()

        return appointments
    }
    
    func getAppointmentsSplitViewVC() -> UIViewController {
        let appointments = AppointmentsSplitViewBackgroundVC()
        
        
        appointments.tabBarItem = UITabBarItem(title: "Appointments",
                                          image: UIImage(systemName: "calendar"),
                                          tag: 3)


        return appointments
    }
    
    func getProfileVC() -> UINavigationController {
        let profile = UINavigationController(rootViewController: ProfileVC())
        
        profile.tabBarItem = UITabBarItem(title: "Profile",
                                          image: UIImage(systemName: "person.circle.fill"),
                                          tag: 4)

        profile.customiseNavBarAppearance()

        return profile
    }
    
    func getProfileSplitViewVC() -> UIViewController {
        let profile = ProfileSplitViewBackGroundVC()
        
        profile.tabBarItem = UITabBarItem(title: "Profile",
                                          image: UIImage(systemName: "person.circle.fill"),
                                          tag: 4)
        
        return profile
    }
}

extension HomeScreenVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension AppDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        return self.restrictRotation
    }
}
