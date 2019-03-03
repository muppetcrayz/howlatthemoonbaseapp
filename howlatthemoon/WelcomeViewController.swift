//
//  WelcomeViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 2/24/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

@IBDesignable
class WelcomeViewController: HowlAtTheMoonViewController {
    let welcomeImageView = UIImageView(image: UIImage(named: "welcome"))

    let beginButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        with(welcomeImageView) {
            $0.contentMode = .scaleAspectFit

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(CGFloat.standardiOSSpacing * 8)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-CGFloat.standardiOSSpacing * 8)
                $0.centerX.equalTo(view.safeAreaLayoutGuide)
                $0.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.75)
            }
        }

        with(beginButton) {
            $0.titleLabel?.font = UIFont(name: "Oswald-Bold", size: 32)

            $0.setTitle("Begin Your Playlist".uppercased(), for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.6, alpha: 1.0) // aqua background for button
            $0.contentEdgeInsets = UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 32) // set margins around text in button

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(1.15)
                $0.centerX.equalTo(view.safeAreaLayoutGuide)
            }

            $0.addAction(for: .touchUpInside) { [weak self] in
                let shopViewController = ShopViewController()
                
                self?.fadeAwayAndDismiss()
                .done {
                    backgroundViewController.present(shopViewController, animated: false)
                }
            }
        }
    }
}
