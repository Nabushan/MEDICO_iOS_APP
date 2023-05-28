//
//  BookAppointmentsPatientGenderSelectionTableVC.swift
//  Medico
//
//  Created by nabushan-pt5611 on 20/01/23.
//

import UIKit

class CustomAlertViewWithTableStructure: UITableViewController {

    var tableContent: [String]
    var isSelectable: Bool = false
    var preferredFontSize: Int = 15
    var preferredNumberofLines: Int = 1
    
    init(style: UITableView.Style, tableContent: [String]) {
        self.tableContent = tableContent
        
        super.init(style: style)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = tableView.backgroundColor
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        tableView.register(CustomAlertViewWithTableStructureTableViewCell.self, forCellReuseIdentifier: CustomAlertViewWithTableStructureTableViewCell.identifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomAlertViewWithTableStructureTableViewCell.identifier, for: indexPath) as? CustomAlertViewWithTableStructureTableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = tableContent[indexPath.row]
        cell.label.font = UIFont(name: "Helvetica", size: CGFloat(preferredFontSize))
        cell.label.numberOfLines = preferredNumberofLines
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(isSelectable){
            guard let cell = tableView.cellForRow(at: indexPath) as? CustomAlertViewWithTableStructureTableViewCell else {
                return
            }
            
            cell.accessoryType = .checkmark
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if(isSelectable){
            guard let cell = tableView.cellForRow(at: indexPath) as? CustomAlertViewWithTableStructureTableViewCell else {
                return
            }
            
            cell.accessoryType = .none
        }
    }
}
