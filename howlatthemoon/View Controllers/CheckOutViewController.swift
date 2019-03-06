//
//  CheckOutViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 3/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class CheckOutViewController: HowlAtTheMoonViewController {

    let logoInvisibleButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        with(logoInvisibleButton) {
            $0.addAction(for: .touchUpInside) {
                let cartviewcontroller = CartViewController()
                
                self.fadeAwayAndDismiss()
                    .done {
                        backgroundViewController.present(cartviewcontroller, animated: false)
                }
            }
            
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(2 * CGFloat.standardiOSSpacing)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(150)
                
                $0.width.equalTo(264)
                $0.height.equalTo(130)
            }
        }
    }

}
