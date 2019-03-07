//
//  CartHeaderView.swift
//  howlatthemoon
//
//  Created by Dan Turner on 3/6/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class CartHeaderView: UITableViewHeaderFooterView {
    let productLabel = UILabel()
    let priceLabel = UILabel()
    let quantityLabel = UILabel()
    let totalLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        with(productLabel) {
            $0.text = "Name"
            
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(260)
                $0.width.equalToSuperview().multipliedBy(0.25)
            }
            
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        
        with(priceLabel) {
            $0.text = "Price"
            
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(productLabel.snp.trailing).offset(CGFloat.standardiOSSpacing * 4)
                $0.width.equalToSuperview().multipliedBy(0.1)
            }
            
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        
        with(quantityLabel) {
            $0.text = "Quantity"
            
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(priceLabel.snp.trailing).offset(CGFloat.standardiOSSpacing * 2)
            }
            
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
        
        with(totalLabel) {
            $0.text = "Total"
            
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(quantityLabel.snp.trailing).offset(CGFloat.standardiOSSpacing * 2)
                $0.trailing.equalToSuperview().offset(-CGFloat.standardiOSSpacing)
            }
            
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
