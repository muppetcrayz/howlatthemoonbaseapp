//
//  CartHeaderView.swift
//  howlatthemoon
//
//  Created by Dan Turner on 3/6/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class CartHeaderView: UITableViewHeaderFooterView {
    let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        with(titleLabel) {
            $0.textColor = .black
            $0.font = UIFont.boldSystemFont(ofSize: 24)

            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.trailing.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.width.equalToSuperview().multipliedBy(0.4)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
