//
//  PharmacyAvailableProductsVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 23/12/22.
//

import UIKit

class PharmacyAvailableProductsVC: UIViewController, PharmacyAvailableProductsProrocol {

    let pharmacyId: Int
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(PharmacyProfileCollectionViewCell.self, forCellWithReuseIdentifier: PharmacyProfileCollectionViewCell.identifier)
        
        collectionView.register(CollectionViewSearchFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewSearchFooterReusableView.identifier)
        
        return collectionView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        
        searchController.searchBar.delegate = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search"
        
        return searchController
    }()
    
    lazy var noSearchResultImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "No Search Result")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var noSearchResultHeader: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 0
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    lazy var noSearchResultBody: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    var searchBarButton: UIBarButtonItem = UIBarButtonItem()
    let pharmacyAvailableProductHelper: PharmacyAvailableProductsHelper
    
    init(pharmacyProducts: [PharmacyProduct], pharmacyId: Int) {
        self.pharmacyId = pharmacyId
        pharmacyAvailableProductHelper = PharmacyAvailableProductsHelper(pharmacyProducts)
        
        super.init(nibName: nil, bundle: nil)
        
        pharmacyAvailableProductHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = "Available Products"
        
        view.addSubview(collectionView)
        navigationItem.searchController = searchController
        
        view.addSubview(noSearchResultImageView)
        view.addSubview(noSearchResultHeader)
        view.addSubview(noSearchResultBody)
        
        configureSearchBar()
        configureCollectionView()
        loadCollectionView()
        
        loadNoSearchResultImageView()
        loadNoSearchResultHeader()
        loadNoSearchResultBody()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.reloadData()
    }
    
    func configureSearchBar() {
        searchController.searchBar.delegate = self
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func loadCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func loadNoSearchResultImageView() {
        noSearchResultImageView.translatesAutoresizingMaskIntoConstraints = false
        
        noSearchResultImageView.alpha = 0
        
        if(view.frame.height > 800){
            NSLayoutConstraint.activate([
                noSearchResultImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
                noSearchResultImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                noSearchResultImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        }
        else{
            NSLayoutConstraint.activate([
                noSearchResultImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                noSearchResultImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                noSearchResultImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            ])
        }
    }
    
    func loadNoSearchResultHeader() {
        noSearchResultHeader.translatesAutoresizingMaskIntoConstraints = false
        
        noSearchResultHeader.text = "We couldn't find what you searched for."
        
        noSearchResultHeader.alpha = 0
        
        NSLayoutConstraint.activate([
            noSearchResultHeader.bottomAnchor.constraint(equalTo: noSearchResultBody.topAnchor, constant: -5),
            noSearchResultHeader.leadingAnchor.constraint(equalTo: noSearchResultBody.leadingAnchor),
            noSearchResultHeader.trailingAnchor.constraint(equalTo: noSearchResultBody.trailingAnchor),
        ])
    }
    
    func loadNoSearchResultBody() {
        noSearchResultBody.translatesAutoresizingMaskIntoConstraints = false
        
        noSearchResultBody.text = "Try searching again."
        
        noSearchResultBody.alpha = 0
        
        NSLayoutConstraint.activate([
            noSearchResultBody.bottomAnchor.constraint(equalTo: noSearchResultImageView.bottomAnchor, constant: -5),
            noSearchResultBody.leadingAnchor.constraint(equalTo: noSearchResultImageView.leadingAnchor),
            noSearchResultBody.trailingAnchor.constraint(equalTo: noSearchResultImageView.trailingAnchor),
        ])
    }
    
    func highlight(fromSource: String, toTarget: String) -> NSMutableAttributedString {
        let fromSourceCnt = fromSource.count
        
        var indices: [Int] = []
        
        for index in 0..<toTarget.count - fromSourceCnt + 1 {
            let range = toTarget.index(toTarget.startIndex, offsetBy: index)..<toTarget.index(toTarget.startIndex, offsetBy: index + fromSourceCnt)
            
            if(toTarget[range].lowercased() == fromSource.lowercased()){
                indices.append(index)
            }
        }
        
        let attributedString = NSMutableAttributedString(string: toTarget)
        
        for index in indices {
            attributedString.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: NSRange(location: index, length: fromSourceCnt))
        }
        
        return attributedString
    }
}

extension PharmacyAvailableProductsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchController.isActive) {
            return pharmacyAvailableProductHelper.searchProducts.count
        }
        else{
            return pharmacyAvailableProductHelper.pharmacyProducts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyProfileCollectionViewCell.identifier, for: indexPath) as? PharmacyProfileCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if(searchController.isActive) {
            cell.product = pharmacyAvailableProductHelper.searchProducts[indexPath.row]
            
            let text = highlight(fromSource: searchController.searchBar.text ?? "", toTarget: pharmacyAvailableProductHelper.searchProducts[indexPath.row].name)
            
            cell.medicineNameLabel.attributedText = text
        }
        else{
            cell.product = pharmacyAvailableProductHelper.pharmacyProducts[indexPath.row]
        }
        
        cell.contentView.layer.cornerRadius = 10
        
        cell.medicineImage.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var product = pharmacyAvailableProductHelper.pharmacyProducts[0]
        
        if(searchController.isActive) {
            product = pharmacyAvailableProductHelper.searchProducts[indexPath.row]
        }
        else{
            product = pharmacyAvailableProductHelper.pharmacyProducts[indexPath.row]
        }
        
        let pharmacyProductVC = PharmacyProductVC(product: product, pharmacyId: pharmacyId)
        
        pharmacyProductVC.delegate = self
        
        present(pharmacyProductVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                return CGSize(width: (view.frame.width/3) - 15, height: view.frame.height/8)
            }
            return CGSize(width: (view.frame.width/2) - 20, height: view.frame.height/9)
        }
        else {
            if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    return CGSize(width: (view.frame.width) - 30, height: view.frame.height/8)
                }
                return CGSize(width: view.frame.width - 30, height: view.frame.height/9)
            }
            else{
                return CGSize(width: view.frame.width - 30, height: view.frame.height/6.5)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        else{
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        noSearchResultImageView.alpha = 0
        noSearchResultHeader.alpha = 0
        noSearchResultBody.alpha = 0
        
        if(searchController.isActive && searchController.searchBar.text?.count != 0 && pharmacyAvailableProductHelper.searchProducts.count != 0){
            return CGSize(width: view.frame.width, height: 20)
        }
        
        if(searchController.searchBar.text?.count != 0){
            noSearchResultImageView.alpha = 1
            noSearchResultHeader.alpha = 1
            noSearchResultBody.alpha = 1
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch(kind) {
        case UICollectionView.elementKindSectionFooter:
            guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSearchFooterReusableView.identifier, for: indexPath) as? CollectionViewSearchFooterReusableView else {
                return UICollectionReusableView()
            }
            
            reusableView.searchResults = "\(pharmacyAvailableProductHelper.searchProducts.count) / \(pharmacyAvailableProductHelper.pharmacyProducts.count) Search Results"
            
            if(!searchController.isActive) {
                reusableView.label.alpha = 0
            }
            else{
                reusableView.label.alpha = 1
            }
            
            return reusableView
            
        default:
            return UICollectionReusableView()
        }
    }
}

extension PharmacyAvailableProductsVC: ViewInCartProtocol {
    func showCartVC() {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 1
    }
}

extension PharmacyAvailableProductsVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pharmacyAvailableProductHelper.getSearchResults(forText: searchText)
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        collectionView.reloadData()
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
