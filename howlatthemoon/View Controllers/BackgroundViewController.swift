//
//  BackgroundViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 2/25/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import SnapKit

class BackgroundViewController: UIViewController {
    let backgroundImageView = UIImageView(image: UIImage(named: "partypic2"))
    let logoImageView = UIImageView(image: UIImage(named: "logo"))
    
    let logoTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(logoTapped))

    let backgroundFadeView = UIView()
    let topFadeView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        with(backgroundImageView) {
            $0.contentMode = .scaleAspectFill // don't stretch image
            $0.clipsToBounds = true // crop image to imageview

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)

                $0.bottom.equalTo(view) // make image go all the way to the bottom
            }
        }

        with(backgroundFadeView) {
            $0.backgroundColor = UIColor(white: 0.0, alpha: 0.4)

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.edges.equalTo(backgroundImageView)
            }
        }

        with(logoImageView) {
            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(backgroundImageView).offset(2 * CGFloat.standardiOSSpacing)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(150)

                $0.width.equalTo(264)
                $0.height.equalTo(130)
            }
            
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(logoTapGestureRecognizer)
        }

        with(topFadeView) {
            $0.backgroundColor = UIColor(white: 0.0, alpha: 0.4)

            $0.usesAutoLayout = true
            view.insertSubview($0, belowSubview: logoImageView)

            $0.snp.makeConstraints {
                $0.top.equalTo(logoImageView).offset(-2 * CGFloat.standardiOSSpacing)
                $0.bottom.equalTo(logoImageView).offset(2 * CGFloat.standardiOSSpacing)
                $0.leading.trailing.equalTo(backgroundImageView)
            }
        }
    }

    @objc func logoTapped() {
        let shopViewController = ShopViewController()
        
        (presentedViewController as? HowlAtTheMoonViewController)?.fadeAwayAndDismiss()
        .done {
            backgroundViewController.present(shopViewController, animated: false)
        }
    }
}
