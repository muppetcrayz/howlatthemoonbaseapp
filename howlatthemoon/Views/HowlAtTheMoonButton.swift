//
//  HowlAtTheMoonButton.swift
//  howlatthemoon
//
//  Created by Dan Turner on 3/3/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class HowlAtTheMoonButton: UIButton {
    enum Weight: String {
        case regular = "Regular"
        case bold = "Bold"
    }

    var text: String = "" {
        didSet {
            setTitle(text.uppercased(), for: .normal)
        }
    }

    init(text: String = "", weight: Weight = .bold) {
        super.init(frame: .zero)

        titleLabel?.font = UIFont(name: "Oswald-\(weight.rawValue)", size: 32)

        setTitle(text.uppercased(), for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.6, alpha: 1.0) // aqua background for button
        contentEdgeInsets = UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32) // set margins around text in button
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

