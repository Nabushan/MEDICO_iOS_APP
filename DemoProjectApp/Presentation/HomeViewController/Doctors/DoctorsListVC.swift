//
//  DoctorsListVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 29/09/22.
//

import UIKit

class DoctorsListVC: UIViewController, DoctorListVCProtocol {
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        
        searchController.searchBar.delegate = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search"
        
        return searchController
    }()
    
    lazy var doctorView = UIView()
    
    lazy var doctorCollectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(DoctorListCollectionViewCell.self, forCellWithReuseIdentifier: DoctorListCollectionViewCell.identifier)
        
        collectionView.register(CollectionViewSearchFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewSearchFooterReusableView.identifier)
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    lazy var customBarButtonStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
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
    
    let doctorListVCHelper: DoctorsListVCHelper
    
    var previousTitle: String = "All Doctors"
    
    var filterBarButton: UIBarButtonItem = UIBarButtonItem()
    var searchBarButton: UIBarButtonItem = UIBarButtonItem()
    var spaceBarButton: UIBarButtonItem = UIBarButtonItem()
    var previouslySelectedConstraints: [NSLayoutConstraint] = []
    
    
    
    
    var customRightBarButtonView: UIBarButtonItem = UIBarButtonItem()
    
    var collectionViewCellColor: UIColor?
    
    weak var delegate: SplitViewCommunicationProtocol?
    
    init(selectedState: DoctorSpecialization){
        doctorListVCHelper = DoctorsListVCHelper(selectedState: selectedState)
        
        doctorListVCHelper.selectedDesignatedState = selectedState
        previousTitle = selectedState.specializationType
        
        super.init(nibName: nil, bundle: nil)
        
        doctorListVCHelper.delegate = self

        filterBarButton = UIBarButtonItem(
            title: nil,
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            primaryAction: nil,
            menu: getMenu(forSelectedState: selectedState))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        self.title = previousTitle
        
        view.addSubview(doctorView)
        doctorView.addSubview(doctorCollectionView)
        view.addSubview(noSearchResultImageView)
        view.addSubview(noSearchResultHeader)
        view.addSubview(noSearchResultBody)
        
        navigationItem.rightBarButtonItem = filterBarButton
        navigationItem.searchController = searchController
        
        configureDelegates()
        
        loadContents()
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previouslySelectedConstraints)
        loadContents()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        doctorCollectionView.reloadData()
    }
    
    func loadContents() {
        loadLowerViewForDoctor()
        loadDoctorCollectionView()
        loadNoSearchResultImageView()
        loadNoSearchResultHeader()
        loadNoSearchResultBody()
        doctorCollectionView.reloadData()
    }
    
    func getMenu(forSelectedState: DoctorSpecialization) -> UIMenu {
        let allAction = UIAction(
            title: "All Doctors") { [weak self] _ in
                print("All Doctors Selected.")
                
                self?.previousTitle = "All Doctors"
                self?.title = self?.previousTitle
                
                self?.doctorListVCHelper.selectedDesignatedState = .all
                self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .all)

                self?.doctorCollectionView.reloadData()
            }
        
        let CardiologistAction = UIAction(title: "Cardiologists") { [weak self] _ in
            print("Cardiologist Selected")
            
            self?.previousTitle = "Cardiologists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .cardiologist
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .cardiologist)

            self?.doctorCollectionView.reloadData()
        }
        
        let NephrologistAction = UIAction(title: "Nephrologists") { [weak self] _ in
            print("Nephrologist Selected")
            
            self?.previousTitle = "Nephrologists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .nephrologist
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .nephrologist)

            self?.doctorCollectionView.reloadData()
        }
        
        let ImmunologistAction = UIAction(title: "Immunologists") { [weak self] _ in
            print("Immunologist Selected")
            
            self?.previousTitle = "Immunologists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .immunologists
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .immunologists)

            self?.doctorCollectionView.reloadData()
        }
        
        let GastroenterologistAction = UIAction(title: "Gastroenterologists") { [weak self] _ in
            print("Gastroenterologist Selected")
            
            self?.previousTitle = "Gastroenterologists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .gastroenterologist
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .gastroenterologist)

            self?.doctorCollectionView.reloadData()
        }
        
        let DentistAction = UIAction(title: "Dentists") { [weak self] _ in
            print("Dentist Selected")
            
            self?.previousTitle = "Dentists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .dentist
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .dentist)

            self?.doctorCollectionView.reloadData()
        }
        
        let NeurologistAction = UIAction(title: "Neurologists") { [weak self] _ in
            print("Neurologist Selected")
            
            self?.previousTitle = "Neurologists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .neurologist
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .neurologist)

            self?.doctorCollectionView.reloadData()
        }
        
        let OrthopaedicsAction = UIAction(title: "Orthopaedics") { [weak self] _ in
            print("Orthopaedics Selected")
            
            self?.previousTitle = "Orthopaedics"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .orthopaedics
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .orthopaedics)

            self?.doctorCollectionView.reloadData()
        }
        
        let DermatologistAction = UIAction(title: "Dermatologists") { [weak self] _ in
            print("Dermatologist Selected")
            
            self?.previousTitle = "Dermatologists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .dermatologist
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .dermatologist)

            self?.doctorCollectionView.reloadData()
        }
        
        let TrichologistAction = UIAction(title: "Trichologists") { [weak self] _ in
            print("Trichologist Selected")
            
            self?.previousTitle = "Trichologists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .trichologist
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .trichologist)

            self?.doctorCollectionView.reloadData()
        }
        
        let GynacologistAction = UIAction(title: "Gynacologists") { [weak self] _ in
            print("Gynacologist Selected")
            
            self?.previousTitle = "Gynacologists"
            self?.title = self?.previousTitle
            
            self?.doctorListVCHelper.selectedDesignatedState = .gynacologist
            self?.doctorListVCHelper.loadDetails(forSearchText: self?.searchController.searchBar.text ?? "", designation: .gynacologist)

            self?.doctorCollectionView.reloadData()
        }
        
        switch(forSelectedState) {
        case .all:
            allAction.state = .on
        case .cardiologist:
            CardiologistAction.state = .on
        case .nephrologist:
            NephrologistAction.state = .on
        case .immunologists:
            ImmunologistAction.state = .on
        case .gastroenterologist:
            GastroenterologistAction.state = .on
        case .dentist:
            DentistAction.state = .on
        case .neurologist:
            NeurologistAction.state = .on
        case .orthopaedics:
            OrthopaedicsAction.state = .on
        case .dermatologist:
            DermatologistAction.state = .on
        case .trichologist:
            TrichologistAction.state = .on
        case .gynacologist:
            GynacologistAction.state = .on
        }
        
        let menu =  UIMenu(
            image: nil,
            identifier: nil,
            options: .singleSelection,
            children: [allAction, CardiologistAction, NephrologistAction, ImmunologistAction, GastroenterologistAction, DentistAction, NeurologistAction, OrthopaedicsAction, DermatologistAction, TrichologistAction, GynacologistAction])
        
        return menu
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            doctorCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 50, right: 0)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        doctorCollectionView.contentInset = .zero
    }
    
    func configureDelegates() {
        doctorCollectionView.delegate = self
        doctorCollectionView.dataSource = self
    }
    
    @objc func didTapFilter(_ sender: UIBarButtonItem){
        print("Filter tapped")
    }
    
    func loadLowerViewForDoctor() {
        doctorView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            doctorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            doctorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 0),
            doctorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: 0),
            doctorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previouslySelectedConstraints.append(constraint)
        }
    }
    
    func loadDoctorCollectionView() {
        doctorCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        doctorCollectionView.backgroundColor = .systemGroupedBackground
        
        let constraints = [
            doctorCollectionView.topAnchor.constraint(equalTo: doctorView.topAnchor),
            doctorCollectionView.leadingAnchor.constraint(equalTo: doctorView.leadingAnchor),
            doctorCollectionView.trailingAnchor.constraint(equalTo: doctorView.trailingAnchor),
            doctorCollectionView.bottomAnchor.constraint(equalTo: doctorView.bottomAnchor,constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previouslySelectedConstraints.append(constraint)
        }
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
}

extension DoctorsListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        doctorListVCHelper.loadDetails(forSearchText: searchText, designation: doctorListVCHelper.selectedDesignatedState)
        
        doctorCollectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        doctorListVCHelper.loadDetails(forSearchText: searchBar.text ?? "", designation: doctorListVCHelper.selectedDesignatedState)
        
        doctorCollectionView.reloadData()
        
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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

extension DoctorsListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchController.isActive == false){
            if(doctorListVCHelper.selectedDesignatedState == .all){
                return doctorListVCHelper.doctors.count
            }
            else{
                return doctorListVCHelper.tempDoctors.count
            }
        }
        else{
            return doctorListVCHelper.tempDoctors.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == doctorCollectionView){
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    return CGSize(width: doctorView.frame.width/3 - 10, height: doctorView.frame.height/6.5)
                }
                return CGSize(width: doctorView.frame.width/2 - 10, height: doctorView.frame.height/8)
            }
            else{
                if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                    if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                        return CGSize(width: doctorView.frame.width - 20, height: doctorView.frame.height/6.5)
                    }
                    return CGSize(width: doctorView.frame.width - 10, height: doctorView.frame.height/8)
                }
                else {
                    return CGSize(width: doctorView.frame.width - 30, height: doctorView.frame.height/5)
                }
            }
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DoctorListCollectionViewCell.identifier, for: indexPath) as? DoctorListCollectionViewCell else {
            return UICollectionViewCell()
        }
            
        cell.backgroundColor = .secondarySystemGroupedBackground
        cell.layer.cornerRadius = 10
            
        var doctor: Doctor
            
        if(searchController.isActive == false){
            if(doctorListVCHelper.selectedDesignatedState == .all){
                doctor = doctorListVCHelper.doctors[indexPath.row]
            }
            else{
                doctor = doctorListVCHelper.tempDoctors[indexPath.row]
            }
        }
        else{
            doctor = doctorListVCHelper.tempDoctors[indexPath.row]
        }
        
        cell.docName = highlight(fromSource: searchController.searchBar.text ?? "", toTarget: doctor.name)
        cell.qualification = doctor.qualification
        cell.imageName = doctor.imageName
        cell.rating = doctor.ratings
        cell.totalRaters = doctor.totalNumberOfRaters
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var doctor: Doctor?
        
        if(searchController.isActive == false){
            if(doctorListVCHelper.selectedDesignatedState == .all){
                doctor = doctorListVCHelper.doctors[indexPath.row]
            }
            else{
                doctor = doctorListVCHelper.tempDoctors[indexPath.row]
            }
        }
        else{
            doctor = doctorListVCHelper.tempDoctors[indexPath.row]
        }
        
        guard let doctor = doctor else {
            return
        }
        
        let doctorProfileVC = DoctorProfileVC(doctor: doctor, isFromBookAgain: false)
        
        navigationController?.pushViewController(doctorProfileVC, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(collectionView == doctorCollectionView){
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let contextMenuConfiguration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { menu in
            let shareProfileAction = UIAction(title: "Share Profile",
                                              image: UIImage(systemName: "square.and.arrow.up"),
                                              identifier: nil) {[weak self] action in
                
                guard let doctorDetail = self?.doctorListVCHelper.doctors[indexPath.row] else {
                    return
                }
                
                let shareProfileVC = ShareDoctorProfileVC(doctor: doctorDetail)
                
                self?.present(shareProfileVC, animated: true, completion: nil)
            }
            
            let menu = UIMenu(title: "",
                              options: .singleSelection,
                              children: [shareProfileAction])
            
            return menu
        }
        
        return contextMenuConfiguration
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        noSearchResultImageView.alpha = 0
        noSearchResultHeader.alpha = 0
        noSearchResultBody.alpha = 0
        
        if(searchController.isActive && searchController.searchBar.text?.count != 0 && doctorListVCHelper.tempDoctors.count != 0){
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
            
            reusableView.searchResults = "\(doctorListVCHelper.tempDoctors.count) / \(doctorListVCHelper.doctors.count) Search Results"
            
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

extension DoctorsListVC {
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationItem.largeTitleDisplayMode = .never
    }
}
