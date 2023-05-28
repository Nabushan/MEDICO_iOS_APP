//
//  ReminderListTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 27/09/22.
//

import UIKit

class ReminderListTableViewCell: UITableViewCell {

    static let identifier = "ReminderListTableViewCell"
    
    let totalView = UIView()
    
    let emptyCircleImage = UIImage(systemName: "circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    let selectedCircleImage = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
    
    lazy var selectedImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.image = emptyCircleImage
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var medImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "pills.png")
        
        return imageView
    }()
    
    lazy var medNameLabel: ResizedLabelWithExtraWidth = {
        let label = ResizedLabelWithExtraWidth()
        
        label.clipsToBounds = true
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.contentMode = .left
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var timeLabel: ResizedLabelWithExtraWidth = {
        let label = ResizedLabelWithExtraWidth()
        
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.isUserInteractionEnabled = false
        label.contentMode = .left
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var mealTypeLabel: ResizedLabelWithExtraWidth = {
        let label = ResizedLabelWithExtraWidth()
        
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .white
        label.isUserInteractionEnabled = false
        label.contentMode = .left
        label.textAlignment = .center
        
        return label
    }()
    
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    var medText: NSMutableAttributedString! {
        didSet {
            medNameLabel.attributedText = medText
        }
    }
    
    var reminder: Reminder? {
        didSet{
            guard let reminder = reminder else {
                return
            }
            
            let timeText = reminder.time
            let range = timeText.index(timeText.startIndex, offsetBy: 0)...timeText.index(timeText.startIndex, offsetBy: 4)
            timeLabel.text = String(timeText[range])
            
            medImage.image = UIImage(named: reminder.medicineType)
            
            mealTypeLabel.text = reminder.schedule.scheduleName + " " + reminder.foodIntervalToTake.intervalName
            
            if(reminder.schedule == .after){
                color = .systemBlue
                textColor = .systemGray5
            }
            else{
                color = .systemGray5
                textColor = .systemBlue
            }
        }
    }
    
    var color: UIColor = .systemGray5
    var textColor: UIColor = .systemBlue
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(totalView)
        totalView.addSubview(selectedImageView)
        totalView.addSubview(medNameLabel)
        totalView.addSubview(timeLabel)
        totalView.addSubview(mealTypeLabel)
        totalView.addSubview(medImage)
        
        loadContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        medNameLabel.textColor = .label
        timeLabel.textColor = .label
        
        color = .systemGray5
        textColor = .systemBlue
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectedImageView.image = selected ? selectedCircleImage : emptyCircleImage
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []

        loadContents()
    }
    
    func loadContents() {
        loadTotalView()
        loadSelectedImageView()
        loadMedNameLabel()
        loadTimeLabel()
        loadMealTypeLabel()
        loadMedImage()
    }
    
    func setLabelColors() {
        guard let reminder = reminder else {
            return
        }
        
        if(reminder.schedule == .after){
            color = .systemBlue
            textColor = .systemGray5
        }
        else{
            
            color = .systemGray5
            textColor = .systemBlue
        }
    }
    
    func loadTotalView() {
        totalView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            totalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            totalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            totalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            totalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadSelectedImageView() {
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            selectedImageView.heightAnchor.constraint(equalToConstant: 20),
            selectedImageView.widthAnchor.constraint(equalTo: selectedImageView.heightAnchor),
            selectedImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectedImageView.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 10)
        ])
    }
    
    func loadMedImage() {
        medImage.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular){
            let constraints = [
                medImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                medImage.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor,constant: 20),
                medImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/10),
                medImage.heightAnchor.constraint(equalTo: medImage.widthAnchor, multiplier: 1),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else{
            let constraints = [
                medImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                medImage.leadingAnchor.constraint(equalTo: selectedImageView.trailingAnchor,constant: 10),
                medImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/10),
                medImage.heightAnchor.constraint(equalTo: medImage.widthAnchor, multiplier: 1),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        
        
        
        medImage.layer.cornerRadius = 10
    }
    
    func loadMedNameLabel(){
        medNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            medNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            medNameLabel.leadingAnchor.constraint(equalTo: medImage.trailingAnchor,constant: 15),
            medNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func loadTimeLabel() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        timeLabel.backgroundColor = .systemGray5
        timeLabel.textColor = .systemGray
        timeLabel.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: medNameLabel.bottomAnchor,constant: 5),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            timeLabel.leadingAnchor.constraint(equalTo: medImage.trailingAnchor,constant: 15),
        ])
    }
    
    func loadMealTypeLabel() {
        mealTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mealTypeLabel.layer.cornerRadius = 10
        
        setLabelColors()
        
        mealTypeLabel.backgroundColor = color
        mealTypeLabel.textColor = textColor
        
        NSLayoutConstraint.activate([
            mealTypeLabel.topAnchor.constraint(equalTo: timeLabel.topAnchor),
            mealTypeLabel.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            mealTypeLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor,constant: 10)
        ])
    }
}
