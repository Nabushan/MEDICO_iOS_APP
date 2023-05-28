//
//  ReminderRepeatTableVC.swift
//  Medico
//
//  Created by nabushan-pt5611 on 05/02/23.
//

import UIKit

class ReminderRepeatTableVC: UITableViewController, ReminderRepeatProtocol {

    weak var delegate: ReminderRepeatSelectionCommunicationProtocol?
    
    var reminderRepeatTableVCHelper: ReminderRepeatTableVCHelper
    
    var previouslySelectedCell: ReminderRepeatTableViewCell?
    
    init(style: UITableView.Style, withSelectedState: ReminderRepeatPreference) {
        reminderRepeatTableVCHelper = ReminderRepeatTableVCHelper()
        
        super.init(style: style)
        
        reminderRepeatTableVCHelper.delegate = self
        reminderRepeatTableVCHelper.selectedState = withSelectedState
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = tableView.backgroundColor
        self.title = "Repeat"

        configureTableView()
    }

    
    func configureTableView() {
        tableView.register(ReminderRepeatTableViewCell.self, forCellReuseIdentifier: ReminderRepeatTableViewCell.identifier)
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderRepeatTableVCHelper.options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderRepeatTableViewCell.identifier, for: indexPath) as? ReminderRepeatTableViewCell else {
            return UITableViewCell()
        }
        
        let content = reminderRepeatTableVCHelper.options[indexPath.row]
        
        cell.label.text = content
        
        if(content == reminderRepeatTableVCHelper.selectedState.rawValue) {
            previouslySelectedCell = cell
            
            previouslySelectedCell?.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ReminderRepeatTableViewCell else {
            return
        }
        
        guard let selectedState = ReminderRepeatPreference(rawValue: cell.label.text ?? "Never") else {
            return
        }
        
        reminderRepeatTableVCHelper.selectedState = selectedState
        
        if(previouslySelectedCell == nil) {
            previouslySelectedCell = cell
            
            previouslySelectedCell?.accessoryType = .checkmark
        }
        else{
            previouslySelectedCell?.accessoryType = .none
            
            previouslySelectedCell = cell
            
            previouslySelectedCell?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        nil
    }
}

extension ReminderRepeatTableVC {
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.updateSelectedRepeatPreference(for: reminderRepeatTableVCHelper.selectedState)
    }
}
