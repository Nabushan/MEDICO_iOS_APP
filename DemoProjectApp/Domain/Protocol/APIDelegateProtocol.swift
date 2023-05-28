//
//  APIDelegateProtocol.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 25/09/22.
//

import Foundation
import UIKit

protocol APIDelegateProtocol: AnyObject {
    var medArticleData: [Article] { get set }
    var medicalArticleCollectionView: UICollectionView { get }
    
    func fetchData(forUrl: String)
}
