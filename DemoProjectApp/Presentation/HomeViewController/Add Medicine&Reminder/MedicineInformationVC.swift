//
//  MedicineInformationVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/09/22.
//

import UIKit

class MedicineInformationVC: UIViewController, MedicineInformationVCProtocol {

    lazy var medicineImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.image = UIImage(named: "Log In")
        
        return imageView
    }()
    
    lazy var medicineNameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 1
        label.textAlignment = .left
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        
        return label
    }()
    
    lazy var medicineBodyLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.numberOfLines = 0
        label.textAlignment = .left
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    lazy var medicineTag: ResizedLabelWithExtraWidth = {
        let label = ResizedLabelWithExtraWidth()
        
        label.numberOfLines = 1
        label.textAlignment = .center
        label.contentMode = .left
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var markAsCompletedButton: ResizedButton = {
        let button = ResizedButton()
        
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    lazy var deleteReminderButton: ResizedButton = {
        let button = ResizedButton()
        
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    lazy var detailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutProvider.getMedicineDetailsLayout())
        
        collectionView.register(MedicineInformationCollectionViewCell.self, forCellWithReuseIdentifier: MedicineInformationCollectionViewCell.identifier)
        
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let layoutProvider = CollectionViewLayoutProvider()
    
    var medicineInformationVCHelper: MedicineInformationVCHelper
    
    var reminder: Reminder
    weak var postDeletionDelegate: ReminderPostDeletionProtocol?
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    init(reminder: Reminder) {
        
        self.reminder = reminder
        self.medicineInformationVCHelper = MedicineInformationVCHelper()
        
        super.init(nibName: nil, bundle: nil)
        medicineInformationVCHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Medicine Details"
        
        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        
        view.addSubview(scrollView)
        scrollView.addSubview(medicineImage)
        scrollView.addSubview(medicineNameLabel)
        scrollView.addSubview(medicineBodyLabel)
        scrollView.addSubview(medicineTag)
        scrollView.addSubview(detailCollectionView)
        scrollView.addSubview(markAsCompletedButton)
        scrollView.addSubview(deleteReminderButton)
        
        configureDetailCollectionView()
        
        loadContents()
        loadScrollView()
    }
    
    func configureDetailCollectionView() {
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        detailCollectionView.collectionViewLayout = layoutProvider.getMedicineDetailsLayout()
        loadContents()
        
        detailCollectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        detailCollectionView.collectionViewLayout = layoutProvider.getMedicineDetailsLayout()
        loadContents()
        
        detailCollectionView.reloadData()
    }
    
    func loadContents() {
        loadImageView()
        loadMedicineLabel()
        loadMedicineBodyLabel()
        loadMedicineTag()
        loadDetailCollectionView()
        loadMarkAsCompletedButton()
        loadDeleteReminderButton()
    }
    
    func loadScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func loadImageView(){
        medicineImage.translatesAutoresizingMaskIntoConstraints = false
        
        medicineImage.image = UIImage(named: reminder.medicineType)
        
        medicineTag.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                medicineImage.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0.1*view.frame.width),
                medicineImage.widthAnchor.constraint(equalToConstant: 0.4*view.frame.width),
                medicineImage.heightAnchor.constraint(equalTo: medicineImage.widthAnchor),
                medicineImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                medicineImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
                medicineImage.widthAnchor.constraint(equalToConstant: 0.6*view.frame.width),
                medicineImage.heightAnchor.constraint(equalTo: medicineImage.widthAnchor),
                medicineImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadMedicineLabel() {
        medicineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        medicineNameLabel.text = reminder.medicineName
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                medicineNameLabel.topAnchor.constraint(equalTo: medicineImage.bottomAnchor,constant: 5),
                medicineNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 0.1*view.frame.width),
                medicineNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -0.1*view.frame.width)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                medicineNameLabel.topAnchor.constraint(equalTo: medicineImage.bottomAnchor,constant: 5),
                medicineNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
                medicineNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    func loadMedicineBodyLabel() {
        medicineBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        medicineBodyLabel.text = reminder.medicineBody
        
        NSLayoutConstraint.activate([
            medicineBodyLabel.topAnchor.constraint(equalTo: medicineNameLabel.bottomAnchor,constant: 5),
            medicineBodyLabel.leadingAnchor.constraint(equalTo: medicineNameLabel.leadingAnchor),
            medicineBodyLabel.trailingAnchor.constraint(equalTo: medicineNameLabel.trailingAnchor)
        ])
    }
    
    func loadMedicineTag() {
        medicineTag.translatesAutoresizingMaskIntoConstraints = false
    
        medicineTag.text = "Medicine Type: \(reminder.medicineType)".capitalized
        
        medicineTag.textColor = .systemBlue
        medicineTag.backgroundColor = .systemGray5
        medicineTag.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            medicineTag.topAnchor.constraint(equalTo: medicineBodyLabel.bottomAnchor,constant: 5),
            medicineTag.leadingAnchor.constraint(equalTo: medicineNameLabel.leadingAnchor)
        ])
    }
    
    func loadDetailCollectionView() {
        detailCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            
            let heightAnchor: NSLayoutConstraint?
            
            if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
                heightAnchor = detailCollectionView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35)
            }
            else{
                heightAnchor = detailCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
            }
            
            guard let heightAnchor = heightAnchor else {
                return
            }
            
            constraints = [
                heightAnchor,
                detailCollectionView.topAnchor.constraint(equalTo: medicineTag.bottomAnchor,constant: 10),
                detailCollectionView.leadingAnchor.constraint(equalTo: medicineBodyLabel.leadingAnchor),
                detailCollectionView.trailingAnchor.constraint(equalTo: medicineBodyLabel.trailingAnchor),
                detailCollectionView.bottomAnchor.constraint(equalTo: markAsCompletedButton.topAnchor,constant: -10)
            ]
        }
        else {
            constraints = [
                detailCollectionView.topAnchor.constraint(equalTo: medicineTag.bottomAnchor,constant: 10),
                detailCollectionView.leadingAnchor.constraint(equalTo: medicineBodyLabel.leadingAnchor),
                detailCollectionView.trailingAnchor.constraint(equalTo: medicineBodyLabel.trailingAnchor),
                detailCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
                detailCollectionView.bottomAnchor.constraint(equalTo: markAsCompletedButton.topAnchor,constant: -10)
            ]
        }
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadMarkAsCompletedButton() {
        markAsCompletedButton.translatesAutoresizingMaskIntoConstraints = false
        
        markAsCompletedButton.setTitle("Mark as Completed", for: .normal)
        markAsCompletedButton.layer.cornerRadius = 10
        
        if(reminder.status == "COMPLETED"){
            markAsCompletedButton.setTitle("Completed", for: .normal)
            markAsCompletedButton.backgroundColor = .systemGray4
        }
        else{
            markAsCompletedButton.setTitle("Mark as Completed", for: .normal)
            markAsCompletedButton.addTarget(self, action: #selector(didTapMarkAsCompletedButton), for: .touchUpInside)
        }
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                markAsCompletedButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -0.15*view.frame.width),
                markAsCompletedButton.trailingAnchor.constraint(equalTo: detailCollectionView.trailingAnchor),
                markAsCompletedButton.widthAnchor.constraint(equalTo: detailCollectionView.widthAnchor, multiplier: 0.49)
                
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                markAsCompletedButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -20),
                markAsCompletedButton.trailingAnchor.constraint(equalTo: detailCollectionView.trailingAnchor),
                markAsCompletedButton.widthAnchor.constraint(equalTo: detailCollectionView.widthAnchor, multiplier: 0.49)
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
    }
    
    @objc func didTapMarkAsCompletedButton(_ sender: UIButton) {
        if(reminder.status != "COMPLETED"){
            medicineInformationVCHelper.changeStateToCompleted(forReminder: reminder)
            reminder.status = "COMPLETED"
            detailCollectionView.reloadData()
            markAsCompletedButton.backgroundColor = .systemGray4
            markAsCompletedButton.setTitle("Completed", for: .normal)
            print("Medicine State Marked as Completed.")
            
            postDeletionDelegate?.getNonDeletedReminders()
        }
    }
    
    func loadDeleteReminderButton() {
        deleteReminderButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteReminderButton.setTitle("Delete Reminder", for: .normal)
        deleteReminderButton.layer.cornerRadius = 10
        deleteReminderButton.backgroundColor = .systemRed
        
        deleteReminderButton.addTarget(self, action: #selector(didTapDeleteReminder), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            deleteReminderButton.bottomAnchor.constraint(equalTo: markAsCompletedButton.bottomAnchor),
            deleteReminderButton.topAnchor.constraint(equalTo: markAsCompletedButton.topAnchor),
            deleteReminderButton.leadingAnchor.constraint(equalTo: detailCollectionView.leadingAnchor),
            deleteReminderButton.widthAnchor.constraint(equalTo: markAsCompletedButton.widthAnchor)
        ])
    }
    
    @objc func didTapDeleteReminder(_ sender: UIButton){
        
        let alertViewController = UIAlertController(title: "Do you really want to delete the selected item(s)", message: "You cannot retrieve once deleted", preferredStyle: .alert)
        
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        alertViewController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.medicineInformationVCHelper.deleteReminder(self.reminder)
            self.postDeletionDelegate?.getNonDeletedReminders()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3){
                self.navigationController?.popViewController(animated: true)
            }
        }))
        
        present(alertViewController, animated: true)
    }
}

extension MedicineInformationVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MedicineInformationCollectionViewCell.identifier, for: indexPath) as? MedicineInformationCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if(indexPath.row == 0){
            cell.textLabel.text = reminder.date
            cell.imageView.image = UIImage(named: "calendar")
        }
        else if(indexPath.row == 1){
            cell.textLabel.text = reminder.time
            cell.imageView.image = UIImage(named: "clock")
        }
        else if(indexPath.row == 2){
            cell.textLabel.text = reminder.status.capitalized
            let image = UIImage(named: "schedule")?.withRenderingMode(.alwaysOriginal)
            cell.imageView.image = image?.withTintColor(.label)
        }
        else if(indexPath.row == 3){
            cell.textLabel.text = "\(reminder.schedule) \(reminder.foodIntervalToTake)".capitalized
            cell.imageView.downloaded(from: "https://cdn-icons-png.flaticon.com/512/2722/2722110.png", shouldRender: true, withColor: .label)
        }
        
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 10

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension MedicineInformationVC {
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
    }
}
