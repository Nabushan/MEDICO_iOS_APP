//
//  DateAndTimeDatePickerTableViewCell.swift
//  Medico
//
//  Created by nabushan-pt5611 on 05/02/23.
//

import UIKit

class DateAndTimeDatePickerTableViewCell: UITableViewCell {

    static let identifier = "DateAndTimeDatePickerTableViewCell"
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.minimumDate = Date.now
        datePicker.locale = Locale(identifier: "en_GB")
        
        return datePicker
    }()
    
    var datePickerStyle: UIDatePickerStyle? {
        didSet {
            guard let datePickerStyle = datePickerStyle else {
                return
            }
            
            if(datePickerStyle == .wheels) {
                datePicker.datePickerMode = .time
                datePicker.preferredDatePickerStyle = datePickerStyle
            }
            else{
                datePicker.datePickerMode = .date
                datePicker.preferredDatePickerStyle = .inline
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(datePicker)
        
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
        loadDatePicker()
    }
    
    func loadDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
}
