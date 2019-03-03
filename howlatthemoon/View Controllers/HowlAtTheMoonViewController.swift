//
//  HowlAtTheMoonViewController.swift
//  howlatthemoon
//
//  Created by Dan Turner on 3/3/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import PromiseKit

class HowlAtTheMoonViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .clear
        view.alpha = 0.0

        modalPresentationStyle = .overCurrentContext
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        after(.milliseconds(500))
        .done { [weak self] in
            UIView.animate(.promise, duration: .standardiOSAnimationDuration) {
                self?.view.alpha = 1.0
            }
        }
    }

    func fadeAwayAndDismiss() -> Guarantee<Void> {
        return UIView.animate(.promise, duration: .standardiOSAnimationDuration) { [weak self] in
            self?.view.alpha = 0.0
        }
        .then { _ in
            Guarantee { seal in
                self.dismiss(animated: false) {
                    seal(())
                }
            }
        }
    }
}
