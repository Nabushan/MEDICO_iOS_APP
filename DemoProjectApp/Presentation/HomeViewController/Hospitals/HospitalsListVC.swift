//
//  HospitalsListVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/12/22.
//

import UIKit

class HospitalsListVC: UIViewController, HospitalsListingProtocol {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(HospitalListCollectionViewCell.self, forCellWithReuseIdentifier: HospitalListCollectionViewCell.identifier)
        
        collectionView.register(CollectionViewSearchFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewSearchFooterReusableView.identifier)
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        
        searchController.searchBar.delegate = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        return searchController
    }()
    
    lazy var viewForPickerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
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
    
    var toolBar: UIToolbar!
    
    var filterBarButton: UIBarButtonItem = UIBarButtonItem()
    var searchBarButton: UIBarButtonItem = UIBarButtonItem()
    var doneBarButton: UIBarButtonItem = UIBarButtonItem()
    
    let hospitalListHelper: HospitalsListHelper
    var previousTitle: String = "Hospitals"
    
    init() {
        hospitalListHelper = HospitalsListHelper()
        
        super.init(nibName: nil, bundle: nil)
        
        hospitalListHelper.delegate = self
        
        filterBarButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .done, target: self, action: #selector(didTapFilterIcon))
        
        doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didtapDoneButton))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = collectionView.backgroundColor
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = filterBarButton
        
        toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolBar.sizeToFit()
        
        view.addSubview(collectionView)
        view.addSubview(noSearchResultImageView)
        view.addSubview(noSearchResultHeader)
        view.addSubview(noSearchResultBody)
        
        view.addSubview(viewForPickerView)
        viewForPickerView.addSubview(toolBar)
        viewForPickerView.addSubview(pickerView)
        
        configureCollectionView()
        configurePickerView()
        configureSearchBar()
        
        loadContents()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        collectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.reloadData()
    }
    
    func loadContents() {
        loadCollectionView()
        loadPickerView()
        loadNoSearchResultImageView()
        loadNoSearchResultHeader()
        loadNoSearchResultBody()
    }

    @objc func didTapFilterIcon(_ sender: UIBarButtonItem) {
        viewForPickerView.isHidden = false
        
    }
    
    @objc func didTapDoneButton(_ sender: UIBarButtonItem) {
        
        viewForPickerView.isHidden = true
        
        navigationItem.leftBarButtonItems = []
        navigationItem.rightBarButtonItems = [filterBarButton, searchBarButton]
    }
    
    @objc func didtapDoneButton(_ sender: UIBarButtonItem) {
        viewForPickerView.isHidden = true
        
        navigationItem.leftBarButtonItems = []
        navigationItem.rightBarButtonItems = [filterBarButton, searchBarButton]
    }
    
    func configureSearchBar() {
        searchController.searchBar.delegate = self
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexibleSpace, doneBarButton], animated: true)
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
    
    func loadPickerView() {
        viewForPickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.sizeToFit()
        viewForPickerView.isHidden = true
        
        viewForPickerView.backgroundColor = collectionView.backgroundColor
        
        var toolBarHeight = CGFloat(50)
        
        NSLayoutConstraint.activate([
            viewForPickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            viewForPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewForPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            viewForPickerView.heightAnchor.constraint(equalToConstant: (0.3 * view.frame.height) + toolBarHeight),
            
            pickerView.widthAnchor.constraint(equalTo: viewForPickerView.widthAnchor),
            pickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            pickerView.centerXAnchor.constraint(equalTo: viewForPickerView.centerXAnchor),
            pickerView.bottomAnchor.constraint(equalTo: viewForPickerView.bottomAnchor),
            
            toolBar.bottomAnchor.constraint(equalTo: pickerView.topAnchor),
            toolBar.centerXAnchor.constraint(equalTo: viewForPickerView.centerXAnchor),
            toolBar.widthAnchor.constraint(equalTo: viewForPickerView.widthAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: toolBarHeight)
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

extension HospitalsListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchController.isActive) {
            return hospitalListHelper.searchedHospitals.count
        }
        else {
            return hospitalListHelper.tempHospitals.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HospitalListCollectionViewCell.identifier, for: indexPath) as? HospitalListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if(searchController.isActive && searchController.searchBar.text?.count != 0) {
            cell.hospital = hospitalListHelper.searchedHospitals[indexPath.row]
            
            cell.nameLabel.attributedText = highlight(fromSource: searchController.searchBar.text ?? "", toTarget: hospitalListHelper.searchedHospitals[indexPath.row].name)
        }
        else{
            cell.hospital = hospitalListHelper.tempHospitals[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let hospitalProfileVC = HospitalProfileVC()
        
        if(searchController.isActive && hospitalListHelper.searchedHospitals.count != 0) {
            hospitalProfileVC.hospital = hospitalListHelper.searchedHospitals[indexPath.row]
        }
        else{
            hospitalProfileVC.hospital = hospitalListHelper.tempHospitals[indexPath.row]
        }
        
        present(hospitalProfileVC, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                return CGSize(width: (view.frame.width/3) - 15, height: view.frame.height/8)
            }
            return CGSize(width: (view.frame.width/2) - 15, height: view.frame.height/10)
        }
        else{
            if(UITraitCollection.current.userInterfaceIdiom == .pad){
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    return CGSize(width: (view.frame.width) - 40, height: view.frame.height/8)
                }
                return CGSize(width: view.frame.width - 30, height: view.frame.height/10)
            }
            else{
                return CGSize(width: view.frame.width - 30, height: view.frame.height/6)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            return UIEdgeInsets(top: 5, left: 7.5, bottom: 5, right: 7.5)
        }
        else{
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        noSearchResultImageView.alpha = 0
        noSearchResultHeader.alpha = 0
        noSearchResultBody.alpha = 0
        
        if(searchController.isActive && searchController.searchBar.text?.count != 0 && hospitalListHelper.searchedHospitals.count != 0){
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
            
            reusableView.searchResults = "\(hospitalListHelper.searchedHospitals.count) / \(hospitalListHelper.tempHospitals.count) Search Results"
            
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

extension HospitalsListVC: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewForPickerView.isHidden = true
        
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        hospitalListHelper.getSearchResults(forText: searchText)
        viewForPickerView.isHidden = true
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        collectionView.reloadData()
        viewForPickerView.isHidden = true
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension HospitalsListVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        hospitalListHelper.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        hospitalListHelper.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hospitalListHelper.selectedState = HospitalLocation(rawValue: row) ?? .all
        hospitalListHelper.getFilteredResults()
        collectionView.reloadData()
    }
}

extension HospitalsListVC {
    override func willMove(toParent parent: UIViewController?) {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .always
        self.title = previousTitle
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}
