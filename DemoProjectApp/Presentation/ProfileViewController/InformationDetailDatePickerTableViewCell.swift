//
//  InformationDetailDatePickerTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 15/12/22.
//

import UIKit

class InformationDetailDatePickerTableViewCell: UITableViewCell {

    static let identifier = "InformationDetailDatePickerTableViewCell"
    
    let calendar = Calendar.current
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = .now
        
        var minDateComponent = DateComponents()
        minDateComponent.year = -150
        
        datePicker.minimumDate = calendar.date(byAdding: minDateComponent, to: Date.now)
        
        return datePicker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        loadInitView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func loadInitView() {
        contentView.addSubview(datePicker)
        
        loadDatePicker()
    }
    
    func loadDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
