//
//  Theme.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 23/09/22.
//

import Foundation
import UIKit

enum Theme: Int {
    case lightMode
    case darkMode
    
    var mainViewBackGroundColor: UIColor {
        return .systemBackground
    }
    
    var subViewBackGroundColor: UIColor {
        return .secondarySystemBackground
    }
}
