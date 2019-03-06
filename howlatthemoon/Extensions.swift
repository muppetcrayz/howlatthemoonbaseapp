//
//  Extensions.swift
//  howlatthemoon
//
//  Created by Dan Turner on 3/3/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

extension UIView {
    var usesAutoLayout: Bool {
        get {
            return translatesAutoresizingMaskIntoConstraints
        }
        set {
            translatesAutoresizingMaskIntoConstraints = !newValue
        }
    }
}

@discardableResult
func with<T>(_ object: T, closure: (T) -> Void) -> T {
    closure(object)
    return object
}

@objc final class ClosureSleeve: NSObject {
    let closure: ()->()

    init (_ closure: @escaping ()->()) {
        self.closure = closure
        super.init()
    }

    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, action: @escaping () -> Void) {
        let sleeve = ClosureSleeve(action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue
], documentAttributes: nil).string

        return decoded ?? self
    }
}

extension UIImage {
    
    func aspectFitImage(inRect rect: CGRect) -> UIImage? {
        let width = self.size.width
        let height = self.size.height
        let scaleFactor = width > height ? rect.size.height / height : rect.size.width / width

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width * scaleFactor, height: height * scaleFactor), false, 0.0)
        self.draw(in: CGRect(x: 0.0, y: 0.0, width: width * scaleFactor, height: height * scaleFactor))

        defer {
            UIGraphicsEndImageContext()
        }

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
