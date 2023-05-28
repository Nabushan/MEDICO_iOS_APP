//
//  PharmacyListVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 11/10/22.
//

import UIKit

class PharmacyListVC: UIViewController, PharmacyListProtocol {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(PharmacyListCollectionViewCell.self, forCellWithReuseIdentifier: PharmacyListCollectionViewCell.identifier)
        
        collectionView.register(CollectionViewSearchFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewSearchFooterReusableView.identifier)
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    lazy var pharmaciesLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        
        searchController.searchBar.delegate = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
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
    
    let pharmacyListHelperVC: PharmacyListHelperVC
    
    var filterBarButton: UIBarButtonItem = UIBarButtonItem()
    var emptyBarButton: UIBarButtonItem = UIBarButtonItem()
    var searchBarButton: UIBarButtonItem = UIBarButtonItem()
    var collectionViewTopAnchor: NSLayoutConstraint?
    var isSearchActive: Bool = false
    
    init() {
        pharmacyListHelperVC = PharmacyListHelperVC()
        
        super.init(nibName: nil, bundle: nil)
        
        filterBarButton = UIBarButtonItem(
            title: nil,
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            primaryAction: nil,
            menu: getMenu())
        
        emptyBarButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        pharmacyListHelperVC.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(isRatingChanged), name: Notification.Name("NotificationIdentifier_StarRating_Updated"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier_StarRating_Updated"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        // Do any additional setup after loading the view.
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = filterBarButton
        
        view.addSubview(collectionView)
        view.addSubview(noSearchResultImageView)
        view.addSubview(noSearchResultHeader)
        view.addSubview(noSearchResultBody)
        
        configureDelegates()
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
    
    @objc func isRatingChanged(_ sender: Notification) {
        print("Star update notification fired.")
        guard let userInfo = sender.userInfo as? [String: Int],
              let pharmacyId = userInfo["StarRating_Updated_PharmacyId"],
              let ratingOutOfFive = userInfo["StarRating_Updated_RatingOutOfFive"]
        else {
            return
        }
        
        let indexPath = IndexPath(row: pharmacyId, section: 0)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PharmacyListCollectionViewCell else{
            return
        }
        
        if(pharmacyId + 1 == cell.pharmacy?.id){
            print(cell.pharmacy?.name)
            pharmacyListHelperVC.pharmacies[pharmacyId].ratingOutOfFive = ratingOutOfFive
            print(pharmacyListHelperVC.pharmacies[pharmacyId].ratingOutOfFive)
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func configureDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchController.searchBar.delegate = self
    }
    
    func loadPharmaciesLabel() {
        pharmaciesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        pharmaciesLabel.text = "Pharmacies"
        pharmaciesLabel.font = .boldSystemFont(ofSize: 25)
        
        NSLayoutConstraint.activate([
            pharmaciesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pharmaciesLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            pharmaciesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
        ])
    }
    
    func loadCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionViewTopAnchor = collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        collectionView.contentInset = UIEdgeInsets(
            top: 10,
            left: 0,
            bottom: 10,
            right: 0)
        
        collectionView.backgroundColor = .systemGroupedBackground
        
        NSLayoutConstraint.activate([
            collectionViewTopAnchor!,
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
    
    func getMenu() -> UIMenu {
        let sortAtoZ = UIAction(title: "A-Z", state: .on) { [weak self] _ in
            self?.pharmacyListHelperVC.sortSearchResults(by: .nameInAscending)
            self?.pharmacyListHelperVC.chosenSortBy = .nameInAscending
            self?.collectionView.reloadData()
        }
        
        let sortZtoA = UIAction(title: "Z-A") { [weak self] _ in
            self?.pharmacyListHelperVC.sortSearchResults(by: .nameInDescending)
            self?.pharmacyListHelperVC.chosenSortBy = .nameInDescending
            self?.collectionView.reloadData()
        }
        
        let sortByRatingAscending = UIAction(title: "Rating (Ascending)") { [weak self] _ in
            self?.pharmacyListHelperVC.sortSearchResults(by: .ratingInAscending)
            self?.pharmacyListHelperVC.chosenSortBy = .ratingInAscending
            self?.collectionView.reloadData()
        }
        
        let sortByRatingDescending = UIAction(title: "Rating (Descending)") { [weak self] _ in
            self?.pharmacyListHelperVC.sortSearchResults(by: .ratingInDescending)
            self?.pharmacyListHelperVC.chosenSortBy = .ratingInDescending
            self?.collectionView.reloadData()
        }
        
        return UIMenu(
            title: "Sort By",
            options: .singleSelection,
            children: [sortAtoZ, sortZtoA, sortByRatingAscending, sortByRatingDescending])
    }
    
    func contextMenuFor(indexPath: IndexPath) -> UIContextMenuConfiguration {
        let contextMenuConfiguration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { menu in
            let shareProfileAction = UIAction(title: "Write A Review.",
                                              image: UIImage(systemName: "square.and.pencil"),
                                              identifier: nil) {[weak self] action in
                
                guard let pharmacy = self?.pharmacyListHelperVC.pharmacies[indexPath.row] else {
                    return
                }
                
                var reviewWritten: Bool = false
                var reviewToSend: Reviews?
                
                self?.pharmacyListHelperVC.getPharmacyReviews(reviewId: pharmacy.id)
                
                guard let reviews = self?.pharmacyListHelperVC.reviews else {
                    return
                }
                
                for review in reviews {
                    if(review.reviewerName == UserDefaults.standard.string(forKey: "User - Name")) {
                        reviewWritten = true
                        reviewToSend = review
                    }
                }
                
                var pharmacyWriteAReviewVC: UINavigationController?
                
                if(reviewWritten){
                    guard let reviewToSend = reviewToSend else {
                        return
                    }
                    
                    pharmacyWriteAReviewVC = UINavigationController(rootViewController: PharmacyWriteAReviewVC(
                        review: reviewToSend,
                        previouslyFilledStars: reviewToSend.numberOfRatingStars,
                        pharmacyReviewId: pharmacy.reviewId))
                }
                else{
                    pharmacyWriteAReviewVC = UINavigationController(rootViewController: PharmacyWriteAReviewVC(
                            previouslyFilledStars: 0,
                            pharmacyReviewId: pharmacy.reviewId))
                }
                
                guard let pharmacyWriteAReviewVC = pharmacyWriteAReviewVC else {
                    return
                }
                
                self?.present(pharmacyWriteAReviewVC, animated: true)
                
                self?.pharmacyListHelperVC.getPharmacyReviews(reviewId: pharmacy.id)
            }
            
            let menu = UIMenu(title: "",
                              options: .singleSelection,
                              children: [shareProfileAction])
            
            return menu
        }
        
        return contextMenuConfiguration
    }
}

extension PharmacyListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isSearchActive){
            return pharmacyListHelperVC.searchResults.count
        }
        return pharmacyListHelperVC.pharmacies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                return CGSize(width: (view.frame.width/3) - 15, height: view.frame.height / 6.5)
            }
            return CGSize(width: (view.frame.width/2) - 10, height: view.frame.height / 8)
        }
        else{
            if(UITraitCollection.current.userInterfaceIdiom == .pad){
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    return CGSize(width: (view.frame.width) - 20, height: view.frame.height / 6.5)
                }
                return CGSize(width: view.frame.width - 20, height: view.frame.height / 8)
            }
            return CGSize(width: view.frame.width - 20, height: view.frame.height / 5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyListCollectionViewCell.identifier, for: indexPath) as? PharmacyListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        cell.pharmacy = pharmacyListHelperVC.pharmacies[indexPath.row]
        if(isSearchActive == true){
            cell.pharmacy = pharmacyListHelperVC.searchResults[indexPath.row]
            
            cell.nameLabel.attributedText = highlight(fromSource: searchController.searchBar.text ?? "", toTarget: cell.pharmacy?.name ?? "")
        }
        else{
            cell.pharmacy = pharmacyListHelperVC.pharmacies[indexPath.row]
        }
        
        cell.layer.shadowColor = UIColor.label.cgColor
        
        cell.contentView.backgroundColor = .secondarySystemGroupedBackground
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var pharmacyProfile: PharmacyProfileVC?
        
        if(isSearchActive == true && pharmacyListHelperVC.searchResults.count != 0){
            pharmacyProfile = PharmacyProfileVC(pharmacy: pharmacyListHelperVC.searchResults[indexPath.row])
        }
        else{
            pharmacyProfile = PharmacyProfileVC(pharmacy: pharmacyListHelperVC.pharmacies[indexPath.row])
        }
        
        guard let pharmacyProfile = pharmacyProfile else {
            return
        }

        navigationController?.pushViewController(pharmacyProfile, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
        else{
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        noSearchResultImageView.alpha = 0
        noSearchResultHeader.alpha = 0
        noSearchResultBody.alpha = 0
        
        if(searchController.isActive && searchController.searchBar.text?.count != 0 && pharmacyListHelperVC.searchResults.count != 0){
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
            
            reusableView.searchResults = "\(pharmacyListHelperVC.searchResults.count) / \(pharmacyListHelperVC.pharmacies.count) Search Results"
            
            if(!isSearchActive) {
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
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return contextMenuFor(indexPath: indexPath)
    }
}

extension PharmacyListVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
        isSearchActive = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        isSearchActive = false
        
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pharmacyListHelperVC.loadSearchResults(forText: searchText)
        
        collectionView.reloadData()
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

extension PharmacyListVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Pharmacies"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
    }
}
