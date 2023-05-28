//
//  AppointmentsListTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/10/22.
//

import UIKit

class CompletedAndUpcomingAppointmentsListTableViewCell: UITableViewCell, AppointmentTableViewCellProtocol {
    
    static let identifier = "CompletedAndUpcomingAppointmentsListTableViewCell"
    
    lazy var doctorImageView: ImageLoader = {
        let imageView = ImageLoader()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var doctorName: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 15, weight: .medium)
        
        return label
    }()
    
    lazy var packageType: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 1
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        
        return label
    }()
    
    lazy var packageStatus: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .center
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.alpha = 0
        
        return label
    }()
    
    lazy var dateAndTime: ResizedLabel = {
        let label = ResizedLabel()
        
        label.textColor = .label
        label.numberOfLines = 2
        label.contentMode = .left
        label.textAlignment = .left
        label.clipsToBounds = true
        label.layer.masksToBounds = true
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        
        return label
    }()
    
    lazy var viewForPackageImage: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var packageImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var leftButton: ResizedButton = {
        let button = ResizedButton()
        
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .light)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        
        return button
    }()
    
    lazy var rightButton: ResizedButton = {
        let button = ResizedButton()
        
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .light)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    weak var delegate: AppointmentFunctionTableViewCellProtocol?
    var previousConstraintsToDeActivate: [NSLayoutConstraint] = []
    
    var consultation: ConsultationGetter? {
        didSet{
            guard let consultation = consultation else {
                return
            }
            
            packageType.text = "\(consultation.packageInfomation?.consultationType ?? "") "
            packageStatus.text = "\(consultation.status?.consultationName ?? "") "
            
            switch(consultation.status){
            case .upcoming:
                packageStatus.layer.borderColor = UIColor.systemBlue.cgColor
                packageStatus.textColor = .systemBlue
            case .completed:
                packageStatus.layer.borderColor = UIColor.systemGreen.cgColor
                packageStatus.textColor = .systemGreen
            case .cancelled:
                packageStatus.layer.borderColor = UIColor.systemRed.cgColor
                packageStatus.textColor = .systemRed
            default:
                ()
            }
            
            dateAndTime.text = "\(consultation.consultationDate ?? "") | \(consultation.consultationTime ?? "")"
            
            if(consultation.packageInfomation == .videoConsultation){
                packageImageView.image = UIImage(systemName: "video.bubble.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
            
            }
            else{
                packageImageView.image = UIImage(named: "hospital")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
            
            }
            
            if(consultation.status == .upcoming) {
                leftButton.setTitle("Cancel Appointment", for: .normal)
                rightButton.setTitle("Reschedule", for: .normal)
            }
            else if(consultation.status == .completed) {
                leftButton.setTitle("Book Again", for: .normal)
                rightButton.setTitle("Leave a Review", for: .normal)
            }
            
            switch(consultation.status){
            case .completed:
                leftButton.addTarget(self, action: #selector(bookAppointment), for: .touchUpInside)
            case .upcoming:
                leftButton.addTarget(self, action: #selector(cancelAppointment), for: .touchUpInside)
            default:
                ()
            }
            
            switch(consultation.status){
            case .completed:
                rightButton.addTarget(self, action: #selector(leaveAReview), for: .touchUpInside)
            case .upcoming:
                rightButton.addTarget(self, action: #selector(rescheduleAppointment), for: .touchUpInside)
            default:
                ()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        doctorImageView.image = nil
        
        switch(consultation?.status){
        case .completed:
            rightButton.removeTarget(self, action: #selector(leaveAReview), for: .touchUpInside)
            leftButton.removeTarget(self, action: #selector(bookAppointment), for: .touchUpInside)
        case .upcoming:
            rightButton.removeTarget(self, action: #selector(rescheduleAppointment), for: .touchUpInside)
            leftButton.removeTarget(self, action: #selector(cancelAppointment), for: .touchUpInside)
        default:
            ()
        }
        
        self.accessoryType = .none
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(doctorImageView)
        contentView.addSubview(doctorName)
        contentView.addSubview(packageType)
        contentView.addSubview(packageStatus)
        contentView.addSubview(dateAndTime)
        contentView.addSubview(viewForPackageImage)
        viewForPackageImage.addSubview(packageImageView)
        contentView.addSubview(lineView)
        contentView.addSubview(leftButton)
        contentView.addSubview(rightButton)
        
        loadContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadContents() {
        loadDoctorImageView()
        loadDoctorName()
        loadPackageType()
        loadPackageStatus()
        loadDateAndTime()
        loadViewForPackageImage()
        loadPackageImageView()
        loadLineView()
        loadLeftButton()
        loadRightButton()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)

        previousConstraintsToDeActivate = []
        loadContents()
    }
    
    func loadDoctorImageView() {
        doctorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                doctorImageView.centerYAnchor.constraint(equalTo: packageType.centerYAnchor),
                doctorImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
                doctorImageView.heightAnchor.constraint(equalTo: doctorImageView.widthAnchor),
                doctorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        else {
            if(UITraitCollection.current.userInterfaceIdiom == .pad) {
                let constraints = [
                    doctorImageView.centerYAnchor.constraint(equalTo: packageType.centerYAnchor),
                    doctorImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
                    doctorImageView.heightAnchor.constraint(equalTo: doctorImageView.widthAnchor),
                    doctorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previousConstraintsToDeActivate.append(constraint)
                }
            }
            else{
                let constraints = [
                    doctorImageView.centerYAnchor.constraint(equalTo: packageType.centerYAnchor),
                    doctorImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.22),
                    doctorImageView.heightAnchor.constraint(equalTo: doctorImageView.widthAnchor),
                    doctorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                ]
                
                NSLayoutConstraint.activate(constraints)
                
                for constraint in constraints {
                    previousConstraintsToDeActivate.append(constraint)
                }
            }
        }
        
        doctorImageView.layer.cornerRadius = 10
    }

    func loadDoctorName() {
        doctorName.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            doctorName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            doctorName.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: 5),
            doctorName.trailingAnchor.constraint(equalTo: viewForPackageImage.leadingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPackageType() {
        packageType.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            packageType.topAnchor.constraint(equalTo: doctorName.bottomAnchor),
            packageType.leadingAnchor.constraint(equalTo: doctorName.leadingAnchor),
        ]
        
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadPackageStatus() {
        packageStatus.translatesAutoresizingMaskIntoConstraints = false
        
        packageStatus.layer.cornerRadius = 5
        packageStatus.layer.borderWidth = 2
        
        packageStatus.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        packageStatus.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        let constraints = [
            packageStatus.topAnchor.constraint(equalTo: packageType.topAnchor),
            packageStatus.leadingAnchor.constraint(equalTo: packageType.trailingAnchor),
            packageStatus.trailingAnchor.constraint(equalTo: doctorName.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadDateAndTime() {
        dateAndTime.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            dateAndTime.topAnchor.constraint(equalTo: packageType.bottomAnchor),
            dateAndTime.leadingAnchor.constraint(equalTo: packageType.leadingAnchor),
            dateAndTime.trailingAnchor.constraint(equalTo: packageStatus.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadViewForPackageImage() {
        viewForPackageImage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForPackageImage.backgroundColor = .systemBackground
        
        let constraints = [
            viewForPackageImage.centerYAnchor.constraint(equalTo: packageStatus.centerYAnchor),
            viewForPackageImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            viewForPackageImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12),
            viewForPackageImage.heightAnchor.constraint(equalTo: viewForPackageImage.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        viewForPackageImage.layer.cornerRadius = (0.12*contentView.frame.width)/2
    }
    
    func loadPackageImageView() {
        packageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        packageImageView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        
        let constraints = [
            packageImageView.centerYAnchor.constraint(equalTo: viewForPackageImage.centerYAnchor),
            packageImageView.centerXAnchor.constraint(equalTo: viewForPackageImage.centerXAnchor),
            packageImageView.heightAnchor.constraint(equalTo: viewForPackageImage.heightAnchor),
            packageImageView.widthAnchor.constraint(equalTo: viewForPackageImage.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
    }
    
    func loadLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        lineView.backgroundColor = .systemGray5
        
        let constraints = [
            lineView.topAnchor.constraint(equalTo: dateAndTime.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: doctorImageView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: viewForPackageImage.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),
        ]
                                    
        NSLayoutConstraint.activate(constraints)
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        lineView.layer.cornerRadius = 1
    }
    
    func loadLeftButton() {
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        leftButton.layer.borderWidth = 2
        leftButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        let constraints = [
            leftButton.topAnchor.constraint(equalTo: lineView.bottomAnchor,constant: 10),
            leftButton.leadingAnchor.constraint(equalTo: lineView.leadingAnchor),
            leftButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.45),
            leftButton.heightAnchor.constraint(equalToConstant: leftButton.intrinsicContentSize.height - 10),
            leftButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        
        leftButton.layer.cornerRadius = (leftButton.intrinsicContentSize.height - 10) / 2
        
        NSLayoutConstraint.activate(constraints)
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        switch(consultation?.status){
        case .completed:
            leftButton.addTarget(self, action: #selector(bookAppointment), for: .touchUpInside)
        case .upcoming:
            leftButton.addTarget(self, action: #selector(cancelAppointment), for: .touchUpInside)
        default:
            ()
        }
    }
    
    func loadRightButton() {
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            rightButton.topAnchor.constraint(equalTo: leftButton.topAnchor),
            rightButton.trailingAnchor.constraint(equalTo: lineView.trailingAnchor),
            rightButton.widthAnchor.constraint(equalTo: leftButton.widthAnchor),
            rightButton.heightAnchor.constraint(equalToConstant: rightButton.intrinsicContentSize.height - 10)
        ]
        
        NSLayoutConstraint.activate(constraints)
        for constraint in constraints {
            previousConstraintsToDeActivate.append(constraint)
        }
        
        rightButton.layer.cornerRadius = (rightButton.intrinsicContentSize.height - 10) / 2
        
        switch(consultation?.status){
        case .completed:
            rightButton.addTarget(self, action: #selector(leaveAReview), for: .touchUpInside)
        case .upcoming:
            rightButton.addTarget(self, action: #selector(rescheduleAppointment), for: .touchUpInside)
        default:
            ()
        }
    }
    
    @objc func cancelAppointment(_ sender: UIButton) {
        
        guard let consultation = consultation else {
            return
        }
        
        delegate?.cancelAppointment(consultation)
    }
            
    @objc func rescheduleAppointment(_ sender: UIButton) {
        
        guard let consultation = consultation else {
            return
        }
        
        delegate?.rescheduleAppointment(consultation)
    }
            
    @objc func bookAppointment(_ sender: UIButton) {
        
        guard let consultation = consultation else {
            return
        }
        
        delegate?.bookAppointment(consultation)
    }
            
    @objc func leaveAReview(_ sender: UIButton) {
        
        guard let consultation = consultation else {
            return
        }
        
        delegate?.leaveAReview(consultation)
    }
}
