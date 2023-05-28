//
//  SelectDateAndTimeTableVC.swift
//  Medico
//
//  Created by nabushan-pt5611 on 05/02/23.
//

import UIKit

class SelectDateAndTimeTableVC: UITableViewController, SelectDateAndTimeContentForReminderProtocol {

    weak var delegate: SelectDateAndTimeForReminderProtocol?
    
    var datePickerValue: Date?
    var timePickerValue: Date?
    var shouldShowDateCell: Bool = false
    var isDateCellShown: Bool = false
    var isTimeCellShown: Bool = false
    
    let selectDateAndTimeTableVCHelper: SelectDateAndTimeTableVCHelper
    
    var valueLabels: [ResizedLabel] = []
    var toggleSwitches: [UISwitch] = []
    var selectedReminderRepeatPreference: ReminderRepeatPreference = .never
    var reminderTimings: [ReminderDateAndTime] = []
    
    let dateFormat = "EEEE, MMMM d, yyyy"
    let timeFormat = "HH:mm"
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        
        return dateFormatter
    }()
    
    var datePicker: UIDatePicker?
    
    init(style: UITableView.Style, selectedReminderRepeatPreference: ReminderRepeatPreference) {
        selectDateAndTimeTableVCHelper = SelectDateAndTimeTableVCHelper()
        
        super.init(style: style)
        
        self.selectedReminderRepeatPreference = selectedReminderRepeatPreference
        selectDateAndTimeTableVCHelper.delegate = self
        let cancelBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapNavBarCancel))
        
        let applyBarButton = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(didTapNavBarApply))
        
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = applyBarButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = tableView.backgroundColor
        self.title = "Date & Time"
        
        configureTableView()
        
        datePickerValue = Date.now
        timePickerValue = Date.now
    }
    
    @objc func didTapNavBarCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @objc func didTapNavBarApply(_ sender: UIBarButtonItem) {
        guard let datePickerValue = datePickerValue,
              let timePickerValue = timePickerValue else {
            return
        }
        
        dateFormatter.dateFormat = dateFormat
        print("Date Chosen => ",dateFormatter.string(from: datePickerValue))
        dateFormatter.dateFormat = timeFormat
        print("Time Chosen => ",dateFormatter.string(from: timePickerValue))
        
        reminderTimings = selectDateAndTimeTableVCHelper.getRemindersScheduled(bySelectedState: selectedReminderRepeatPreference, with: datePickerValue, with: timePickerValue)
        
        delegate?.loadDateAndTime(for: reminderTimings, selectedRepeatState: selectedReminderRepeatPreference)
        
        self.dismiss(animated: true)
    }
    
    func configureTableView() {
        tableView.register(DateAndTimeTableViewCell.self, forCellReuseIdentifier: DateAndTimeTableViewCell.identifier)
        
        tableView.register(DateAndTimeDatePickerTableViewCell.self, forCellReuseIdentifier: DateAndTimeDatePickerTableViewCell.identifier)
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        
    }
    
    func show(dateCell: Bool) {
        shouldShowDateCell = true
        tableView.beginUpdates()
        
        var indexPath = IndexPath(row: 0, section: 0)
        let dateCellIndexPath = IndexPath(row: 1, section: 0)
        let timeCellIndexPath = IndexPath(row: 2, section: 0)
        
        if(dateCell) {
            if(isTimeCellShown) {
                tableView.deleteRows(at: [timeCellIndexPath], with: .none)
                isTimeCellShown = false
            }
            
            isDateCellShown = true
            indexPath = dateCellIndexPath
        }
        else{
            if(isDateCellShown) {
                tableView.deleteRows(at: [dateCellIndexPath], with: .none)
                isDateCellShown = false
            }
            
            isTimeCellShown = true
            indexPath = timeCellIndexPath
        }
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
        
        if(dateCell) {
            toggleSwitches[0].setOn(true, animated: true)
            toggleSwitches[1].setOn(false, animated: true)
            
        }
        else{
            toggleSwitches[1].setOn(true, animated: true)
            toggleSwitches[0].setOn(false, animated: true)
        }
    }
    
    
    func hide(dateCell: Bool) {
        shouldShowDateCell = false
        tableView.beginUpdates()
        
        var indexPath = IndexPath(row: 0, section: 0)
        let dateCellIndexPath = IndexPath(row: 1, section: 0)
        let timeCellIndexPath = IndexPath(row: 2, section: 0)
        
        if(dateCell) {
            isDateCellShown = false
            indexPath = dateCellIndexPath
        }
        else{
            isTimeCellShown = false
            indexPath = timeCellIndexPath
        }
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
        
        if(dateCell) {
            toggleSwitches[0].setOn(false, animated: true)
        }
        else{
            toggleSwitches[1].setOn(false, animated: true)
        }
    }
    
    @objc func didTapDateOrTimeToggle(_ sender: UISwitch) {
        if(sender == toggleSwitches[0]) {
            if(sender.isOn) {
                show(dateCell: true)
            }
            else{
                hide(dateCell: true)
            }
        }
        else {
            if(sender.isOn) {
                show(dateCell: false)
            }
            else{
                hide(dateCell: false)
            }
        }
    }
    
    @objc func didChangeDateOrTime(_ sender: UIDatePicker) {
        guard let datePicker = datePicker else {
            return
        }
        
        if(isDateCellShown) {
            dateFormatter.dateFormat = dateFormat
            let todayDate = Date.now
            
            guard let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: todayDate) else {
                return
            }

            if(dateFormatter.string(from: datePicker.date) == dateFormatter.string(from: todayDate)) {
                valueLabels[0].text = "Today"
            }
            else if(dateFormatter.string(from: datePicker.date) == dateFormatter.string(from: tomorrowDate)) {
                valueLabels[0].text = "Tomorrow"
            }
            else {
                valueLabels[0].text = dateFormatter.string(from: datePicker.date)
            }
            
            datePickerValue = datePicker.date
        }
        else if(isTimeCellShown) {
            dateFormatter.dateFormat = timeFormat
            
            valueLabels[1].text = dateFormatter.string(from: datePicker.date)
            
            timePickerValue = datePicker.date
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return selectDateAndTimeTableVCHelper.selectDateAndTimeTableTextContents.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0 && shouldShowDateCell){
            return selectDateAndTimeTableVCHelper.selectDateAndTimeTableTextContents[section].count + 1
        }
        
        return selectDateAndTimeTableVCHelper.selectDateAndTimeTableTextContents[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(isDateCellShown || isTimeCellShown) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateAndTimeDatePickerTableViewCell.identifier, for: indexPath) as? DateAndTimeDatePickerTableViewCell else {
                return UITableViewCell()
            }
            
            if(isDateCellShown) {
                cell.datePickerStyle = .inline
            }
            else if(isTimeCellShown) {
                cell.datePickerStyle = .wheels
            }
            
            cell.datePicker.addTarget(self, action: #selector(didChangeDateOrTime), for: .valueChanged)
            
            datePicker = cell.datePicker
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DateAndTimeTableViewCell.identifier, for: indexPath) as? DateAndTimeTableViewCell else {
            return UITableViewCell()
        }
        
        var image = UIImage(systemName: selectDateAndTimeTableVCHelper.selectDateAndTimeTableImageContents[indexPath.section][indexPath.row])
        
        if(indexPath.section == 0){
            if(indexPath.row == 0) {
                image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
                cell.viewForDisplayImage.backgroundColor = .systemRed
                
                cell.valueLabel.text = "Today"
            }
            else{
                image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
                cell.viewForDisplayImage.backgroundColor = .systemBlue
                
                dateFormatter.dateFormat = timeFormat
                
                cell.valueLabel.text = dateFormatter.string(from: Date.now)
            }
            
            cell.headerLabel.text = selectDateAndTimeTableVCHelper.selectDateAndTimeTableTextContents[indexPath.section][indexPath.row]
        }
        else{
            cell.hideStepper = true
            image = image?.withTintColor(.white, renderingMode: .alwaysOriginal)
            cell.viewForDisplayImage.backgroundColor = .systemGray
            
            cell.centeredHeaderLabel.text = selectDateAndTimeTableVCHelper.selectDateAndTimeTableTextContents[indexPath.section][indexPath.row]
        }
        
        cell.displayImageView.image = image
        
        cell.toggleSwitch.addTarget(self, action: #selector(didTapDateOrTimeToggle), for: .valueChanged)
                
        if(indexPath.section == 1 && indexPath.row == 0) {
            valueLabels.append(cell.selectionLabel)
            cell.selectionLabel.text = selectedReminderRepeatPreference.rawValue
        }
        
        valueLabels.append(cell.valueLabel)
        toggleSwitches.append(cell.toggleSwitch)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == 0) {
            if(indexPath.row == 0) {
                if(isDateCellShown) {
                    hide(dateCell: true)
                }
                else{
                    show(dateCell: true)
                }
            }
            else if(isDateCellShown && indexPath.row == 2) {
                show(dateCell: false)
            }
            else if(indexPath.row == 1) {
                if(isTimeCellShown) {
                    hide(dateCell: false)
                }
                else{
                    show(dateCell: false)
                }
            }
        }
        else if(indexPath.section == 1) {
            let repeatReminderVC = ReminderRepeatTableVC(style: .insetGrouped, withSelectedState: selectedReminderRepeatPreference)
            
            repeatReminderVC.delegate = self
            
            navigationController?.pushViewController(repeatReminderVC, animated: true)
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

extension SelectDateAndTimeTableVC: ReminderRepeatSelectionCommunicationProtocol {
    func updateSelectedRepeatPreference(for selectedState: ReminderRepeatPreference) {
        selectedReminderRepeatPreference = selectedState
        
        valueLabels[2].text = selectedState.rawValue
    }
}
