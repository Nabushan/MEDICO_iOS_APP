//
//  AppointmentsListVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 26/10/22.
//

import UIKit

class AppointmentsListVC: UIViewController, AppointmentListProtocol {

    lazy var upcomingButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Upcoming", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        
        return button
    }()
    
    lazy var completedButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Completed", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        
        return button
    }()
    
    lazy var cancelledButton: ResizedButton = {
        let button = ResizedButton()
        
        button.setTitle("Cancelled", for: .normal)
        button.setTitleColor(UIColor.secondaryLabel, for: .normal)
        
        return button
    }()
    
    lazy var customSegmentedStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.contentMode = .center
        
        return stackView
    }()
    
    lazy var selectorLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var selectedLineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        
        return searchBar
    }()
    
    lazy var noAppointmentImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "No Appointment")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var noAppointmentHeader: ResizedLabel = {
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
    
    lazy var noAppointmentBody: ResizedLabel = {
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
    
    lazy var appointmentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.register(CompletedAndUpcomingAppointmentsListTableViewCell.self, forCellReuseIdentifier: CompletedAndUpcomingAppointmentsListTableViewCell.identifier)
        
        tableView.register(CancelledAppointmentsListTableViewCell.self, forCellReuseIdentifier: CancelledAppointmentsListTableViewCell.identifier)
        
        tableView.keyboardDismissMode = .onDrag
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "dd-MM-yyyy"
        
        return formatter
    }()
    
    lazy var footerView: UIView = {
        let view = UIView()
        
        
        return view
    }()
    
    lazy var footerLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.font = UIFont(name: "Helvetica", size: 15)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.contentMode = .center
        
        return label
    }()
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelDuringSearch))
        
        return barButton
    }()
    
    var filterBarButton: UIBarButtonItem = UIBarButtonItem()
    var searchBarButton: UIBarButtonItem = UIBarButtonItem()
    var fixedSpaceBarButton: UIBarButtonItem = UIBarButtonItem()
    
    var binBarButton = UIBarButtonItem()
    
    var selectedLineViewConstraint: NSLayoutConstraint?
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    var isSearchBarActive: Bool = false
    var appointmentsListHelperVC: AppointmentsListHelperVC
    
    var tableViewCellColor: UIColor?
    var swipeCount = -1
    var initialWidth = CGFloat.zero
    
    weak var delegate: SplitViewCommunicationProtocol?
    
    init(){
        
        appointmentsListHelperVC = AppointmentsListHelperVC()
        super.init(nibName: nil, bundle: nil)
        
        appointmentsListHelperVC.delegate = self
        
        searchBarButton = UIBarButtonItem(barButtonSystemItem: .search,
                                              target: self,
                                              action: #selector(didSelectSearchIcon))
        
        filterBarButton = UIBarButtonItem(
            title: nil,
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            primaryAction: nil,
            menu: getMenu())
        
        binBarButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: getEditMenu())
        
        fixedSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpaceBarButton.width = -20
        
        NotificationCenter.default.addObserver(self, selector: #selector(shouldReloadTableView), name: Notification.Name("NotificationIdentifier_StarRating_Updated"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier_StarRating_Updated"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = appointmentTableView.backgroundColor
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            initialWidth = splitViewController?.primaryColumnWidth ?? 0.0
        }
        
        self.title = "My Appointments"
        splitViewController?.delegate = self
        
        view.addSubview(customSegmentedStackView)
        customSegmentedStackView.addArrangedSubview(upcomingButton)
        customSegmentedStackView.addArrangedSubview(completedButton)
        customSegmentedStackView.addArrangedSubview(cancelledButton)
        
        view.addSubview(selectorLineView)
        view.addSubview(selectedLineView)
        view.addSubview(noAppointmentImageView)
        view.addSubview(noAppointmentHeader)
        view.addSubview(noAppointmentBody)
        view.addSubview(appointmentTableView)
        
        configureDelegates()
        searchBarShould(show: false)
        loadContents()
        loadButtons()
        
        addLeftSwipeGesture(toView: appointmentTableView)
        addRightSwipeGesture(toView: appointmentTableView)
    }
    
    func loadContents() {
        loadCustomStackView()
        loadSelectorLineView()
        loadSelectedLineView()
        loadNoAppointmentImageView()
        loadNoAppointmentHeader()
        loadNoAppointmentBody()
        loadAppointmentTableView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        loadContents()
        
        if(isSearchBarActive) {
            splitViewController?.presentsWithGesture = false
        }
        else{
            splitViewController?.presentsWithGesture = true
        }
        
        appointmentTableView.reloadData()
    }
    
    @objc func didSelectSearchIcon() {
        searchBar.becomeFirstResponder()
        searchBarShould(show: true)
    }
    
    func configureDelegates() {
        searchBar.delegate = self
        
        appointmentTableView.delegate = self
        appointmentTableView.dataSource = self
    }
    
    @objc func didTapCancelDuringSearch(_ sender: UIBarButtonItem) {
        searchBarCancelButtonClicked(searchBar)
    }
    
    func searchBarShould(show: Bool) {
        
        if(show){
            navigationItem.hidesBackButton = true
            navigationItem.titleView = searchBar
            searchBar.showsCancelButton = true
            
            if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                navigationItem.rightBarButtonItems = [cancelBarButton]
                splitViewController?.presentsWithGesture = false
            }
            else{
                navigationItem.rightBarButtonItems = []
            }
            
        }
        else{
            navigationItem.rightBarButtonItems = [filterBarButton, fixedSpaceBarButton, searchBarButton]
            navigationItem.titleView = nil
            navigationItem.hidesBackButton = false
            searchBar.showsCancelButton = false
            
            if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                splitViewController?.presentsWithGesture = true
            }
        }
    }
    
    func getMenu() -> UIMenu {
        let dateAscending = UIAction(
            title: "Date (Asc)") { [weak self] _ in
                print("Date Ascending.")
                self?.appointmentsListHelperVC.sort(by: .dateAscending)
                self?.appointmentsListHelperVC.selectedSortingState = .dateAscending
                self?.appointmentTableView.reloadData()
            }
        
        let dateDescending = UIAction(
            title: "Date (Desc)", state: .on) { [weak self] _ in
                print("Date Descending.")
                self?.appointmentsListHelperVC.sort(by: .dateDescending)
                self?.appointmentsListHelperVC.selectedSortingState = .dateDescending
                self?.appointmentTableView.reloadData()
            }
        
        let menu =  UIMenu(title: "Sort By",
            image: nil,
            identifier: nil,
            options: .singleSelection,
            children: [dateAscending, dateDescending])
        
        return menu
    }
    
    func getEditMenu() -> UIMenu {
        let endEditing = UIAction(title: "End Editing",
                                  subtitle: nil,
                                  image: UIImage(systemName: "pencil.slash"),
                                  state: .off) { [weak self] _ in
            self?.endTableViewEditing()
        }
        
        let delete = UIAction(title: "Delete",
                              subtitle: nil,
                              image: UIImage(systemName: "trash"),
                              attributes: .destructive,
                              state: .off) { [weak self] _ in
            self?.didTapDelete()
        }
        
        let menu =  UIMenu(
            image: nil,
            identifier: nil,
            options: .singleSelection,
            children: [endEditing, delete])
        
        return menu
    }
    
    func loadCustomStackView() {
        customSegmentedStackView.translatesAutoresizingMaskIntoConstraints = false
        
        customSegmentedStackView.backgroundColor = appointmentTableView.backgroundColor
        
        NSLayoutConstraint.activate([
            customSegmentedStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            customSegmentedStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            customSegmentedStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
    }
    
    func loadButtons() {
        upcomingButton.addTarget(self, action: #selector(didTapCustomSegmentedControl), for: .touchUpInside)
        upcomingButton.setTitleColor(.systemBlue, for: .normal)
        completedButton.addTarget(self, action: #selector(didTapCustomSegmentedControl), for: .touchUpInside)
        cancelledButton.addTarget(self, action: #selector(didTapCustomSegmentedControl), for: .touchUpInside)
    }
    
    @objc func didTapCustomSegmentedControl(_ sender: UIButton){
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            self.tabBarController?.tabBar.isHidden = false
        }
        
        selectedLineViewConstraint?.isActive = false
        previousConstraintsToDeActivate[previousConstraintsToDeActivate.count - 1].isActive = false
        if(appointmentTableView.isEditing){
            endTableViewEditing()
        }
        
        switch(sender){
        case upcomingButton:
            upcomingButton.setTitleColor(.systemBlue, for: .normal)
            completedButton.setTitleColor(.secondaryLabel, for: .normal)
            cancelledButton.setTitleColor(.secondaryLabel, for: .normal)
            
            previousConstraintsToDeActivate[previousConstraintsToDeActivate.count - 1] = selectedLineView.leadingAnchor.constraint(equalTo: selectorLineView.leadingAnchor)
            
            appointmentsListHelperVC.selectedState = .upcoming
            
            if((UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) && appointmentsListHelperVC.upcomingAppointments.count > 0) {
                
                delegate?.didSelectInParentView(appointmentsListHelperVC.upcomingAppointments[0])
            }
            
            print("Upcoming Button Clicked")
        case completedButton:
            upcomingButton.setTitleColor(.secondaryLabel, for: .normal)
            completedButton.setTitleColor(.systemBlue, for: .normal)
            cancelledButton.setTitleColor(.secondaryLabel, for: .normal)
            
            previousConstraintsToDeActivate[previousConstraintsToDeActivate.count - 1] = selectedLineView.centerXAnchor.constraint(equalTo: selectorLineView.centerXAnchor)
            
            appointmentsListHelperVC.selectedState = .completed
            
            if((UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) && appointmentsListHelperVC.completedAppointments.count > 0) {
                delegate?.didSelectInParentView(appointmentsListHelperVC.completedAppointments[0])
            }
            
            print("Completed Button Clicked")
        case cancelledButton:
            upcomingButton.setTitleColor(.secondaryLabel, for: .normal)
            completedButton.setTitleColor(.secondaryLabel, for: .normal)
            cancelledButton.setTitleColor(.systemBlue, for: .normal)
            
            previousConstraintsToDeActivate[previousConstraintsToDeActivate.count - 1] = selectedLineView.trailingAnchor.constraint(equalTo: selectorLineView.trailingAnchor)
            
            appointmentsListHelperVC.selectedState = .cancelled
            
            if((UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) && appointmentsListHelperVC.cancelledAppointments.count > 0) {
                delegate?.didSelectInParentView(appointmentsListHelperVC.cancelledAppointments[0])
            }
            
            print("Cancelled Button Clicked")
        default:
            ()
        }
        
        if(isSearchBarActive){
            appointmentsListHelperVC.loadSearchResults(forText: searchBar.text ?? "")
        }
        
        appointmentTableView.reloadData()
        
        UIView.animate(withDuration: 0.3, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 0.3, options: .curveEaseOut) {
            self.previousConstraintsToDeActivate[self.previousConstraintsToDeActivate.count - 1].isActive = true
        }
    }
    
    func loadSelectorLineView() {
        selectorLineView.translatesAutoresizingMaskIntoConstraints = false
        
        selectorLineView.backgroundColor = .tertiaryLabel
        
        NSLayoutConstraint.activate([
            selectorLineView.widthAnchor.constraint(equalTo: customSegmentedStackView.widthAnchor),
            selectorLineView.heightAnchor.constraint(equalToConstant: 2),
            selectorLineView.leadingAnchor.constraint(equalTo: customSegmentedStackView.leadingAnchor),
            selectorLineView.bottomAnchor.constraint(equalTo: customSegmentedStackView.bottomAnchor, constant: -3)
        ])
        
        selectorLineView.layer.cornerRadius = 1
    }
    
    func getSelectedPosition(_ state: ConsultationState) -> NSLayoutConstraint {
        switch state {
        case .cancelled:
            return selectedLineView.trailingAnchor.constraint(equalTo: selectorLineView.trailingAnchor)
        case .completed:
            return selectedLineView.centerXAnchor.constraint(equalTo: selectorLineView.centerXAnchor)
        case .upcoming:
            return selectedLineView.leadingAnchor.constraint(equalTo: selectorLineView.leadingAnchor)
        }
    }
    
    func loadSelectedLineView() {
        selectedLineView.translatesAutoresizingMaskIntoConstraints = false
        
        selectedLineView.backgroundColor = .systemBlue
        
        selectedLineViewConstraint = getSelectedPosition(appointmentsListHelperVC.selectedState)
        
        var width = CGFloat(0)
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            width = ((self.splitViewController?.primaryColumnWidth ?? 0) - 30) / 3
        }
        else{
            width = (view.frame.width - 30)/3
        }
        
        let constraints = [
            selectedLineView.centerYAnchor.constraint(equalTo: selectorLineView.centerYAnchor),
            selectedLineView.heightAnchor.constraint(equalToConstant: 3),
            selectedLineView.widthAnchor.constraint(equalToConstant: width),
            selectedLineViewConstraint!
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        selectedLineView.layer.cornerRadius = 3/2
    }
    
    func loadNoAppointmentImageView() {
        noAppointmentImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if(view.frame.height > 800){
            NSLayoutConstraint.activate([
                noAppointmentImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
                noAppointmentImageView.leadingAnchor.constraint(equalTo: customSegmentedStackView.leadingAnchor),
                noAppointmentImageView.trailingAnchor.constraint(equalTo: customSegmentedStackView.trailingAnchor),
            ])
        }
        else{
            NSLayoutConstraint.activate([
                noAppointmentImageView.topAnchor.constraint(equalTo: customSegmentedStackView.bottomAnchor),
                noAppointmentImageView.leadingAnchor.constraint(equalTo: customSegmentedStackView.leadingAnchor),
                noAppointmentImageView.trailingAnchor.constraint(equalTo: customSegmentedStackView.trailingAnchor),
            ])
        }
    }
    
    func loadNoAppointmentHeader() {
        noAppointmentHeader.translatesAutoresizingMaskIntoConstraints = false
        
        noAppointmentHeader.text = "You don't have an appointment yet."
        
        NSLayoutConstraint.activate([
            noAppointmentHeader.bottomAnchor.constraint(equalTo: noAppointmentBody.topAnchor, constant: -5),
            noAppointmentHeader.leadingAnchor.constraint(equalTo: noAppointmentBody.leadingAnchor),
            noAppointmentHeader.trailingAnchor.constraint(equalTo: noAppointmentBody.trailingAnchor),
        ])
    }
    
    func loadNoAppointmentBody() {
        noAppointmentBody.translatesAutoresizingMaskIntoConstraints = false
        
        noAppointmentBody.text = "You don't have a doctor's appointment scheduled at the moment."
        
        NSLayoutConstraint.activate([
            noAppointmentBody.bottomAnchor.constraint(equalTo: noAppointmentImageView.bottomAnchor, constant: -5),
            noAppointmentBody.leadingAnchor.constraint(equalTo: noAppointmentImageView.leadingAnchor),
            noAppointmentBody.trailingAnchor.constraint(equalTo: noAppointmentImageView.trailingAnchor),
        ])
    }
    
    func loadAppointmentTableView() {
        appointmentTableView.translatesAutoresizingMaskIntoConstraints = false
        
        appointmentTableView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            appointmentTableView.topAnchor.constraint(equalTo: customSegmentedStackView.bottomAnchor),
            appointmentTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            appointmentTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            appointmentTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func shouldReloadTableView(_ sender: Notification){
        appointmentTableView.reloadData()
    }
    
    func removeAndReloadTableView(forConsultation consultation: ConsultationGetter) {
        appointmentsListHelperVC.removeConsultation(consultation)
        
        appointmentsListHelperVC.getAppointments()
        
        appointmentTableView.reloadData()
    }
    
    func addLongPressGesture(_ toView: UITableViewCell){
        let longPressGesture = UILongPressGestureRecognizer()

        longPressGesture.addTarget(self, action: #selector(longPress))

        toView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer){
        
        navigationItem.rightBarButtonItems = [binBarButton]
        
        if(appointmentsListHelperVC.selectedState == .completed || appointmentsListHelperVC.selectedState == .cancelled) {
            appointmentTableView.isEditing = true
            appointmentTableView.allowsSelectionDuringEditing = appointmentTableView.isEditing
            appointmentTableView.allowsMultipleSelectionDuringEditing = true
        }
    }
    
    func didTapDelete(){
        let alertViewController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        alertViewController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
            var consultationsToDelete: [ConsultationGetter] = []
            
            if let selectedRows = appointmentTableView.indexPathsForSelectedRows {
                for indexPath in selectedRows {
                    var cell: AppointmentTableViewCellProtocol?
                    
                    switch(appointmentsListHelperVC.selectedState) {
                    case .cancelled:
                        guard let tempCell = appointmentTableView.cellForRow(at: indexPath) as? CancelledAppointmentsListTableViewCell else{
                            return
                        }
                        
                        cell = tempCell
                    case .completed:
                        guard let tempCell = appointmentTableView.cellForRow(at: indexPath) as? CompletedAndUpcomingAppointmentsListTableViewCell else{
                            return
                        }
                        
                        cell = tempCell
                    default:
                        return
                    }
                    
                    guard let consultation = cell?.consultation else {
                        return
                    }
                    
                    consultationsToDelete.append(consultation)
                }
            }
            
            appointmentsListHelperVC.removeConsultations(consultationsToDelete)
            
            appointmentsListHelperVC.getAppointments()
            appointmentTableView.reloadData()

            endTableViewEditing()
        }))
        
        present(alertViewController, animated: true)
    }
    
    func endTableViewEditing() {
        if let selectedRows = appointmentTableView.indexPathsForSelectedRows {
            for indexPath in selectedRows {
                
                switch(appointmentsListHelperVC.selectedState) {
                case .cancelled:
                    guard let tempCell = appointmentTableView.cellForRow(at: indexPath) as? CancelledAppointmentsListTableViewCell else{
                        return
                    }
                    
                    tempCell.accessoryType = .none
                case .completed:
                    guard let tempCell = appointmentTableView.cellForRow(at: indexPath) as? CompletedAndUpcomingAppointmentsListTableViewCell else{
                        return
                    }
                    
                    tempCell.accessoryType = .none
                default:
                    return
                }
            }
        }
        
        appointmentTableView.isEditing = false
        appointmentTableView.allowsSelectionDuringEditing = false
        navigationItem.rightBarButtonItems = [searchBarButton, filterBarButton]
    }
    
    func configureContextMenu(indexPath: IndexPath) -> UIContextMenuConfiguration {
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive,
                                  state: .off) { (_) in
                print("delete button clicked")

                let alertViewController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)

                alertViewController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
                    var consultationsToDelete: ConsultationGetter?

                    switch(appointmentsListHelperVC.selectedState) {
                    case .cancelled:
                        consultationsToDelete = appointmentsListHelperVC.cancelledAppointments[indexPath.row]

                    case .completed:
                        consultationsToDelete = appointmentsListHelperVC.completedAppointments[indexPath.row]

                    default:
                        return
                    }

                    guard let consultationsToDelete = consultationsToDelete else {
                        return
                    }

                    appointmentsListHelperVC.removeConsultation(consultationsToDelete)

                    appointmentsListHelperVC.getAppointments()
                    appointmentTableView.reloadData()
                    
                    endTableViewEditing()
                }))

                alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

                self.present(alertViewController, animated: true)
            }


            return UIMenu(title: "", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [delete])
        }

        return contextMenu
    }
    
    func changeCustomSegmentedControlViewState(for swipeCount: Int) {
        switch(swipeCount) {
        case -1:
            didTapCustomSegmentedControl(upcomingButton)
        case 0:
            didTapCustomSegmentedControl(completedButton)
        case 1:
            didTapCustomSegmentedControl(cancelledButton)
        default:
            ()
        }
    }
    
    func addRightSwipeGesture(toView: UIView) {
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.numberOfTouchesRequired = 1
        swipeGesture.direction = .right
        
        if(toView == appointmentTableView) {
            swipeGesture.addTarget(self, action: #selector(didSwipeRight))
        }
        
        toView.addGestureRecognizer(swipeGesture)
    }
    
    func addLeftSwipeGesture(toView: UIView) {
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.numberOfTouchesRequired = 1
        swipeGesture.direction = .left
        
        if(toView == appointmentTableView) {
            swipeGesture.addTarget(self, action: #selector(didSwipeLeft))
        }
        
        toView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        swipeCount-=1
        
        if(swipeCount > -2 && swipeCount < 2){
            changeCustomSegmentedControlViewState(for: swipeCount)
        }
        else{
            swipeCount = -1
        }
        
        print(swipeCount)
    }
    
    @objc func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        swipeCount+=1
        
        if(swipeCount > -2 && swipeCount < 2){
            changeCustomSegmentedControlViewState(for: swipeCount)
        }
        else{
            swipeCount = 1
        }
        
        print(swipeCount)
    }
}


extension AppointmentsListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        appointmentsListHelperVC.loadSearchResults(forText: searchText)
        
        appointmentTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearchBarActive = true
        searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        
        searchBar.resignFirstResponder()
        isSearchBarActive = false
        
        searchBarShould(show: false)
        appointmentTableView.reloadData()
        
        noAppointmentImageView.image = UIImage(named: "No Appointment")
        noAppointmentHeader.text = "You don't have an appointment yet."
        noAppointmentBody.text = "You don't have a doctor's appointment scheduled at the moment."
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

extension AppointmentsListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        var listCount = 0
        
        if(isSearchBarActive){
            listCount = appointmentsListHelperVC.searchResults.count
        }
        else{
            switch(appointmentsListHelperVC.selectedState){
            case .upcoming:
                listCount = appointmentsListHelperVC.upcomingAppointments.count
            case .cancelled:
                listCount = appointmentsListHelperVC.cancelledAppointments.count
            case .completed:
                listCount = appointmentsListHelperVC.completedAppointments.count
            }
        }
        
        if(listCount == 0) {
            if(isSearchBarActive) {
                
                if(searchBar.text?.count == 0) {
                    noAppointmentImageView.image = UIImage(named: "No Appointment")
                    noAppointmentHeader.text = "You don't have an appointment yet."
                    noAppointmentBody.text = "You don't have a doctor's appointment scheduled at the moment."
                    
                    noAppointmentImageView.alpha = 1
                    noAppointmentHeader.alpha = 1
                    noAppointmentBody.alpha = 1
                    
                    if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
                        delegate?.didSelectInParentView(-1)
                    }
                }
                else{
                    noAppointmentImageView.image = UIImage(named: "No Search Result")
                    noAppointmentHeader.text = "We couldn't find what you searched for."
                    noAppointmentBody.text = "Try searching again."
                    
                    noAppointmentImageView.alpha = 1
                    noAppointmentHeader.alpha = 1
                    noAppointmentBody.alpha = 1
                    
                    print(initialWidth)
                    print(view.frame.width)
                    if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular && (initialWidth == splitViewController?.primaryColumnWidth)) {
                        delegate?.didSelectInParentView(-2)
                    }
                }
            }
            else{
                noAppointmentImageView.alpha = 1
                noAppointmentHeader.alpha = 1
                noAppointmentBody.alpha = 1
                
                if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
                    
                    delegate?.didSelectInParentView(-1)
                }
            }
        }
        else{
            noAppointmentImageView.alpha = 0
            noAppointmentHeader.alpha = 0
            noAppointmentBody.alpha = 0
            
            if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
                var consultation: ConsultationGetter?
                
                switch(appointmentsListHelperVC.selectedState) {
                case .upcoming:
                    if(appointmentsListHelperVC.upcomingAppointments.count == 0){
                        delegate?.didSelectInParentView(-1)
                        return listCount
                    }
                    consultation = appointmentsListHelperVC.upcomingAppointments[0]
                case .completed:
                    if(appointmentsListHelperVC.completedAppointments.count == 0){
                        delegate?.didSelectInParentView(-1)
                        return listCount
                    }
                    consultation = appointmentsListHelperVC.completedAppointments[0]
                case .cancelled:
                    if(appointmentsListHelperVC.cancelledAppointments.count == 0){
                        delegate?.didSelectInParentView(-1)
                        return listCount
                    }
                    consultation = appointmentsListHelperVC.cancelledAppointments[0]
                }
                
                guard let consultation = consultation else {
                    return listCount
                }
                
                delegate?.didSelectInParentView(consultation)
            }
        }
        
        return listCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: AppointmentTableViewCellProtocol?
        
        switch(appointmentsListHelperVC.selectedState){
        case .upcoming, .completed:
            guard let tempCell = tableView.dequeueReusableCell(withIdentifier: CompletedAndUpcomingAppointmentsListTableViewCell.identifier, for: indexPath) as? CompletedAndUpcomingAppointmentsListTableViewCell else {
                return UITableViewCell()
            }
            
            tempCell.backgroundColor = .secondarySystemGroupedBackground
            
            cell = tempCell
            
        case .cancelled:
            guard let tempCell = tableView.dequeueReusableCell(withIdentifier: CancelledAppointmentsListTableViewCell.identifier, for: indexPath) as? CancelledAppointmentsListTableViewCell else {
                return UITableViewCell()
            }
            
            tempCell.backgroundColor = .secondarySystemGroupedBackground
            
            cell = tempCell
        }
        
        guard let cell = cell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        if(appointmentsListHelperVC.selectedState == .completed || appointmentsListHelperVC.selectedState == .cancelled) {
            addLongPressGesture(cell as! UITableViewCell)
        }
        
        var doctorName = ""
        var doctorImage = ""
        
        if(isSearchBarActive){
            
            doctorImage = appointmentsListHelperVC.searchResults[indexPath.section].doctorImage ?? ""
            doctorName = appointmentsListHelperVC.searchResults[indexPath.section].doctorName ?? ""
            
            print(searchBar.searchTextField.text ?? "")
            cell.doctorName.attributedText = highlight(fromSource: searchBar.searchTextField.text ?? "", toTarget: doctorName)
            cell.consultation = appointmentsListHelperVC.searchResults[indexPath.section]
            
            guard let url = URL(string: doctorImage) else {
                return UITableViewCell()
            }
            
            cell.doctorImageView.loadImageWithUrl(url)
        }
        else{
            switch(appointmentsListHelperVC.selectedState){
            case .upcoming:
                
                doctorImage = appointmentsListHelperVC.upcomingAppointments[indexPath.section].doctorImage ?? ""
                doctorName = appointmentsListHelperVC.upcomingAppointments[indexPath.section].doctorName ?? ""
                
                cell.doctorName.text = doctorName
                cell.consultation = appointmentsListHelperVC.upcomingAppointments[indexPath.section]
                
                guard let url = URL(string: doctorImage) else {
                    return UITableViewCell()
                }
                
                cell.doctorImageView.loadImageWithUrl(url)
                
            case .completed:
                
                doctorImage = appointmentsListHelperVC.completedAppointments[indexPath.section].doctorImage ?? ""
                doctorName = appointmentsListHelperVC.completedAppointments[indexPath.section].doctorName ?? ""
                
                cell.doctorName.text = doctorName
                cell.consultation = appointmentsListHelperVC.completedAppointments[indexPath.section]
                
                guard let url = URL(string: doctorImage) else {
                    return UITableViewCell()
                }
                
                cell.doctorImageView.loadImageWithUrl(url)
                
            case .cancelled:
                doctorImage = appointmentsListHelperVC.cancelledAppointments[indexPath.section].doctorImage ?? ""
                doctorName = appointmentsListHelperVC.cancelledAppointments[indexPath.section].doctorName ?? ""
                
                cell.doctorName.text = doctorName
                cell.consultation = appointmentsListHelperVC.cancelledAppointments[indexPath.section]
                
                guard let url = URL(string: doctorImage) else {
                    return UITableViewCell()
                }
                
                cell.doctorImageView.loadImageWithUrl(url)
            }
        }
        
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            self.tabBarController?.tabBar.isHidden = false
        }
        
        if(appointmentTableView.isEditing) {
            var cell: AppointmentTableViewCellProtocol?
            
            switch(appointmentsListHelperVC.selectedState) {
            case .cancelled:
                guard let tempCell = tableView.cellForRow(at: indexPath) as? CancelledAppointmentsListTableViewCell else {
                    return
                }
                
                cell = tempCell
            case .completed:
                guard let tempCell = tableView.cellForRow(at: indexPath) as? CompletedAndUpcomingAppointmentsListTableViewCell else {
                    return
                }
                
                cell = tempCell
            default:
                return
            }
            
            guard let cell = cell as? UITableViewCell else {
                return
            }
            
            cell.accessoryType = .checkmark
            
            return
        }
    
        var consultation: ConsultationGetter?
        
        if(UITraitCollection.current.userInterfaceIdiom != .pad) {
            self.tabBarController?.tabBar.isHidden = true
        }
        
        switch(appointmentsListHelperVC.selectedState){
        case .upcoming:
            consultation = appointmentsListHelperVC.upcomingAppointments[indexPath.section]
        case .completed:
            consultation = appointmentsListHelperVC.completedAppointments[indexPath.section]
        case .cancelled:
            consultation = appointmentsListHelperVC.cancelledAppointments[indexPath.section]
        }
        
        guard let consultation = consultation else {
            return
        }
        
        print(consultation)
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            delegate?.didSelectInParentView(consultation)
        }
        else{
            let secondVC = AppointmentInfoVC(consultation: consultation, isFromPayment: false)
            
            navigationController?.pushViewController(secondVC, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if(appointmentTableView.isEditing) {
            var cell: AppointmentTableViewCellProtocol?
            
            switch(appointmentsListHelperVC.selectedState) {
            case .cancelled:
                guard let tempCell = tableView.cellForRow(at: indexPath) as? CancelledAppointmentsListTableViewCell else {
                    return
                }
                
                cell = tempCell
            case .completed:
                guard let tempCell = tableView.cellForRow(at: indexPath) as? CompletedAndUpcomingAppointmentsListTableViewCell else {
                    return
                }
                
                cell = tempCell
            default:
                return
            }
            
            guard let cell = cell as? UITableViewCell else {
                return
            }
            
            cell.accessoryType = .none
            
            return
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if(appointmentsListHelperVC.selectedState == .completed || appointmentsListHelperVC.selectedState == .cancelled) {
            
            var cell: AppointmentTableViewCellProtocol?
            
            switch(appointmentsListHelperVC.selectedState) {
            case .cancelled:
                guard let tempCell = tableView.cellForRow(at: indexPath) as? CancelledAppointmentsListTableViewCell else {
                    return nil
                }
                
                cell = tempCell
            case .completed:
                guard let tempCell = tableView.cellForRow(at: indexPath) as? CompletedAndUpcomingAppointmentsListTableViewCell else {
                    return nil
                }
                
                cell = tempCell
            default:
                return nil
            }
            
            guard let consultation = cell?.consultation else {
                return nil
            }
            
            let deleteSwipeAction = UIContextualAction(style: .destructive, title: "Delete") { action, _, _ in
                
                let alertViewController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
                
                alertViewController.addAction(UIAlertAction(title: "Cancel", style: .default){_ in
                    self.appointmentTableView.reloadRows(at: [indexPath], with: .none)
                })
                
                alertViewController.addAction(UIAlertAction(title: "Delete", style: .destructive){_ in
                    self.removeAndReloadTableView(forConsultation: consultation)
                })
                
                self.present(alertViewController, animated: true)
            }
            
            return UISwipeActionsConfiguration(actions: [deleteSwipeAction])
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        if(appointmentsListHelperVC.selectedState == .upcoming){
            return nil
        }
        return configureContextMenu(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        7.5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch(appointmentsListHelperVC.selectedState){
        case .upcoming:
            if(section == appointmentsListHelperVC.upcomingAppointments.count - 1 && isSearchBarActive && searchBar.text?.count != 0){
                return 20
            }
            return 7.5
        case .completed:
            if(section == appointmentsListHelperVC.completedAppointments.count - 1 && isSearchBarActive && searchBar.text?.count != 0){
                return 20
            }
            return 7.5
        case .cancelled:
            if(section == appointmentsListHelperVC.cancelledAppointments.count - 1 && isSearchBarActive && searchBar.text?.count != 0){
                return 20
            }
            return 7.5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        footerView.addSubview(footerLabel)
        
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            footerLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            footerLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10)
        ])
        
        switch(appointmentsListHelperVC.selectedState) {
        case .upcoming:
            if(section == appointmentsListHelperVC.searchResults.count - 1 && isSearchBarActive && searchBar.text?.count != 0) {
                footerLabel.text = "\(appointmentsListHelperVC.searchResults.count) / \(appointmentsListHelperVC.upcomingAppointments.count) Search Results"
                
                return footerView
            }
            return nil
        case .cancelled:
            if(section == appointmentsListHelperVC.searchResults.count - 1 && isSearchBarActive && searchBar.text?.count != 0) {
                footerLabel.text = "\(appointmentsListHelperVC.searchResults.count) / \(appointmentsListHelperVC.cancelledAppointments.count) Search Results"
                
                return footerView
            }
            return nil
        case .completed:
            if(section == appointmentsListHelperVC.searchResults.count - 1 && isSearchBarActive && searchBar.text?.count != 0) {
                footerLabel.text = "\(appointmentsListHelperVC.searchResults.count) / \(appointmentsListHelperVC.completedAppointments.count) Search Results"
                
                return footerView
            }
            return nil
        }
    }
}

extension AppointmentsListVC: AppointmentFunctionTableViewCellProtocol {
    func cancelAppointment(_ consultation: ConsultationGetter) {
        print("Cancelling Appointment")
        
        let cancelAppointmentVC = CancelAppointmentConfirmationVC(consultation)
        cancelAppointmentVC.delegate = self
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
            let detailVC = self.splitViewController?.viewControllers.last
            
            (self.splitViewController?.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: false)
            detailVC?.present(cancelAppointmentVC, animated: true)
        }
        else{
            present(cancelAppointmentVC, animated: true)
        }
    }
    
    func rescheduleAppointment(_ consultation: ConsultationGetter) {
        print("Rescheduling Appointment")
        
        self.tabBarController?.tabBar.isHidden = true
        
        let changeVC = ChangeAppointmentVC(consultation, shouldCancel: false, isFromPayment: false)
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
            (self.splitViewController?.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: false)
            
            splitViewController?.showDetailViewController(changeVC, sender: self)
        }
        else{
            navigationController?.pushViewController(changeVC, animated: true)
        }
    }
    
    func bookAppointment(_ consultation: ConsultationGetter) {
        print("Re Booking Appointment")
        
        self.tabBarController?.tabBar.isHidden = true
        
        appointmentsListHelperVC.getDoctorDetail(forId: consultation.doctorId ?? 0)
        
        guard let doctor = appointmentsListHelperVC.doctor else {
            return
        }
        
        let doctorProfileVC = DoctorProfileVC(doctor: doctor, isFromBookAgain: true)
        doctorProfileVC.isFromConsultation = true
        doctorProfileVC.reBookDelegate = self
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
            (self.splitViewController?.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: false)
            splitViewController?.showDetailViewController(doctorProfileVC, sender: self)
        }
        else{
            navigationController?.pushViewController(doctorProfileVC, animated: true)
        }
    }
    
    func leaveAReview(_ consultation: ConsultationGetter) {
        print("Leaving a Review")
        
        self.tabBarController?.tabBar.isHidden = true
        
        guard let image = consultation.doctorImage,
              let name = consultation.doctorName,
              let id = consultation.doctorId else {
            return
        }
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
            (self.splitViewController?.viewControllers.last as? UINavigationController)?.popToRootViewController(animated: false)
            
            let reviewVC = WriteAReviewVC(doctorImage: image, doctorName: name, doctorId: id, isFromSplitView: true)
            
            splitViewController?.showDetailViewController(reviewVC, sender: self)
        }
        else{
            let reviewVC = WriteAReviewVC(doctorImage: image, doctorName: name, doctorId: id, isFromSplitView: false)
            
            navigationController?.pushViewController(reviewVC, animated: true)
        }
    }
}


extension AppointmentsListVC: AppointmentCancellingProtocol {
    func showCancelReason(_ consultation: ConsultationGetter) {
        let changeAppointmentVC = ChangeAppointmentVC(consultation, shouldCancel: true, isFromPayment: false)
        
        changeAppointmentVC.delegate = self
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
            splitViewController?.showDetailViewController(changeAppointmentVC, sender: self)
        }
        else{
            navigationController?.pushViewController(changeAppointmentVC, animated: true)
        }
    }
    
    func confirmCancelAppointment(_ consultation: ConsultationGetter) {
        appointmentsListHelperVC.updateState(to: .cancelled, for: consultation)
        
        appointmentsListHelperVC.getAppointments()
        
        appointmentTableView.reloadData()
    }
    
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension AppointmentsListVC: ReBookingProtocol {
    func fetchAndReloadCollectionView() {
        if(isSearchBarActive){
            appointmentsListHelperVC.loadSearchResults(forText: searchBar.text ?? "")
            appointmentTableView.reloadData()
        }
        else{
            appointmentsListHelperVC.getAppointments()
            appointmentTableView.reloadData()
        }
    }
}

extension AppointmentsListVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            appointmentsListHelperVC.getAppointments()
            appointmentsListHelperVC.sort(by: appointmentsListHelperVC.selectedSortingState)
            appointmentTableView.reloadData()
        }
    }
}


extension AppointmentsListVC: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
    
    func splitViewController(_ svc: UISplitViewController, shouldHide vc: UIViewController, in orientation: UIInterfaceOrientation) -> Bool {
        switch(orientation){
        case .portrait:
            return false
        default:
            return true
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            return true
        }
        return false
    }
}
