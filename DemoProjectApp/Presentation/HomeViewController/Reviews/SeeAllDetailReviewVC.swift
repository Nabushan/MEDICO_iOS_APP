//
//  SeeAllDetailReviewVC.swift
//  Medico
//
//  Created by nabushan-pt5611 on 16/01/23.
//

import UIKit

class SeeAllDetailReviewVC: UIViewController {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.register(PharmacyReviewCollectionViewCell.self, forCellWithReuseIdentifier: PharmacyReviewCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    let review: Reviews
    
    init(review: Reviews) {
        self.review = review
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Theme.lightMode.mainViewBackGroundColor
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadCollectionView()
    }
    
    func loadCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SeeAllDetailReviewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PharmacyReviewCollectionViewCell.identifier, for: indexPath) as? PharmacyReviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.review = review
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = PharmacyReviewCollectionViewCell()

        cell.reviewLabel.text = review.body
        
        cell.reviewLabel.text = cell.reviewLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        let reviewHeight = cell.reviewLabel.textHeight(withWidth: view.frame.width - 60, withFontOfSize: cell.reviewLabel.font.pointSize)
        
        let height = review.body.height(withWidth: view.frame.width - 60, font: cell.reviewLabel.font)

        print(height)
        
        return CGSize(width: view.frame.width - 30, height: 70 + reviewHeight + height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
}

extension SeeAllDetailReviewVC {
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.title = "Ratings & Reviews"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
}
