//
//  CartVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 20/12/22.
//

import UIKit

class CartVC: UIViewController, CartProtocol, EditCartObjectDetailProtocol, CartCheckoutProtocol {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(CartVCItemCollectionViewCell.self, forCellWithReuseIdentifier: CartVCItemCollectionViewCell.identifier)
        
        collectionView.register(CartCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CartCollectionReusableView.identifier)
        
        collectionView.register(CollectionViewSearchFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewSearchFooterReusableView.identifier)
        
        collectionView.register(CollectionCartHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionCartHeaderReusableView.identifier)
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    lazy var emptyCartImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "No Items")?.withTintColor(.label, renderingMode: .alwaysOriginal))
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var emptyCartLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.contentMode = .center
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .label
        label.font = UIFont(name: "Helvatica", size: 15)
        
        label.text = "Looks like you haven't added anything to your cart yet."
        
        return label
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        
        searchController.searchBar.delegate = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.showsScopeBar = true
        
        searchController.searchBar.scopeButtonTitles = ["Current Orders", "Previous Orders"]
        searchController.searchBar.selectedScopeButtonIndex = 0
        
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
    
    let cartHelper: CartHelperVC
    var collectionViewCellColor: UIColor = .white
    
    var filterBarButton: UIBarButtonItem = UIBarButtonItem()
    var searchBarButton: UIBarButtonItem = UIBarButtonItem()
    var footerView: CartCollectionReusableView?
    
    init() {
        cartHelper = CartHelperVC()
        
        super.init(nibName: nil, bundle: nil)
        
        cartHelper.delegate = self
        
        if #available(iOS 16, *) {
            filterBarButton = UIBarButtonItem(
                title: nil,
                image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
                primaryAction: nil,
                menu: getMenu(withSelectedState: .productUnPurchased))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        navigationItem.searchController = searchController
        
        if #available(iOS 16, *) {
            if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                navigationItem.rightBarButtonItem = filterBarButton
            }
        }
        
        self.title = "Cart"
        
        view.addSubview(collectionView)
        view.addSubview(emptyCartLabel)
        view.addSubview(emptyCartImageView)
        view.addSubview(noSearchResultImageView)
        view.addSubview(noSearchResultHeader)
        view.addSubview(noSearchResultBody)
        
        configureCollectionView()
        configureSearchBar()
        
        loadContents()
        
        addRightSwipeGesture(toView: collectionView)
        addLeftSwipeGesture(toView: collectionView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            if #available(iOS 16, *) {
                if(!searchController.isActive) {
                    navigationItem.rightBarButtonItem = filterBarButton
                }
            }
        }
        else{
            navigationItem.rightBarButtonItem = nil
        }
        collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.reloadData()
    }
    
    func loadContents() {
        loadCollectionView()
        loadEmptyCartLabel()
        loadEmptyCartImageView()
        loadNoSearchResultImageView()
        loadNoSearchResultHeader()
        loadNoSearchResultBody()
    }
    
    func getMenu(withSelectedState: ProductStatus) -> UIMenu {
        
        let currentOrderAction = UIAction(title: "Current Orders") { action in
            self.searchBar(self.searchController.searchBar, selectedScopeButtonIndexDidChange: 0)
            self.searchController.searchBar.selectedScopeButtonIndex = 0
        }
        
        let previousOrderAction = UIAction(title: "Previous Orders") { action in
            self.searchBar(self.searchController.searchBar, selectedScopeButtonIndexDidChange: 1)
            self.searchController.searchBar.selectedScopeButtonIndex = 1
        }
        
        switch(withSelectedState) {
        case .productUnPurchased:
            currentOrderAction.state = .on
        case .productPurchased:
            previousOrderAction.state = .on
        }
        
        let menu = UIMenu(title: "", options: .singleSelection, children: [currentOrderAction, previousOrderAction])
        
        return menu
    }
    
    func configureSearchBar() {
        searchController.searchBar.delegate = self
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func addRightSwipeGesture(toView: UIView) {
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.numberOfTouchesRequired = 1
        swipeGesture.direction = .right
        
        if(toView == collectionView) {
            swipeGesture.addTarget(self, action: #selector(didSwipeRight))
        }
        
        toView.addGestureRecognizer(swipeGesture)
    }
    
    func addLeftSwipeGesture(toView: UIView) {
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.numberOfTouchesRequired = 1
        swipeGesture.direction = .left
        
        if(toView == collectionView) {
            swipeGesture.addTarget(self, action: #selector(didSwipeLeft))
        }
        
        toView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        searchController.searchBar.selectedScopeButtonIndex = 0
        searchBar(searchController.searchBar, selectedScopeButtonIndexDidChange: 0)
    }
    
    @objc func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        searchController.searchBar.selectedScopeButtonIndex = 1
        searchBar(searchController.searchBar, selectedScopeButtonIndexDidChange: 1)
    }
    
    func loadCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .systemGroupedBackground
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func loadEmptyCartImageView() {
        emptyCartImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyCartImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            emptyCartImageView.widthAnchor.constraint(equalToConstant: 100),
            emptyCartImageView.heightAnchor.constraint(equalTo: emptyCartImageView.widthAnchor, multiplier: 1),
            emptyCartImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func loadEmptyCartLabel() {
        emptyCartLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyCartLabel.alpha = 0
        
        NSLayoutConstraint.activate([
            emptyCartLabel.topAnchor.constraint(equalTo: emptyCartImageView.bottomAnchor, constant: 5),
            emptyCartLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            emptyCartLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
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
    
    func getDataAndReloadCollectionView() {
        cartHelper.getProductsAddedToCart()
        collectionView.reloadData()
    }
    
    func configureContextMenu(indexPath: IndexPath) -> UIContextMenuConfiguration {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [self] (action) -> UIMenu? in
            let edit = UIAction(title: "Edit",
                                image: UIImage(systemName: "square.and.pencil"),
                                identifier: nil,
                                discoverabilityTitle: nil,
                                state: .off) { (_) in
                print("edit button clicked")
                
                print(self.cartHelper.productsAddedToCartYetToBePurchased[indexPath.row])
                
                let editCart = EditCartVC(cart: self.cartHelper.productsAddedToCartYetToBePurchased[indexPath.row], indexPath: indexPath)
                editCart.delegate = self
                
                self.present(editCart, animated: true)
            }
                        
            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive,
                                  state: .off) { (_) in
                print("delete button clicked")
                
                let alertController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
                
                alertController.addAction(UIAlertAction(title: "Delete", style: .destructive){_ in
                    self.cartHelper.deleteItemFromCart(atIndex: indexPath)
                    self.collectionView.reloadData()
                    
                    if(self.cartHelper.selectedState == .productUnPurchased) {
                        self.updateTotal(forFooterView: self.footerView)
                    }
                })
                
                self.present(alertController, animated: true)
            }
            
            let bookAgain = UIAction(title: "Re-Order",
                                  image: UIImage(systemName: "repeat"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  state: .off) { (_) in
                print("Re-Order button clicked")
                
                guard let cell = self.collectionView.cellForItem(at: indexPath) as? CartVCItemCollectionViewCell,
                      let cart = cell.cart else {
                    return
                }
                
                self.cartHelper.getProductDetails(forProductId: cart.productId, forPharmacyId: cart.pharmacyId)
                
                guard let product = self.cartHelper.productInfo else {
                    return
                }
                
                let productVC = PharmacyProductVC(product: product, pharmacyId: cart.pharmacyId)
                productVC.delegate = self
                productVC.isFromReOrdering = true
                
                self.present(productVC, animated: true)
            }
            
            var children: [UIAction] = []
            
            switch(cartHelper.selectedState) {
            case .productUnPurchased:
                children = [edit, delete]
            case .productPurchased:
                children = [bookAgain, delete]
            }
            
            return UIMenu(title: "", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: children)
        }
        
        return contextMenu
    }
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func  updateTheMedCountAndChangeQuantityInDb(forIndexPath: IndexPath, toValue: Int) {
        guard let cell = collectionView.cellForItem(at: forIndexPath) as? CartVCItemCollectionViewCell else {
            return
        }
        
        cell.quantity = toValue
        
        guard let cart = cell.cart else {
            return
        }
            
        if(searchController.isActive){
            for index in 0..<cartHelper.productsAddedToCartYetToBePurchased.count {
                if(cartHelper.productsAddedToCartYetToBePurchased[index].productName == cartHelper.yetToPurchaseSearchProducts[forIndexPath.row].productName) {
                    cartHelper.productsAddedToCartYetToBePurchased[index].productQuantity = toValue
                    cartHelper.yetToPurchaseSearchProducts[forIndexPath.row].productQuantity = toValue
                    break
                }
            }
        }
        else{
            cartHelper.productsAddedToCartYetToBePurchased[forIndexPath.row].productQuantity = toValue
        }
        cartHelper.updateMedicineQuantity(forMedName: cart.productName, forMedCost: cart.productCost, toValue: toValue, state: cart.productStatus)
        
        if(cartHelper.productsAddedToCartYetToBePurchased[forIndexPath.row].productQuantity == 50) {
            cell.shouldShowMaxLimitReachedLabel(true)
        }
        else{
            cell.shouldShowMaxLimitReachedLabel(false)
        }
        
        updateTotal(forFooterView: footerView)
    }
    
    func updateTotal(forFooterView: CartCollectionReusableView?) {
        guard let footerView = forFooterView else {
            return
        }
        
        guard let subTotal = Double(String(format: "%.2f", cartHelper.getTotalCost())),
              let differentialCost = Double(String(format: "%.2f", cartHelper.getDifferentialCost(forValue: subTotal))) else {
            return
        }
        
        let total = subTotal - differentialCost
        
        footerView.subtotalValueLabel.text = "Rs.\(subTotal)"
        footerView.offersAppliedValueLabel.text = "- Rs.\(differentialCost)"
        footerView.totalValueLabel.text = "Rs.\(total)"
    }
    
    func didTapCheckOut() {
        print("Check Out Tapped.")
        
        let addressCartVC = UserCartAddressVC()
        addressCartVC.delegate = self
        
        present(addressCartVC, animated: true)
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

extension CartVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch(cartHelper.selectedState) {
        case .productUnPurchased:
            return 1
        case .productPurchased:
            if(searchController.isActive) {
                if(searchController.searchBar.text?.count != 0) {
                    noSearchResultImageView.alpha = 1
                    noSearchResultHeader.alpha = 1
                    noSearchResultBody.alpha = 1
                    emptyCartLabel.alpha = 0
                    emptyCartImageView.alpha = 0
                }
                else {
                    noSearchResultImageView.alpha = 0
                    noSearchResultHeader.alpha = 0
                    noSearchResultBody.alpha = 0
                    emptyCartLabel.alpha = 1
                    emptyCartImageView.alpha = 0
                }
                
                return cartHelper.purchasedSearchProducts.count
            }
            
            if(cartHelper.productsAddedToCartPurchased.count == 0){
                noSearchResultImageView.alpha = 0
                noSearchResultHeader.alpha = 0
                noSearchResultBody.alpha = 0
                emptyCartLabel.alpha = 1
                emptyCartImageView.alpha = 1
            }
            
            return cartHelper.productsAddedToCartPurchased.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var array:[Cart] = []
        
        switch(cartHelper.selectedState){
        case .productPurchased:
            array = cartHelper.productsAddedToCartPurchased[section]
        case .productUnPurchased:
            array = cartHelper.productsAddedToCartYetToBePurchased
        }
        
        if(array.count == 0) {
            emptyCartLabel.alpha = 1
            emptyCartImageView.alpha = 1
        }
        else{
            emptyCartLabel.alpha = 0
            emptyCartImageView.alpha = 0
        }
        
        if(searchController.isActive) {
            switch(cartHelper.selectedState) {
            case .productPurchased:
                return cartHelper.purchasedSearchProducts[section].count
            case .productUnPurchased:
                return cartHelper.yetToPurchaseSearchProducts.count
            }
        }
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartVCItemCollectionViewCell.identifier, for: indexPath) as? CartVCItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .secondarySystemGroupedBackground
        cell.layer.cornerRadius = 10
        
        if(searchController.isActive) {
            switch(cartHelper.selectedState){
            case .productUnPurchased:
                cell.cart = cartHelper.yetToPurchaseSearchProducts[indexPath.row]
                
                let text = highlight(fromSource: searchController.searchBar.text ?? "", toTarget: cell.productNameLabel.text ?? "")
                
                cell.productNameLabel.attributedText = text
                
                if(cartHelper.yetToPurchaseSearchProducts[indexPath.row].productQuantity == 50) {
                    cell.shouldShowMaxLimitReachedLabel(true)
                }
                else{
                    cell.shouldShowMaxLimitReachedLabel(false)
                }
            case .productPurchased:
                cell.cart = cartHelper.purchasedSearchProducts[indexPath.section][indexPath.row]
                
                let text = highlight(fromSource: searchController.searchBar.text ?? "", toTarget: cell.productNameLabel.text ?? "")
                
                cell.productNameLabel.attributedText = text
                cell.shouldShowMaxLimitReachedLabel(false)
            }
        }
        else{
            if(cartHelper.selectedState == .productUnPurchased) {
                cell.cart = cartHelper.productsAddedToCartYetToBePurchased[indexPath.row]
                
                if(cartHelper.productsAddedToCartYetToBePurchased[indexPath.row].productQuantity == 50) {
                    cell.shouldShowMaxLimitReachedLabel(true)
                }
                else{
                    cell.shouldShowMaxLimitReachedLabel(false)
                }
            }
            else{
                cell.cart = cartHelper.productsAddedToCartPurchased[indexPath.section][indexPath.row]
            }
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            if(cartHelper.productsAddedToCartYetToBePurchased.count == 1 && cartHelper.selectedState == .productUnPurchased){
                return CGSize(width: view.frame.width - 20, height: view.frame.height / 9)
            }
            else{
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    return CGSize(width: (view.frame.width/3) - 15, height: view.frame.height / 8)
                }
                return CGSize(width: (view.frame.width/2) - 10, height: view.frame.height / 9)
            }
        }
        else{
            if(UITraitCollection.current.userInterfaceIdiom == .pad){
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    return CGSize(width: (view.frame.width) - 20, height: view.frame.height / 8)
                }
                return CGSize(width: view.frame.width - 20, height: view.frame.height / 9)
            }
            else{
                return CGSize(width: view.frame.width - 20, height: view.frame.height / 6.5)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch(kind){
        case UICollectionView.elementKindSectionHeader:
            guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionCartHeaderReusableView.identifier, for: indexPath) as? CollectionCartHeaderReusableView else {
                return UICollectionReusableView()
            }
            
            if(searchController.isActive) {
                reusableView.label.text = cartHelper.purchasedProductSearchDates[indexPath.section]
            }
            else {
                reusableView.label.text = cartHelper.sortedDates[indexPath.section]
            }
            
            return reusableView
        case UICollectionView.elementKindSectionFooter:
            
            if(searchController.isActive) {
                guard let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewSearchFooterReusableView.identifier, for: indexPath) as? CollectionViewSearchFooterReusableView else {
                    return UICollectionReusableView()
                }
                
                
                
                switch(cartHelper.selectedState) {
                case .productPurchased:
                    reusableView.searchResults = "\(cartHelper.getCountOfSearchedPurchasedProducts()) / \(cartHelper.getCountOfPurchasedProducts()) Search Results"
                case .productUnPurchased:
                    reusableView.searchResults = "\(cartHelper.yetToPurchaseSearchProducts.count) / \(cartHelper.productsAddedToCartYetToBePurchased.count) Search Results"
                }
                
                if(!searchController.isActive) {
                    reusableView.label.alpha = 0
                }
                else{
                    reusableView.label.alpha = 1
                }
                
                return reusableView
            }
            else {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CartCollectionReusableView.identifier, for: indexPath) as? CartCollectionReusableView else {
                    return UICollectionReusableView()
                }
                
                footer.delegate = self
                footer.contentView.backgroundColor = .secondarySystemGroupedBackground
                
                footerView = footer
                
                updateTotal(forFooterView: footer)
                
                return footer
            }
        default:
            ()
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(cartHelper.selectedState == .productUnPurchased) {
            var cart = self.cartHelper.productsAddedToCartYetToBePurchased[0]
            
            if(searchController.isActive && searchController.searchBar.text?.count != 0) {
                cart = self.cartHelper.yetToPurchaseSearchProducts[indexPath.row]
            }
            else{
                cart = self.cartHelper.productsAddedToCartYetToBePurchased[indexPath.row]
            }
            
            let editCart = EditCartVC(cart: cart, indexPath: indexPath)
            editCart.delegate = self
            
            self.present(editCart, animated: true)
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return configureContextMenu(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(cartHelper.selectedState == .productPurchased) {
            return CGSize(width: view.frame.width, height: 30)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        noSearchResultImageView.alpha = 0
        noSearchResultHeader.alpha = 0
        noSearchResultBody.alpha = 0
        
        if(searchController.isActive){
            switch(cartHelper.selectedState) {
            case .productPurchased:
                if(cartHelper.purchasedSearchProducts.count != 0 && searchController.searchBar.text?.count != 0) {
                    if(section == cartHelper.purchasedSearchProducts.count - 1) {
                        return CGSize(width: view.frame.width, height: 20)
                    }
                    return .zero
                }
                else{
                    if(searchController.searchBar.text?.count != 0) {
                        noSearchResultImageView.alpha = 1
                        noSearchResultHeader.alpha = 1
                        noSearchResultBody.alpha = 1
                        emptyCartLabel.alpha = 0
                        emptyCartImageView.alpha = 0
                    }
                    return .zero
                }
            case .productUnPurchased:
                if(cartHelper.yetToPurchaseSearchProducts.count != 0 && searchController.searchBar.text?.count != 0){
                    return CGSize(width: view.frame.width, height: 20)
                }
                else{
                    if(searchController.searchBar.text?.count != 0) {
                        noSearchResultImageView.alpha = 1
                        noSearchResultHeader.alpha = 1
                        noSearchResultBody.alpha = 1
                        emptyCartLabel.alpha = 0
                        emptyCartImageView.alpha = 0
                    }
                    return .zero
                }
            }
        }
        else{
            if(cartHelper.selectedState == .productPurchased) {
                return .zero
            }
            
            if(cartHelper.productsAddedToCartYetToBePurchased.count != 0 && !searchController.isActive){
                if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
                    return CGSize(width: 600, height: 170)
                }
                else {
                    return CGSize(width: view.frame.width, height: 170)
                }
            }
            return .zero
        }
    }
}

extension CartVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        cartHelper.selectedState = ProductStatus(rawValue: selectedScope) ?? .productPurchased
        
        if #available(iOS 16, *) {
            filterBarButton.menu = getMenu(withSelectedState: ProductStatus(rawValue: selectedScope) ?? .productUnPurchased)
        }
        
        switch(cartHelper.selectedState){
        case .productPurchased:
            emptyCartLabel.text = "Previous order list is Empty."
        case .productUnPurchased:
            emptyCartLabel.text = "Looks like you haven't added anything to your cart yet."
        }
        
        if(searchController.isActive) {
            cartHelper.getSearchResults(forText: searchController.searchBar.text ?? "")
        }
        
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if #available(iOS 16, *) {
            navigationItem.rightBarButtonItem = nil
        }
        
        cartHelper.getSearchResults(forText: searchText)
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if #available(iOS 16, *) {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        if #available(iOS 16, *) {
            if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                navigationItem.rightBarButtonItem = filterBarButton
            }
        }
        collectionView.reloadData()
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension CartVC: ViewInCartProtocol {
    func showCartVC() {
        cartHelper.getProductsAddedToCart()
        searchBar(searchController.searchBar, selectedScopeButtonIndexDidChange: 0)
        self.searchController.searchBar.selectedScopeButtonIndex = 0
    }
}

extension CartVC: CartCheckOutCompletionProtocol {
    func didCompleteCheckOut() {
        cartHelper.didCompleteCheckOut()
        collectionView.reloadData()
    }
    
    func didCancelPayment() {
        ()
    }
}

extension CartVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDataAndReloadCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
}
