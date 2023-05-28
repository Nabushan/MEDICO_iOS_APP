//
//  OnboardingVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 29/12/22.
//

import UIKit

class OnboardingVC: UIViewController, OnboardingProtocol {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        pageControl.numberOfPages = onboardingHelper.data.count
        
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.backgroundStyle = .minimal
        pageControl.backgroundColor = view.backgroundColor
        
        pageControl.currentPageIndicatorTintColor = .systemBlue
        
        return pageControl
    }()
    
    lazy var button: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if(currentPage == onboardingHelper.data.count - 1) {
                button.setTitle("Get Started", for: .normal)
            }
            else{
                button.setTitle("Next", for: .normal)
            }
        }
    }
    
    let onboardingHelper: OnboardingHelper
    
    init() {
        onboardingHelper = OnboardingHelper()
        
        super.init(nibName: nil, bundle: nil)
        
        onboardingHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(button)
        
        configurePageControl()
        configureCollectionView()
        loadCollectionView()
        loadPageControl()
        loadButton()
    }
    
    func configurePageControl() {
        pageControl.addTarget(self, action: #selector(didTapPageControl), for: .valueChanged)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func loadCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -5)
        ])
    }
    
    func loadPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func loadButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
    }
    
    @objc func didTapPageControl(_ sender: UIPageControl) {
        currentPage = sender.currentPage
        let indexPath = IndexPath(row: sender.currentPage, section: 0)
                
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        if(currentPage == onboardingHelper.data.count - 1){
            print("Show Log In and Sign Up page.")
            
            let logInVC = LogInViewController(isFromSignUp: true)

            let logInNavVC = UINavigationController(rootViewController: logInVC)

            logInNavVC.modalPresentationStyle = .fullScreen
            logInNavVC.modalTransitionStyle = .coverVertical

            present(logInNavVC, animated: true)
        }
        else{
            currentPage+=1
            let indexPath = IndexPath(row: currentPage, section: 0)
            
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingHelper.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if(UIApplication.shared.windows.first?.overrideUserInterfaceStyle == .dark) {
            cell.image = onboardingHelper.darkModeImages[indexPath.row]
        }
        else{
            cell.image = onboardingHelper.data[indexPath.row].imageName
        }
        
        cell.label.text = onboardingHelper.data[indexPath.row].labelContent
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension OnboardingVC {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
