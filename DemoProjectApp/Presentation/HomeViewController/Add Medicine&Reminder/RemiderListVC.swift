//
//  RemiderListVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 24/09/22.
//

import UIKit

class RemiderListVC: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating, ReminderListVCProtocol, ReminderPostDeletionProtocol {
    
    let reminderVCHelper = ReminderVCHelper()
    
    var cancelButtonTapped : Bool = false
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        
        var scopeBarNames: [String] = []
        
        for state in ReminderState.allCases{
            scopeBarNames.append(state.scopeBarName)
        }
        
        searchController.searchBar.scopeButtonTitles = scopeBarNames
        searchController.searchBar.placeholder = "Search"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.selectedScopeButtonIndex = 1
        searchController.searchBar.showsScopeBar = true
        
        return searchController
    }()
    
    lazy var footerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var footerLabel: ResizedLabelWithExtraWidth = {
        let label = ResizedLabelWithExtraWidth()
        
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.contentMode = .center
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        
        return label
    }()
    
    lazy var noReminderImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "No Reminders"))
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var noReminderLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.contentMode = .center
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        label.text = "Looks like you don't have any Reminders."
        
        return label
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.calendar = Calendar.autoupdatingCurrent
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    
    lazy var calendar: Calendar = {
        let calendar = Calendar.current
        
        return calendar
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
    
    var optionsBarButton = UIBarButtonItem()
    var selectAllBarButton = UIBarButtonItem()
    var deSelectAllBarButton = UIBarButtonItem()
    var doneBarButton = UIBarButtonItem()
    var trashBarButton = UIBarButtonItem()
    var flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    var barButtonAtRight: UIBarButtonItem = UIBarButtonItem()
    var barButtonAtLeft: UIBarButtonItem?
    
    var isMultipleSelectionEnabled: Bool = false
    let trashIconImage = UIImage(systemName: "trash")
    
    lazy var bottomToolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        return toolBar
    }()
    
    var isTrashButtonEnabled: Bool = false {
        didSet {
            if(isTrashButtonEnabled) {
                trashBarButton.isEnabled = true
                
                trashBarButton.image = trashIconImage?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
            }
            else{
                trashBarButton.isEnabled = false
                
                trashBarButton.image = trashIconImage?.withTintColor(.systemGray3, renderingMode: .alwaysOriginal)
            }
        }
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        tableView.separatorInset = UIEdgeInsets(
            top: 0,
            left: 5,
            bottom: 0,
            right: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Reminders"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(noReminderImageView)
        view.addSubview(noReminderLabel)
        view.addSubview(noSearchResultImageView)
        view.addSubview(noSearchResultHeader)
        view.addSubview(noSearchResultBody)
        view.addSubview(bottomToolBar)
        
        loadBarButtons()
        configureRequirments()
        loadNoReminderImageView()
        loadNoReminderLabelView()
        loadNoSearchResultImageView()
        loadNoSearchResultHeader()
        loadNoSearchResultBody()
        loadBottomToolBar()
        
        bottomToolBar.setItems([flexibleSpace, trashBarButton], animated: true)

        isTrashButtonEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        view.bringSubviewToFront(bottomToolBar)
    }
    
    func loadBarButtons() {
        optionsBarButton = UIBarButtonItem(title: nil, image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: getEditMenu())
        
        selectAllBarButton = UIBarButtonItem(title: "Select All", style: .done, target: self, action: #selector(didTapSelectAllBarButton))
        
        deSelectAllBarButton = UIBarButtonItem(title: "Deselect All", style: .done, target: self, action: #selector(didTapDeSelectAllBarButton))
        
        doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneBarButton))
        
        trashBarButton = UIBarButtonItem(image: trashIconImage?.withTintColor(.systemRed, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(didTapDelete))
        
        navigationItem.rightBarButtonItem = optionsBarButton
        barButtonAtRight = optionsBarButton
    }
    
    func printArray(array: [[Reminder]]){
        for array in array {
            print(array)
        }
        print()
    }
    
    func configureRequirments() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        tableView.register(ReminderListTableViewCell.self, forCellReuseIdentifier: ReminderListTableViewCell.identifier)
        
        tableView.keyboardDismissMode = .onDrag
        
        reminderVCHelper.delegate = self
    }
    
    func loadNoReminderImageView() {
        noReminderImageView.translatesAutoresizingMaskIntoConstraints = false
        noReminderImageView.alpha = 0
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad) {
            NSLayoutConstraint.activate([
                noReminderImageView.widthAnchor.constraint(equalToConstant: 150),
                noReminderImageView.heightAnchor.constraint(equalTo: noReminderImageView.widthAnchor),
                noReminderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noReminderImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70)
            ])
        }
        else{
            NSLayoutConstraint.activate([
                noReminderImageView.widthAnchor.constraint(equalToConstant: 150),
                noReminderImageView.heightAnchor.constraint(equalTo: noReminderImageView.widthAnchor),
                noReminderImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noReminderImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120)
            ])
        }
    }
    
    func loadNoReminderLabelView() {
        noReminderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        noReminderLabel.alpha = 0
        noReminderLabel.backgroundColor = view.backgroundColor
        
        NSLayoutConstraint.activate([
            noReminderLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            noReminderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noReminderLabel.topAnchor.constraint(equalTo: noReminderImageView.bottomAnchor, constant: 0)
        ])
    }
    
    func loadNoSearchResultImageView() {
        noSearchResultImageView.translatesAutoresizingMaskIntoConstraints = false
        
        noSearchResultImageView.alpha = 0
        
        if(UITraitCollection.current.userInterfaceIdiom == .pad){
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
    
    func loadBottomToolBar() {
        bottomToolBar.translatesAutoresizingMaskIntoConstraints = false
        
        bottomToolBar.isHidden = true
        bottomToolBar.backgroundColor = .systemBackground
        
        bottomToolBar.isOpaque = true
        
        NSLayoutConstraint.activate([
            bottomToolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomToolBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomToolBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            bottomToolBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func getMenu(withSelectedState: ReminderState) -> UIMenu {
        let allMedicineAction = UIAction(
            title: "All Reminders") { [weak self] _ in
                self?.searchController.searchBar.selectedScopeButtonIndex = 0
                self?.reminderVCHelper.fetchAllRemindersForDates()
                self?.reminderVCHelper.status = .all
                self?.tableView.reloadData()
            }
        
        let yetToTake = UIAction(
            title: "Yet to Take") { [weak self] _ in
                self?.searchController.searchBar.selectedScopeButtonIndex = 1
                self?.reminderVCHelper.fetchYetToTakeRemindersForFutureDates()
                self?.reminderVCHelper.status = .yetToTake
                self?.tableView.reloadData()
            }
        
        let completed = UIAction(
            title: "Completed") { [weak self] _ in
                self?.searchController.searchBar.selectedScopeButtonIndex = 3
                self?.reminderVCHelper.fetchCompletedRemindersForDates()
                self?.reminderVCHelper.status = .completed
                self?.tableView.reloadData()
            }
        
        let missed = UIAction(
            title: "Missed") { [weak self] _ in
                self?.searchController.searchBar.selectedScopeButtonIndex = 2
                self?.reminderVCHelper.fetchMissedRemindersForDates()
                self?.reminderVCHelper.status = .missed
                self?.tableView.reloadData()
            }
        
        switch(withSelectedState) {
        case .all:
            allMedicineAction.state = .on
        case .completed:
            completed.state = .on
        case .yetToTake:
            yetToTake.state = .on
        case .missed:
            missed.state = .on
        }
        
        let menu =  UIMenu(
            image: nil,
            identifier: nil,
            options: .singleSelection,
            children: [allMedicineAction, yetToTake, missed, completed])
        
        return menu
    }
    
    func getEditMenu() -> UIMenu {
        let select = UIAction(title: "Select", image: UIImage(systemName: "checkmark.circle")) { [weak self] _ in
            self?.isMultipleSelectionEnabled = true
            
            self?.tableView.reloadData()
            
            self?.tableView.allowsMultipleSelection = true
            self?.tableView.allowsMultipleSelectionDuringEditing = true
            self?.bottomToolBar.isHidden = false
            self?.isTrashButtonEnabled = false
            self?.searchController.searchBar.isUserInteractionEnabled = false
            
            self?.navigationItem.rightBarButtonItem = self?.doneBarButton
            self?.barButtonAtRight = self?.doneBarButton ?? UIBarButtonItem()
            self?.navigationItem.leftBarButtonItem = self?.selectAllBarButton
            self?.barButtonAtLeft = self?.selectAllBarButton ?? UIBarButtonItem()
        }
        
        let sectionCount = reminderVCHelper.getRowCount(isSearchActive: searchController.isActive, section: 0)
        
        if(sectionCount == 0) {
            select.attributes = .disabled
        }
        
        
        let menu =  UIMenu(
            image: nil,
            identifier: nil,
            children: [select])
        
        return menu
    }
    
    @objc func didTapDoneBarButton(_ sender: UIBarButtonItem) {
        
        
        navigationItem.rightBarButtonItem = optionsBarButton
        barButtonAtRight = optionsBarButton
        navigationItem.leftBarButtonItem = nil
        barButtonAtLeft = nil
        bottomToolBar.isHidden = true
        
        isMultipleSelectionEnabled = false
        searchController.searchBar.isUserInteractionEnabled = true
        
        tableView.reloadData()
    }
    
    @objc func didTapSelectAllBarButton(_ sender: UIBarButtonItem) {
        selectAllTableViewRows()
        
        navigationItem.leftBarButtonItem = deSelectAllBarButton
        barButtonAtLeft = deSelectAllBarButton
        
        if let selectedRows = tableView.indexPathsForSelectedRows {
            if(selectedRows.count > 0) {
                isTrashButtonEnabled = true
            }
            else{
                isTrashButtonEnabled = false
            }
        }
    }
    
    @objc func didTapDeSelectAllBarButton(_ sender: UIBarButtonItem) {
        deSelectAllSelectedRows()
        
        navigationItem.leftBarButtonItem = selectAllBarButton
        barButtonAtLeft = selectAllBarButton
        
        isTrashButtonEnabled = false
    }
    
    func selectAllTableViewRows() {
        let sections = reminderVCHelper.getSectionCount(isSearchActive: searchController.isActive)
        
        for section in 0..<sections {
            for row in 0..<reminderVCHelper.getRowCount(isSearchActive: searchController.isActive, section: section) {
                let indexPath = IndexPath(row: row, section: section)
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            }
        }
        
        reminderVCHelper.multipleSelectedRemindersToDelete = []
        
        switch(reminderVCHelper.status) {
        case .all:
            for reminders in reminderVCHelper.allMedicines {
                for reminder in reminders {
                    reminderVCHelper.multipleSelectedRemindersToDelete.append(reminder)
                }
            }
        case .completed:
            for reminders in reminderVCHelper.completedReminders {
                for reminder in reminders {
                    reminderVCHelper.multipleSelectedRemindersToDelete.append(reminder)
                }
            }
        case .missed:
            for reminders in reminderVCHelper.missedReminders {
                for reminder in reminders {
                    reminderVCHelper.multipleSelectedRemindersToDelete.append(reminder)
                }
            }
        case .yetToTake:
            for reminders in reminderVCHelper.yetToTakeReminders {
                for reminder in reminders {
                    reminderVCHelper.multipleSelectedRemindersToDelete.append(reminder)
                }
            }
        }
    }
    
    func deSelectAllSelectedRows() {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            for indexPath in selectedRows {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        loadEmptyImages()
    }
    
    func loadEmptyImages() {
        let sections = reminderVCHelper.getSectionCount(isSearchActive: searchController.isActive)
        
        for section in 0..<sections {
            for row in 0..<reminderVCHelper.getRowCount(isSearchActive: searchController.isActive, section: section) {
                let indexPath = IndexPath(row: row, section: section)
                guard let cell = tableView.cellForRow(at: indexPath) as? ReminderListTableViewCell else {
                    return
                }
                
                cell.selectedImageView.isHidden = false
                cell.selectedImageView.image = cell.emptyCircleImage
            }
        }
    }
    
    func loadEmptyImage(forIndexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: forIndexPath) as? ReminderListTableViewCell else {
            return
        }
                
        cell.selectedImageView.isHidden = false
        cell.selectedImageView.image = cell.emptyCircleImage
        
        navigationItem.leftBarButtonItem = selectAllBarButton
        barButtonAtLeft = selectAllBarButton
    }
    
    @objc func didTapDelete(_ sender: UIBarButtonItem){
        let alertViewController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
            
            reminderVCHelper.deleteRemindes(reminderVCHelper.multipleSelectedRemindersToDelete)
            
            if(searchController.isActive){
                reminderVCHelper.loadSearchResults(searchText: searchController.searchBar.text ?? "")
            }
            else {
                switch(reminderVCHelper.status) {
                case .all:
                    reminderVCHelper.fetchAllRemindersForDates()
                case .completed:
                    reminderVCHelper.fetchCompletedRemindersForDates()
                case .missed:
                    reminderVCHelper.fetchMissedRemindersForDates()
                case .yetToTake:
                    reminderVCHelper.fetchYetToTakeRemindersForFutureDates()
                }
            }
            
            self.tableView.reloadData()
            
            self.tableView.allowsMultipleSelection = true
            self.tableView.allowsMultipleSelectionDuringEditing = true
            isMultipleSelectionEnabled = true
            loadEmptyImages()
            
            self.reminderVCHelper.multipleSelectedRemindersToDelete = []
            isTrashButtonEnabled = false
            
            optionsBarButton.menu = getEditMenu()
        }))
        
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertViewController, animated: true)
    }
    
    func selectCellFromPoint(point: CGPoint) {
        if let indexPath = tableView.indexPathForRow(at: point) {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
    }
    
    func getReminderFromSelectedCell(point: CGPoint) -> Reminder?{
        if let indexPath = tableView.indexPathForRow(at: point) {
            guard let cell = tableView.cellForRow(at: indexPath) as? ReminderListTableViewCell else {
                return nil
            }
            
            return cell.reminder
        }
        return nil
    }
}

extension RemiderListVC {
    func loadRequiredDatas() {
        if(searchController.isActive) {
            reminderVCHelper.loadSearchResults(searchText: searchController.searchBar.text ?? "")
        }
        else{
            switch (reminderVCHelper.status) {
            case .all:
                reminderVCHelper.fetchAllRemindersForDates()
            case .completed:
                reminderVCHelper.fetchCompletedRemindersForDates()
            case .missed:
                reminderVCHelper.fetchMissedRemindersForDates()
            case .yetToTake:
                reminderVCHelper.fetchYetToTakeRemindersForFutureDates()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let selectedState = ReminderState(rawValue: selectedScope) ?? .yetToTake
        
        reminderVCHelper.status = selectedState
        
        loadRequiredDatas()
        
        if(!searchController.isActive) {
            optionsBarButton.menu = getEditMenu()
            
            navigationItem.rightBarButtonItem = optionsBarButton
            barButtonAtRight = optionsBarButton
            
            navigationItem.leftBarButtonItem = nil
            barButtonAtLeft = nil
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigationItem.rightBarButtonItem = nil
        navigationItem.leftBarButtonItem = nil
        
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        becomeFirstResponder()
        navigationItem.rightBarButtonItems = nil
        navigationItem.leftBarButtonItem = nil
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        reminderVCHelper.previousStatus = reminderVCHelper.status
        reminderVCHelper.status = ReminderState(rawValue: searchController.searchBar.selectedScopeButtonIndex)!
                
        reminderVCHelper.loadSearchResults(searchText: searchText)
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
        
        navigationItem.rightBarButtonItem = barButtonAtRight
        navigationItem.leftBarButtonItem = barButtonAtLeft
        
        loadRequiredDatas()
        
        tableView.reloadData()
        
        if(isMultipleSelectionEnabled) {
            loadEmptyImages()
        }
    }
    
    func getAttributed(stringFor: String, withColor: UIColor) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: stringFor)
        
        attributedString.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 15), range: NSRange(location: 0, length: stringFor.count))
        attributedString.addAttribute(.foregroundColor, value: withColor, range: NSRange(location: 0, length: stringFor.count))
        
        return attributedString
    }
    
    func deleteReminders(_ reminders: [Reminder]) {
        reminderVCHelper.deleteRemindes(reminders)
        if(searchController.isActive){
            reminderVCHelper.loadSearchResults(searchText: "")
        }
        else{
            getNonDeletedReminders()
            return
        }
        tableView.reloadData()
    }
    
    func getNonDeletedReminders() {
        switch(reminderVCHelper.status){
        case .all:
            reminderVCHelper.fetchAllRemindersForDates()
        case .completed:
            reminderVCHelper.fetchCompletedRemindersForDates()
        case .missed:
            reminderVCHelper.fetchMissedRemindersForDates()
        case .yetToTake:
            reminderVCHelper.fetchYetToTakeRemindersForFutureDates()
        }
        
        tableView.reloadData()
    }
}

extension RemiderListVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(searchController.isActive == false && reminderVCHelper.status == .yetToTake){
            if(reminderVCHelper.futureDates.count == 0){
                noReminderLabel.alpha = 1
                noReminderImageView.alpha = 1
                isTrashButtonEnabled = false
            }
            else{
                noReminderImageView.alpha = 0
                noReminderLabel.alpha = 0
            }
            return reminderVCHelper.futureDates.count
        }
        
        if(reminderVCHelper.sortedDates.count == 0){
            if(searchController.isActive && searchController.searchBar.text?.count != 0) {
                noSearchResultImageView.alpha = 1
                noSearchResultHeader.alpha = 1
                noSearchResultBody.alpha = 1
                noReminderLabel.alpha = 0
                noReminderImageView.alpha = 0
            }
            else{
                noSearchResultImageView.alpha = 0
                noSearchResultHeader.alpha = 0
                noSearchResultBody.alpha = 0
                noReminderLabel.alpha = 1
                noReminderImageView.alpha = 1
                isTrashButtonEnabled = false
            }
        }
        else{
            noSearchResultImageView.alpha = 0
            noSearchResultHeader.alpha = 0
            noSearchResultBody.alpha = 0
            noReminderLabel.alpha = 0
            noReminderImageView.alpha = 0
        }
        
        tableView.isEditing = false
        tableView.allowsSelectionDuringEditing = false
        tableView.allowsMultipleSelection = false
        
        return reminderVCHelper.sortedDates.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchController.isActive){
            switch(reminderVCHelper.status){
            case .yetToTake:
                if(reminderVCHelper.tempYetToTakeMedicines.count == 0){
                    return 0
                }
                return reminderVCHelper.tempYetToTakeMedicines[section].count
            case .missed:
                if(reminderVCHelper.tempMissedReminders.count == 0){
                    return 0
                }
                return reminderVCHelper.tempMissedReminders[section].count
            case .completed:
                if(reminderVCHelper.tempCompletedReminders.count == 0){
                    return 0
                }
                return reminderVCHelper.tempCompletedReminders[section].count
            default:
                if(reminderVCHelper.tempAllMedicines.count == 0){
                    return 0
                }
                return reminderVCHelper.tempAllMedicines[section].count
            }
        }
        else{
            switch(reminderVCHelper.status){
            case .yetToTake:
                if(reminderVCHelper.yetToTakeReminders.count == 0){
                    return 0
                }
                return reminderVCHelper.yetToTakeReminders[section].count
            case .missed:
                if(reminderVCHelper.missedReminders.count == 0){
                    return 0
                }
                return reminderVCHelper.missedReminders[section].count
            case .completed:
                if(reminderVCHelper.completedReminders.count == 0 || reminderVCHelper.completedReminders.count <= section){
                    return 0
                }
                return reminderVCHelper.completedReminders[section].count
            default:
                if(reminderVCHelper.allMedicines.count == 0){
                    return 0
                }
                return reminderVCHelper.allMedicines[section].count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderListTableViewCell.identifier, for: indexPath) as? ReminderListTableViewCell else {
            return UITableViewCell()
        }
        
        guard let source = searchController.searchBar.text else {
            return UITableViewCell()
        }
        
        var reminder: Reminder!
        
        if(searchController.isActive){
            switch(reminderVCHelper.status){
            case .yetToTake:
                reminder = reminderVCHelper.tempYetToTakeMedicines[indexPath.section][indexPath.row]
                let target = reminder.medicineName
                
                cell.reminder = reminder
                
                let mutableString = NSMutableAttributedString()
                
                mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                
                cell.medText = mutableString

                cell.reminder = reminder
                
            case .missed:
                reminder = reminderVCHelper.tempMissedReminders[indexPath.section][indexPath.row]
                let target = reminder.medicineName
                
                let mutableString = NSMutableAttributedString()
                
                mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                
                cell.medText = mutableString

                cell.reminder = reminder
                
            case .completed:
                reminder = reminderVCHelper.tempCompletedReminders[indexPath.section][indexPath.row]
                let target = reminder.medicineName
                
                
                cell.reminder = reminder
                
                let mutableString = NSMutableAttributedString()
                
                mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                
                cell.medText = mutableString

                cell.reminder = reminder
            case .all:
                reminder = reminderVCHelper.tempAllMedicines[indexPath.section][indexPath.row]
                let target = reminder.medicineName
                
                cell.reminder = reminder
                
                if(reminder.status == "MISSED"){
                    let mutableString = NSMutableAttributedString()
                    
                    mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                    mutableString.append(getAttributed(stringFor: "  (Missed)", withColor: .systemRed))
                    
                    cell.medText = mutableString

                    cell.reminder = reminder
                }
                else if(reminder.status == "COMPLETED"){
                    let mutableString = NSMutableAttributedString()
                    
                    mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                    mutableString.append(getAttributed(stringFor: "  (Completed)", withColor: .systemGreen))
                    
                    cell.medText = mutableString

                    cell.reminder = reminder
                }
                else{
                    let mutableString = NSMutableAttributedString()
                    
                    mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                    mutableString.append(getAttributed(stringFor: "  (Yet to take)", withColor: .systemGray))
                    
                    cell.medText = mutableString

                    cell.reminder = reminder
                }
            }
        }
        else{
            switch(reminderVCHelper.status){
            case .yetToTake:
                reminder = reminderVCHelper.yetToTakeReminders[indexPath.section][indexPath.row]
                let target = reminder.medicineName
                
                cell.reminder = reminder
                
                let mutableString = NSMutableAttributedString()
                
                mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                
                cell.medText = mutableString

                cell.reminder = reminder
                
            case .missed:
                reminder = reminderVCHelper.missedReminders[indexPath.section][indexPath.row]
                let target = reminder.medicineName
                
                let mutableString = NSMutableAttributedString()
                
                mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                
                cell.medText = mutableString
                
                cell.reminder = reminder
                
            case .completed:
                reminder = reminderVCHelper.completedReminders[indexPath.section][indexPath.row]
                let target = reminder.medicineName
                
                let mutableString = NSMutableAttributedString()
                
                mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                
                cell.medText = mutableString
                
                cell.reminder = reminder
                
                print(reminder.status)
                
            case .all:
                reminder = reminderVCHelper.allMedicines[indexPath.section][indexPath.row]
                let target = reminder.medicineName
            
                if(reminder.status == "MISSED"){
                    let mutableString = NSMutableAttributedString()
                    
                    mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                    mutableString.append(getAttributed(stringFor: "  (Missed)", withColor: .systemRed))
                    
                    cell.medText = mutableString

                    cell.reminder = reminder
                }
                else if(reminder.status == "COMPLETED"){
                    let mutableString = NSMutableAttributedString()
                    
                    mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                    mutableString.append(getAttributed(stringFor: "  (Completed)", withColor: .systemGreen))
                    
                    cell.medText = mutableString

                    cell.reminder = reminder
                }
                else{
                    let mutableString = NSMutableAttributedString()
                    
                    mutableString.append(reminderVCHelper.highlight(fromSource: source, toTarget: target))
                    mutableString.append(getAttributed(stringFor: "  (Yet to take)", withColor: .systemGray))
                    
                    cell.medText = mutableString

                    cell.reminder = reminder
                }
                
                cell.reminder = reminder
            }
        }
        
        cell.selectedImageView.isHidden = !isMultipleSelectionEnabled
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(searchController.isActive == false && reminderVCHelper.status == .yetToTake && reminderVCHelper.futureDates.count > 0){
            let dateToCheck = reminderVCHelper.futureDates[section]
            let dateArray = dateToCheck.split(separator: "-")
            let date = "\(dateArray[2])-\(dateArray[1])-\(dateArray[0])"
            
            let today = Date.now
            let midnight = calendar.startOfDay(for: today)
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: midnight)!
            
            if(dateToCheck == dateFormatter.string(from: today)){
                return "Today"
            }
            else if(dateToCheck == dateFormatter.string(from: tomorrow)){
                return "Tomorrow"
            }
            
            return date
        }
        
        let dateArray = reminderVCHelper.sortedDates[section].split(separator: "-")
        let date = "\(dateArray[2])-\(dateArray[1])-\(dateArray[0])"
        
        return date
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Selection Called")
        if(isMultipleSelectionEnabled){
            guard let cell = tableView.cellForRow(at: indexPath) as? ReminderListTableViewCell else {
                return
            }
            
            cell.setSelected(true, animated: true)
            
            guard let reminder = cell.reminder else {
                return
            }
            
            reminderVCHelper.multipleSelectedRemindersToDelete.append(reminder)
            
            if let selectedRows = tableView.indexPathsForSelectedRows {
                if(selectedRows.count == reminderVCHelper.getTotalRows(isSearchActive: searchController.isActive)) {
                    navigationItem.leftBarButtonItem = deSelectAllBarButton
                    barButtonAtLeft = deSelectAllBarButton
                }
                isTrashButtonEnabled = true
            }
            else{
                isTrashButtonEnabled = false
            }
            
            return
        }
        
        var reminder: Reminder?
        
        if(searchController.isActive == true){
            switch(reminderVCHelper.status){
            case .all:
                reminder = reminderVCHelper.tempAllMedicines[indexPath.section][indexPath.row]
            case .completed:
                reminder = reminderVCHelper.tempCompletedReminders[indexPath.section][indexPath.row]
            case .missed:
                reminder = reminderVCHelper.tempMissedReminders[indexPath.section][indexPath.row]
            case .yetToTake:
                reminder = reminderVCHelper.tempYetToTakeMedicines[indexPath.section][indexPath.row]
            }
        }
        else{
            switch(reminderVCHelper.status){
            case .all:
                reminder = reminderVCHelper.allMedicines[indexPath.section][indexPath.row]
            case .completed:
                reminder = reminderVCHelper.completedReminders[indexPath.section][indexPath.row]
            case .missed:
                reminder = reminderVCHelper.missedReminders[indexPath.section][indexPath.row]
            case .yetToTake:
                reminder = reminderVCHelper.yetToTakeReminders[indexPath.section][indexPath.row]
            }
        }
        
        let medicineInformationVC = MedicineInformationVC(reminder: reminder!)
        
        medicineInformationVC.postDeletionDelegate = self
        
        navigationController?.pushViewController(medicineInformationVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        loadEmptyImage(forIndexPath: indexPath)
        
        if(isMultipleSelectionEnabled) {
            guard let cell = tableView.cellForRow(at: indexPath) as? ReminderListTableViewCell,
                  let reminder = cell.reminder else {
                return
            }
            
            reminderVCHelper.removeRemindersBeforeDeletion(reminder)
        }
        
        if let _ = tableView.indexPathsForSelectedRows {
            isTrashButtonEnabled = true
        }
        else{
            isTrashButtonEnabled = false
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if(isMultipleSelectionEnabled) {
            return nil
        }
        
        guard let reminderCell = self.tableView(tableView, cellForRowAt: indexPath) as? ReminderListTableViewCell,
              let reminder = reminderCell.reminder else {
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete Reminder") { action, _, _ in
//            self.deleteReminders([reminder])
            let alertViewController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)

            alertViewController.addAction(UIAlertAction(title: "Cancel", style: .default))
            
            alertViewController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
                self.deleteReminders([reminder])
            }))

            self.present(alertViewController, animated: true)
        }
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if(isMultipleSelectionEnabled) {
            return nil
        }
        
        if(searchController.isActive == true){
            switch(reminderVCHelper.status){
            case .missed:
                
                let action = UIContextualAction(style: .normal, title: "Mark As Completed") { [self] _, _, _ in
                    reminderVCHelper.changeStateToCompleted(forReminder: reminderVCHelper.tempMissedReminders[indexPath.section][indexPath.row])
                    
                    reminderVCHelper.fetchCompletedRemindersForDates()
                    reminderVCHelper.loadSearchResults(searchText: searchController.searchBar.text ?? "")
                    
                    tableView.reloadData()
                }
                
                action.backgroundColor = .systemGreen
                
                return UISwipeActionsConfiguration(actions: [action])
                
            case .yetToTake:
                
                let action = UIContextualAction(style: .normal, title: "Mark As Completed") { [self] _, _, _ in
                    reminderVCHelper.changeStateToCompleted(forReminder: reminderVCHelper.tempYetToTakeMedicines[indexPath.section][indexPath.row])
                    
                    reminderVCHelper.fetchCompletedRemindersForDates()
                    reminderVCHelper.loadSearchResults(searchText: searchController.searchBar.text ?? "")
                    
                    tableView.reloadData()
                }
                
                action.backgroundColor = .systemGreen
                
                return UISwipeActionsConfiguration(actions: [action])
                
            case .all:
                
                if(reminderVCHelper.tempAllMedicines[indexPath.section][indexPath.row].status != ReminderState.completed.updateFieldName){
                    let action = UIContextualAction(style: .normal, title: "Mark As Completed") { [self] _, _, _ in
                        reminderVCHelper.changeStateToCompleted(forReminder: reminderVCHelper.tempAllMedicines[indexPath.section][indexPath.row])
                        
                        reminderVCHelper.fetchCompletedRemindersForDates()
                        reminderVCHelper.loadSearchResults(searchText: searchController.searchBar.text ?? "")
                        
                        tableView.reloadData()
                    }
                    
                    action.backgroundColor = .systemGreen
                    
                    return UISwipeActionsConfiguration(actions: [action])
                }
                fallthrough
                
            default:
                return nil
            }
        }
        else{
            switch(reminderVCHelper.status){
            case .missed:
                
                let action = UIContextualAction(style: .normal, title: "Mark As Completed") { [self] _, _, _ in
                    reminderVCHelper.changeStateToCompleted(forReminder: reminderVCHelper.missedReminders[indexPath.section][indexPath.row])
                    
                    reminderVCHelper.fetchMissedRemindersForDates()
                    tableView.reloadData()
                }
                
                action.backgroundColor = .systemGreen
                
                return UISwipeActionsConfiguration(actions: [action])
                
            case .yetToTake:
                
                let action = UIContextualAction(style: .normal, title: "Mark As Completed") { [self] _, _, _ in
                    reminderVCHelper.changeStateToCompleted(forReminder: reminderVCHelper.yetToTakeReminders[indexPath.section][indexPath.row])
                    
                    reminderVCHelper.fetchYetToTakeRemindersForFutureDates()
                    tableView.reloadData()
                }
                
                action.backgroundColor = .systemGreen
                
                return UISwipeActionsConfiguration(actions: [action])
                
            case .all:
                
                if(reminderVCHelper.allMedicines[indexPath.section][indexPath.row].status != ReminderState.completed.updateFieldName){
                    let action = UIContextualAction(style: .normal, title: "Mark As Completed") { [self] _, _, _ in
                        reminderVCHelper.changeStateToCompleted(forReminder: reminderVCHelper.allMedicines[indexPath.section][indexPath.row])
                        
                        reminderVCHelper.fetchAllRemindersForDates()
                        tableView.reloadData()
                    }
                    
                    action.backgroundColor = .systemGreen
                    
                    return UISwipeActionsConfiguration(actions: [action])
                }
                fallthrough
                
            default:
                return nil
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        if(isMultipleSelectionEnabled) {
            return nil
        }
        
        let contextMenu = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {[self] menu in

            var markAsCompletedAction: UIAction?
            var deleteContextAction: UIAction?

            if(searchController.isActive == true){
                switch(reminderVCHelper.status){
                case .missed:
                    markAsCompletedAction = UIAction(title: "Mark As Completed") { action in
                        self.reminderVCHelper.changeStateToCompleted(forReminder: self.reminderVCHelper.tempMissedReminders[indexPath.section][indexPath.row])

                        self.reminderVCHelper.loadSearchResults(searchText: self.searchController.searchBar.text ?? "")
                        tableView.reloadData()
                    }

                case .yetToTake:

                    markAsCompletedAction = UIAction(title: "Mark As Completed") { action in
                        self.reminderVCHelper.changeStateToCompleted(forReminder: self.reminderVCHelper.tempYetToTakeMedicines[indexPath.section][indexPath.row])

                        self.reminderVCHelper.loadSearchResults(searchText: self.searchController.searchBar.text ?? "")
                        tableView.reloadData()
                    }

                case .all:

                    if(reminderVCHelper.tempAllMedicines[indexPath.section][indexPath.row].status != ReminderState.completed.updateFieldName){
                        let action = UIContextualAction(style: .normal, title: "Mark As Completed") { [self] _, _, _ in
                            reminderVCHelper.changeStateToCompleted(forReminder: reminderVCHelper.tempAllMedicines[indexPath.section][indexPath.row])

                            reminderVCHelper.loadSearchResults(searchText: searchController.searchBar.text ?? "")
                            tableView.reloadData()
                        }

                        markAsCompletedAction = UIAction(title: "Mark As Completed") { action in
                            self.reminderVCHelper.changeStateToCompleted(forReminder: self.reminderVCHelper.tempYetToTakeMedicines[indexPath.section][indexPath.row])

                            self.reminderVCHelper.loadSearchResults(searchText: self.searchController.searchBar.text ?? "")
                            tableView.reloadData()
                        }
                    }

                default:
                    markAsCompletedAction = nil
                }
            }
            else{
                switch(reminderVCHelper.status){
                case .missed:

                    markAsCompletedAction = UIAction(title: "Mark As Completed") { action in
                        self.reminderVCHelper.changeStateToCompleted(forReminder: self.reminderVCHelper.missedReminders[indexPath.section][indexPath.row])

                        self.reminderVCHelper.fetchMissedRemindersForDates()
                        tableView.reloadData()
                    }

                case .yetToTake:

                    markAsCompletedAction = UIAction(title: "Mark As Completed") { action in
                        self.reminderVCHelper.changeStateToCompleted(forReminder: self.reminderVCHelper.yetToTakeReminders[indexPath.section][indexPath.row])

                        self.reminderVCHelper.fetchYetToTakeRemindersForFutureDates()
                        tableView.reloadData()
                    }

                case .all:

                    if(reminderVCHelper.allMedicines[indexPath.section][indexPath.row].status != ReminderState.completed.updateFieldName){

                        markAsCompletedAction = UIAction(title: "Mark As Completed") { action in
                            self.reminderVCHelper.changeStateToCompleted(forReminder: self.reminderVCHelper.allMedicines[indexPath.section][indexPath.row])

                            self.reminderVCHelper.fetchAllRemindersForDates()
                            tableView.reloadData()
                        }
                    }

                default:
                    markAsCompletedAction = nil
                }
            }

            guard let reminderCell = self.tableView(tableView, cellForRowAt: indexPath) as? ReminderListTableViewCell,
                  let reminder = reminderCell.reminder else {
                return UIMenu()
            }


            deleteContextAction = UIAction(title: "Delete Reminder",
                                           image: UIImage(systemName: "trash"),
                                           attributes: .destructive) { action in

                let alertViewController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)

                alertViewController.addAction(UIAlertAction(title: "Cancel", style: .default))
                
                alertViewController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
                    self.deleteReminders([reminder])
                }))

                self.present(alertViewController, animated: true)
            }

            guard let deleteContextAction = deleteContextAction else {
                return UIMenu()
            }

            if let markAsCompletedAction = markAsCompletedAction {
                markAsCompletedAction.image = UIImage(systemName: "checkmark")

                let menu = UIMenu(title: "", options: .singleSelection, children: [markAsCompletedAction, deleteContextAction])

                return menu
            }

            let menu = UIMenu(title: "", options: .singleSelection, children: [deleteContextAction])

            return menu
        }

        return contextMenu
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(section == reminderVCHelper.sortedDates.count - 1){
            if(searchController.isActive == false || searchController.searchBar.text?.count == 0){
                return nil
            }
            
            footerView.addSubview(footerLabel)
        
            footerLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                footerLabel.topAnchor.constraint(equalTo: footerView.topAnchor,constant: 10),
                footerLabel.centerXAnchor.constraint(equalTo: footerView.centerXAnchor)
            ])
            
            var resultString = ""
            
            switch(reminderVCHelper.status){
            case .all:
                let searchCount = reminderVCHelper.getCount(of: reminderVCHelper.tempAllMedicines)
                let totalCount = reminderVCHelper.getCount(of: reminderVCHelper.allMedicines)
                
                resultString = "\(searchCount) / \(totalCount) searches appearing"
            case .yetToTake:
                let searchCount = reminderVCHelper.getCount(of: reminderVCHelper.tempYetToTakeMedicines)
                let totalCount = reminderVCHelper.getCount(of: reminderVCHelper.yetToTakeReminders)
                
                resultString = "\(searchCount) / \(totalCount) searches appearing"
            case .missed:
                let searchCount = reminderVCHelper.getCount(of: reminderVCHelper.tempMissedReminders)
                let totalCount = reminderVCHelper.getCount(of: reminderVCHelper.missedReminders)
                
                resultString = "\(searchCount) / \(totalCount) searches appearing"
            case .completed:
                let searchCount = reminderVCHelper.getCount(of: reminderVCHelper.tempCompletedReminders)
                let totalCount = reminderVCHelper.getCount(of: reminderVCHelper.completedReminders)
                
                resultString = "\(searchCount) / \(totalCount) searches appearing"
            }
            
            footerLabel.text = resultString
            
            return footerView

        }
        return nil
    }
}

extension RemiderListVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadRequiredDatas()
        
        tableView.reloadData()
    }
}
