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

    let beginButton = HowlAtTheMoonButton(text: "Begin Your Playlist")

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
