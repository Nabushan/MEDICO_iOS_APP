//
//  CancelledAppointmentsListTableViewCell.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 28/10/22.
//

import UIKit

class CancelledAppointmentsListTableViewCell: UITableViewCell, AppointmentTableViewCellProtocol {

    static let identifier = "CancelledAppointmentsListTableViewCell"

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
        }
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
        
        self.accessoryType = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        NSLayoutConstraint.deactivate(previousConstraintsToDeActivate)
        previousConstraintsToDeActivate = []
        
        loadContents()
    }
    
    func loadContents() {
        loadDoctorImageView()
        loadDoctorName()
        loadPackageType()
        loadPackageStatus()
        loadDateAndTime()
        loadViewForPackageImage()
        loadPackageImageView()
    }
    
    func loadDoctorImageView() {
        doctorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doctorImageView.centerYAnchor.constraint(equalTo: packageType.centerYAnchor),
            doctorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        ])
        
        if(UITraitCollection.current.horizontalSizeClass == .regular && UITraitCollection.current.verticalSizeClass == .regular) {
            let constraints = [
                doctorImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2),
                doctorImageView.heightAnchor.constraint(equalTo: doctorImageView.widthAnchor),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
            
        }
        else {
            var constraints: [NSLayoutConstraint] = []
            
            if(UITraitCollection.current.userInterfaceIdiom == .pad){
                if(UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) {
                    constraints = [
                        doctorImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
                        doctorImageView.heightAnchor.constraint(equalTo: doctorImageView.widthAnchor),
                    ]
                }
                else {
                    constraints = [
                        doctorImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
                        doctorImageView.heightAnchor.constraint(equalTo: doctorImageView.widthAnchor),
                    ]
                }
            }
            else {
                constraints = [
                    doctorImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.22),
                    doctorImageView.heightAnchor.constraint(equalTo: doctorImageView.widthAnchor),
                ]
            }
            
            NSLayoutConstraint.activate(constraints)
            
            for constraint in constraints {
                previousConstraintsToDeActivate.append(constraint)
            }
        }
        
        doctorImageView.layer.cornerRadius = 10
    }

    func loadDoctorName() {
        doctorName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            doctorName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            doctorName.leadingAnchor.constraint(equalTo: doctorImageView.trailingAnchor, constant: 5),
            doctorName.trailingAnchor.constraint(equalTo: viewForPackageImage.leadingAnchor, constant: -10),
        ])
    }
    
    func loadPackageType() {
        packageType.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            packageType.topAnchor.constraint(equalTo: doctorName.bottomAnchor),
            packageType.leadingAnchor.constraint(equalTo: doctorName.leadingAnchor),
        ])
    }
    
    func loadPackageStatus() {
        packageStatus.translatesAutoresizingMaskIntoConstraints = false
        
        packageStatus.layer.cornerRadius = 5
        packageStatus.layer.borderWidth = 2
        
        packageStatus.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            packageStatus.topAnchor.constraint(equalTo: packageType.topAnchor),
            packageStatus.leadingAnchor.constraint(equalTo: packageType.trailingAnchor),
            packageStatus.trailingAnchor.constraint(equalTo: doctorName.trailingAnchor),
        ])
    }
    
    func loadDateAndTime() {
        dateAndTime.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateAndTime.topAnchor.constraint(equalTo: packageType.bottomAnchor),
            dateAndTime.leadingAnchor.constraint(equalTo: packageType.leadingAnchor),
            dateAndTime.trailingAnchor.constraint(equalTo: packageStatus.trailingAnchor),
            dateAndTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func loadViewForPackageImage() {
        viewForPackageImage.translatesAutoresizingMaskIntoConstraints = false
        
        viewForPackageImage.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            viewForPackageImage.centerYAnchor.constraint(equalTo: packageStatus.centerYAnchor),
            viewForPackageImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            viewForPackageImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.12),
            viewForPackageImage.heightAnchor.constraint(equalTo: viewForPackageImage.widthAnchor)
        ])
        
        viewForPackageImage.layer.cornerRadius = (0.12*contentView.frame.width)/2
    }
    
    func loadPackageImageView() {
        packageImageView.translatesAutoresizingMaskIntoConstraints = false
        
        packageImageView.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
        
        NSLayoutConstraint.activate([
            packageImageView.centerYAnchor.constraint(equalTo: viewForPackageImage.centerYAnchor),
            packageImageView.centerXAnchor.constraint(equalTo: viewForPackageImage.centerXAnchor),
            packageImageView.heightAnchor.constraint(equalTo: viewForPackageImage.heightAnchor),
            packageImageView.widthAnchor.constraint(equalTo: viewForPackageImage.widthAnchor)
        ])
    }
    
}
