//
//  Extensions.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 04/10/22.
//

import Foundation
import UIKit

extension UserDefaults{
    func setImage(_ image: UIImage?, forKey: String){
        let imageData: NSData?
        if let image = image {
            do{
                imageData = try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: false) as NSData?
                
                set(imageData, forKey: forKey)
            }
            catch let err{
                print("Error Caught :- \(err)")
            }
        }
    }
    
    func image(forKey: String) -> UIImage?{
        var image: UIImage?
        
        if let imageData = data(forKey: forKey){
            do{
                try image = NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: imageData) ?? UIImage(named: "Log In")
            }
            catch let err{
                print("Error caught :- \(err)")
            }
        }
        return image
    }
}

extension UITextView {

    func centerText() {
        self.textAlignment = .center
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2 + 3
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, shouldRender: Bool, withColor: UIColor) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image.withTintColor(withColor)
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill, shouldRender: Bool, withColor: UIColor) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode, shouldRender: shouldRender, withColor: withColor)
    }
}


extension UILabel {

    var isTruncated: Bool {

        guard let labelText = text else {
            return false
        }

        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size

        return labelTextSize.height > bounds.size.height
    }
    
    func textHeight(withWidth width: CGFloat, withFontOfSize: CGFloat) -> CGFloat {
        guard let text = text else {
            return 0
        }
        
        return text.height(withWidth: UIScreen.main.bounds.width, font: UIFont.systemFont(ofSize: withFontOfSize))
    }
    
    func countLines() -> Int {
        guard let myText = self.text as NSString? else {
          return 0
        }
        
        self.layoutIfNeeded()
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
}

extension String {
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && (res.range.length >= 8 && res.range.length <= 15)
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

extension UINavigationController {
    
    func customiseNavBarAppearance() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        
        coloredAppearance.backgroundColor = .systemBackground
        
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
               
        self.navigationBar.standardAppearance = coloredAppearance
        self.navigationBar.scrollEdgeAppearance = coloredAppearance
    }
}

extension Date {

  func isEqualTo(_ date: Date) -> Bool {
    return self == date
  }
  
  func isGreaterThan(_ date: Date) -> Bool {
     return self > date
  }
  
  func isSmallerThan(_ date: Date) -> Bool {
     return self < date
  }
}
