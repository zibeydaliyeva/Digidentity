//
//  Extensions.swift
//  Digidentity
//
//  Created by Зибейда Алекперли on 19.11.21.
//

import UIKit

extension UINavigationBar {
    
    func customNavigationBar() {
        self.tintColor = .mainTextColor
        self.barTintColor = .white
        self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainTextColor]
        self.shadowImage = UIImage()
    }
    
}

extension UIBarButtonItem {
    
    func hideBackTitle() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        self.setTitleTextAttributes(attributes, for: .normal)
        self.setTitleTextAttributes(attributes, for: .highlighted)
    }
    
}

extension UILabel {
    
    convenience init(fontWeight: UIFont.Weight = .regular,
                     fontSize: CGFloat,
                     color: UIColor? = .black,
                     numLines: Int = 1,
                     alignment: NSTextAlignment = .left) {
        self.init()
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = color
        self.numberOfLines = numLines
        self.textAlignment = alignment
    }
    
}

extension UIViewController {

    func errorAlert(with errorMessage: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error!",
                                                message: errorMessage,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Close", style: .cancel) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

    func trackError(with message: String) {
        // we can print or save to file all logs
        print(message)
    }
    

}

extension UIEdgeInsets {
    
    init(horizontalInset: CGFloat, verticalInset: CGFloat) {
        self.init(top: verticalInset, left: horizontalInset,
                  bottom: verticalInset, right: horizontalInset)
    }
    
    init(inset: CGFloat) {
        self.init(horizontalInset: inset, verticalInset: inset)
    }
    
    init(horizontal inset: CGFloat) {
        self.init(horizontalInset: inset, verticalInset: 0)
    }
    
    init(vertical inset: CGFloat) {
        self.init(horizontalInset: 0, verticalInset: inset)
    }
    
}

extension UICollectionView {
    
    func registerCell(_ cellClass: AnyClass?, identifier: String) {
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
}

extension Encodable {
    var dictionary: [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return (try? JSONSerialization.jsonObject(with: encoder.encode(self))) as? [String: Any] ?? [:]
    }
    

    func convertToString() -> String {
        var urlParameters = ""
        var count = 0
        for (key, value) in self.dictionary {
            let keyValueStr = "\(key)=\(value)"
            urlParameters += count == 0 ? "?" : "&"
            urlParameters += keyValueStr
            count += 1
        }
        return urlParameters
    }
    
}
