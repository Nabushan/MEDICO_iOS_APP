//
//  UserCartAddNewShippingAddressVC.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/12/22.
//

import UIKit

class UserCartAddNewShippingAddressVC: UIViewController, NewShippingAddressProtocol {

    override var sheetPresentationController: UISheetPresentationController! {
        return presentationController as? UISheetPresentationController
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.register(CartShippingNewAddressEntryTableViewCell.self, forCellReuseIdentifier: CartShippingNewAddressEntryTableViewCell.identifier)
        
        tableView.keyboardDismissMode = .onDrag
        
        return tableView
    }()
    
    lazy var contactNumberToolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        return toolBar
    }()
    
    lazy var pinCodeToolBar: UIToolbar = {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        return toolBar
    }()
    
    var textFields: [UITextField] = []
    var labels: [ResizedLabel] = []
    
    var rightBarButton: UIBarButtonItem = UIBarButtonItem()
    var leftBarButton: UIBarButtonItem = UIBarButtonItem()
    var tableViewBottomAnchor: NSLayoutConstraint?
    var isContentPushed: Bool = false
    
    var previousAddressListCount = -1
    var isForEditingShippingAddress: Bool = false
    var shippingAddress: ShippingAddress?
    
    let userCartAddNewShippingAddressHelper: UserCartAddNewShippingAddressHelper
    
    weak var delegateForShippingAddressCommunication: ShippingAddressUpdateCommunicationProtocol?
    
    init(previousAddressListCount: Int) {
        userCartAddNewShippingAddressHelper = UserCartAddNewShippingAddressHelper()
        self.previousAddressListCount = previousAddressListCount
        
        super.init(nibName: nil, bundle: nil)
        
        userCartAddNewShippingAddressHelper.delegate = self
    }
    
    init(isForEditingShippingAddress: Bool, forId: Int, _ shippingAddress: ShippingAddress) {
        userCartAddNewShippingAddressHelper = UserCartAddNewShippingAddressHelper()
        self.isForEditingShippingAddress = isForEditingShippingAddress
        self.previousAddressListCount = forId
        self.shippingAddress = shippingAddress
        
        super.init(nibName: nil, bundle: nil)
        
        userCartAddNewShippingAddressHelper.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = tableView.backgroundColor
        
        view.addSubview(tableView)

        configureTableView()
        configureSheetPresentationController()
        loadTableView()
        
        rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapBarButtonDone))
        leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapBarButtonCancel))
        
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.leftBarButtonItem = leftBarButton
        
        if(UITraitCollection.current.userInterfaceIdiom == .phone) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (textFields[3].isFirstResponder && (self.view.frame.origin.y == 0)) {
                if(self.view.frame.height < 800) {
                    self.view.frame.origin.y -= keyboardSize.height - 100
                }
                else{
                    self.view.frame.origin.y -= keyboardSize.height - 70
                }
            }
            else if (textFields[2].isFirstResponder && (self.view.frame.origin.y != 0)){
                self.view.frame.origin.y = 0
                isContentPushed = false
            }
            else if (textFields[4].isFirstResponder && !isContentPushed) {
                self.view.frame.origin.y -= 60
                isContentPushed = true
            }
            else if (textFields[5].isFirstResponder && !isContentPushed) {
                self.view.frame.origin.y -= keyboardSize.height
                isContentPushed = true
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        isContentPushed = false
    }
    
    @objc func didTapBarButtonDone(_ sender: UIBarButtonItem) {
        
        guard let name = textFields[0].text,
              let contactNumber = textFields[1].text,
              let doorNumber = textFields[2].text,
              let addressLineOne = textFields[3].text,
              let addressLineTwo = textFields[4].text,
              let pincode = textFields[5].text else {
            return
        }
        
        var id = -1
        
        if(isForEditingShippingAddress){
            id = previousAddressListCount
        }
        else{
            id = previousAddressListCount + 1
        }
        
        let shippingAddress = ShippingAddress(id: id,
                                              name: name,
                                              contactNumber: contactNumber,
                                              doorNumber: doorNumber,
                                              addressLine1: addressLineOne,
                                              addressLine2: addressLineTwo,
                                              pincode: pincode,
                                              forUserId: UserDefaults.standard.integer(forKey: "User - Id"))
        
        delegateForShippingAddressCommunication?.selectShippingAddressCell = shippingAddress
        
        let alertMessages = userCartAddNewShippingAddressHelper.validateContents(shippingAddress)
        
        let alertVC = UIAlertController(title: alertMessages.title, message: alertMessages.body, preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Okay", style: .default){_ in
            if(alertMessages.state) {
                if(self.isForEditingShippingAddress) {
                    self.userCartAddNewShippingAddressHelper.updateShippingAddress(forId: id, shippingAddress)
                }
                else{
                    self.userCartAddNewShippingAddressHelper.addShippingAddress(shippingAddress)
                }
                self.delegateForShippingAddressCommunication?.reloadTableViewToShowAddedShippingAddress()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.dismiss(animated: true)
                }
            }
        })
        
        present(alertVC, animated: true)
    }
    
    @objc func didTapBarButtonCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @objc func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        for textField in textFields{
            textField.resignFirstResponder()
        }
        
        self.view.frame.origin.y = 0
        isContentPushed = false
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureSheetPresentationController() {
        sheetPresentationController.delegate = self
        sheetPresentationController.detents = [.large()]
        sheetPresentationController.preferredCornerRadius = 10
        sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
    }
    
    func loadTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        addTapGesture(toView: tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    func addTapGesture(toView: UIView) {
        let tapGesture = UITapGestureRecognizer()
        
        if(toView == tableView) {
            tapGesture.addTarget(self, action: #selector(dismissKeyBoard))
        }
        
        toView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapContactNumberNextButton(_ sender: UIBarButtonItem) {
        textFields[2].becomeFirstResponder()
    }
    
    @objc func didTapPinCodeDoneButton(_ sender: UIBarButtonItem) {
        textFields[5].resignFirstResponder()
    }
    
    func resignTextFields() {
        for textField in textFields {
            if(textField.isFirstResponder) {
                textField.resignFirstResponder()
                return
            }
        }
    }
}

extension UserCartAddNewShippingAddressVC: UISheetPresentationControllerDelegate {
    
}

extension UserCartAddNewShippingAddressVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartShippingNewAddressEntryTableViewCell.identifier) as? CartShippingNewAddressEntryTableViewCell else{
            return UITableViewCell()
        }
        
        switch(indexPath.section) {
        case 0:
            cell.textField.placeholder = "Name"
            cell.textField.returnKeyType = .next
            cell.textField.keyboardType = .alphabet
            
            if(isForEditingShippingAddress) {
                cell.textField.text = shippingAddress?.name
            }
        case 1:
            cell.textField.placeholder = "Contact No"
            cell.textField.returnKeyType = .next
            cell.textField.keyboardType = .numberPad
            
            let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(didTapContactNumberNextButton))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            contactNumberToolBar.setItems([flexibleSpace, nextButton], animated: true)
            
            cell.textField.inputAccessoryView = contactNumberToolBar
            
            if(isForEditingShippingAddress) {
                cell.textField.text = shippingAddress?.contactNumber
            }
        case 2:
            cell.textField.placeholder = "Door No"
            cell.textField.returnKeyType = .next
            cell.textField.keyboardType = .alphabet
            
            if(isForEditingShippingAddress) {
                cell.textField.text = shippingAddress?.doorNumber
            }
        case 3:
            cell.textField.placeholder = "Add Line 1"
            cell.textField.returnKeyType = .next
            cell.textField.keyboardType = .alphabet
            
            if(isForEditingShippingAddress) {
                cell.textField.text = shippingAddress?.addressLine1
            }
        case 4:
            cell.textField.placeholder = "Add Line 2"
            cell.textField.returnKeyType = .next
            cell.textField.keyboardType = .alphabet
            
            if(isForEditingShippingAddress) {
                cell.textField.text = shippingAddress?.addressLine2
            }
        case 5:
            cell.textField.placeholder = "Pincode"
            cell.textField.returnKeyType = .done
            cell.textField.keyboardType = .numberPad
            
            let nextButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapPinCodeDoneButton))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            pinCodeToolBar.setItems([flexibleSpace, nextButton], animated: true)
            
            cell.textField.inputAccessoryView = pinCodeToolBar
            
            if(isForEditingShippingAddress) {
                cell.textField.text = shippingAddress?.pincode
            }
        default:
            ()
        }
        
        cell.textField.delegate = self
        textFields.append(cell.textField)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "Add New Shipping Address"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        
        lazy var textLimitLabel: ResizedLabel = {
            let label = ResizedLabel()
            
            label.font = UIFont(name: "Helvetica", size: 13)
            label.contentMode = .right
            label.textAlignment = .right
            label.textColor = .label
            
            return label
        }()
        
        textLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textLimitLabel)
        
        NSLayoutConstraint.activate([
            textLimitLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            textLimitLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        switch(section) {
        case 0:
            textLimitLabel.text = "0 / 70"
        case 1:
            textLimitLabel.text = "0 / 10"
        case 2:
            textLimitLabel.text = "0 / 10"
        case 3:
            textLimitLabel.text = "0 / 100"
        case 4:
            textLimitLabel.text = "0 / 100"
        case 5:
            textLimitLabel.text = "0 / 6"
        default:
            ()
        }
        
        labels.append(textLimitLabel)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        20
    }
}

extension UserCartAddNewShippingAddressVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        var maxLength = 0
        
        if(textField == textFields[0]) {
            maxLength = 70
            
            guard let textCount = textField.text?.count else {
                return
            }
            
            let difference = maxLength - textCount
            if(difference <= 10){
                labels[0].textColor = .red
            }
            else{
                labels[0].textColor = .label
            }
            
            if(difference == 0) {
                labels[0].text = "Limit Reached."
            }
            else{
                labels[0].text = "\(textCount) / 70"
            }
        }
        else if(textField == textFields[1]) {
            maxLength = 10
            
            guard let textCount = textField.text?.count else {
                return
            }
            
            labels[1].textColor = .label
            
            labels[1].text = "\(textCount) / 10"
        }
        else if(textField == textFields[2]) {
            maxLength = 10
            
            guard let textCount = textField.text?.count else {
                return
            }
            
            let difference = maxLength - textCount
            if(difference <= 2){
                labels[2].textColor = .red
            }
            else{
                labels[2].textColor = .label
            }
            
            if(difference == 0) {
                labels[2].text = "Limit Reached."
            }
            else{
                labels[2].text = "\(textCount) / 10"
            }
        }
        else if(textField == textFields[3]) {
            maxLength = 100
            
            guard let textCount = textField.text?.count else {
                return
            }
            
            let difference = maxLength - textCount
            if(difference <= 10){
                labels[3].textColor = .red
            }
            else{
                labels[3].textColor = .label
            }
            
            if(difference == 0) {
                labels[3].text = "Limit Reached."
            }
            else{
                labels[3].text = "\(textCount) / 100"
            }
        }
        else if(textField == textFields[4]) {
            maxLength = 100
            
            guard let textCount = textField.text?.count else {
                return
            }
            
            let difference = maxLength - textCount
            if(difference <= 10){
                labels[4].textColor = .red
            }
            else{
                labels[4].textColor = .label
            }
            
            if(difference == 0) {
                labels[4].text = "Limit Reached."
            }
            else{
                labels[4].text = "\(textCount) / 100"
            }
        }
        else if(textField == textFields[5]) {
            maxLength = 6
            
            guard let textCount = textField.text?.count else {
                return
            }
            
            labels[5].textColor = .label
            
            labels[5].text = "\(textCount) / 6"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var maxLength = 10
        
        if(textField == textFields[0]) {
            maxLength = 70
        }
        else if(textField == textFields[1]) {
            maxLength = 10
        }
        else if(textField == textFields[2]) {
            maxLength = 10
        }
        else if(textField == textFields[3]) {
            maxLength = 100
        }
        else if(textField == textFields[4]) {
            maxLength = 100
        }
        else if(textField == textFields[5]) {
            maxLength = 6
        }
        
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == textFields[0]) {
            textFields[1].becomeFirstResponder()
        }
        else if(textField == textFields[1]) {
            textFields[2].becomeFirstResponder()
        }
        else if(textField == textFields[2]){
            textFields[3].becomeFirstResponder()
        }
        else if(textField == textFields[3]){
            textFields[4].becomeFirstResponder()
        }
        else if(textField == textFields[4]){
            textFields[5].becomeFirstResponder()
        }
        else if(textField == textFields[5]){
            textFields[5].resignFirstResponder()
        }
        
        return true
    }
}
