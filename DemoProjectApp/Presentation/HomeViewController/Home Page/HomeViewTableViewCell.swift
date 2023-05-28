//
//  HomeViewTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 22/09/22.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {

    static let identifier = "HomeViewTableViewCell"
    
    var timeLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.backgroundColor = .systemGray3
        label.textColor = .white
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
            
        return label
    }()
    
    var medicineNameLabel: ResizedLabel = {
        let label = ResizedLabel()
        
        label.backgroundColor = .systemGray3
        label.textColor = .white
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "Helvetica", size: 15)
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    var reminder: Reminder!
    var previousTime: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(medicineNameLabel)
        
        loadTimeLabel()
        loadMedicineNameLabel()
        
        if(reminder.time == previousTime){
            print(reminder.medicineName)
            timeLabel.backgroundColor = UIColor(red: 50/255, green: 130/255, blue: 255/255, alpha: 1)
            timeLabel.textColor = .white
            timeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = nil
        medicineNameLabel.text = nil
    }
    
    func loadTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let time = reminder.time
        let timeRange = time.index(time.startIndex, offsetBy: 0)...time.index(time.startIndex, offsetBy: 4)
        
        timeLabel.text = String(time[timeRange])
        
        timeLabel.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            timeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    func loadMedicineNameLabel() {
        medicineNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        medicineNameLabel.text = nil
        medicineNameLabel.text = reminder.medicineName
        medicineNameLabel.backgroundColor = .clear
        medicineNameLabel.textAlignment = .left
        medicineNameLabel.textColor = .label
        
        NSLayoutConstraint.activate([
            medicineNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            medicineNameLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor,constant: 15),
            medicineNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            medicineNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5)
        ])
    }
}
