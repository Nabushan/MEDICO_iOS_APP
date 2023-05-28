//
//  ResizedComponents.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 21/09/22.
//

import Foundation
import UIKit

class ResizedLabel: UILabel {
    override var intrinsicContentSize: CGSize{
        let oldSize = super.intrinsicContentSize
        return CGSize(width: oldSize.width + 10, height: oldSize.height + 10)
    }
}

class ResizedLabelWithExtraWidth: UILabel{
    override var intrinsicContentSize: CGSize{
        let oldSize = super.intrinsicContentSize
        return CGSize(width: oldSize.width + 15, height: oldSize.height + 10)
    }
}

class ResizedButton: UIButton {
    override var intrinsicContentSize: CGSize{
        let oldSize = super.intrinsicContentSize
        return CGSize(width: oldSize.width + 10, height: oldSize.height + 10)
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard inputView != nil else { return super.canPerformAction(action, withSender: sender) }
        return action == #selector(UIResponderStandardEditActions.paste(_:))  ?
                false : super.canPerformAction(action, withSender: sender)
    }
}

class Line {
    func getLine() -> UIView {
        let line: UIView = {
            let line = UIView()
            
            line.backgroundColor = .systemGray
            
            return line
        }()
        
        return line
    }
}


class ImageViewFromUrl : UIImageView {
    var urlString : String?
    
    func download(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        urlString = url.absoluteString
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                if self?.urlString == url.absoluteString {
                    self?.image = image
                }
                
            }
        }.resume()
    }
    
    func download(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
    
    func download(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, shouldRender: Bool, withColor: UIColor) {
        contentMode = mode
        urlString = url.absoluteString
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                if self?.urlString == url.absoluteString {
                    self?.image = image.withTintColor(withColor)
                }
                
            }
        }.resume()
    }
    
    func download(from link: String, contentMode mode: ContentMode = .scaleToFill, shouldRender: Bool, withColor: UIColor) {
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode, shouldRender: shouldRender, withColor: withColor)
    }
    
}
