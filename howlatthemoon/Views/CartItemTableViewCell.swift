//
//  CartItemTableViewCell.swift
//  howlatthemoon
//
//  Created by Dan Turner on 3/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class CartItemTableViewCell: UITableViewCell {
    let removeButton = UIButton(type: .custom)
    let albumArtImageView = UIImageView()
    let productLabel = UILabel()
    let priceLabel = UILabel()
    let quantityStepper = UIStepper()
    let quantityLabel = UILabel()
    let totalLabel = UILabel()

    var albumArtImage: UIImage? {
        didSet {
            albumArtImageView.image = albumArtImage
        }
    }

    var productName: String = "" {
        didSet {
            productLabel.text = productName
        }
    }

    var price: Int = 0 {
        didSet {
            priceLabel.text = "$\(price).00"
        }
    }

    var quantity: Int = 1 {
        didSet {
            quantityStepper.value = Double(quantity)
            quantityLabel.text = "\(Int(quantityStepper.value))"
        }
    }

    var total: Int = 0 {
        didSet {
            totalLabel.text = "$\(total).00"
        }
    }
    
    var deleteTapHandler: () -> Void = {}
    var didChangeStepperHandler: () -> Void = {}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        with(removeButton) {
            $0.setImage(UIImage.init(named: "remove"), for: .normal)
            $0.usesAutoLayout = true
            addSubview($0)
            $0.addAction(for: .touchUpInside) {
                self.deleteTapHandler()
            }
            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.width.equalTo(60)
                $0.leading.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.height.equalTo(60)
            }
        }
        
        with(albumArtImageView) {
            $0.image = albumArtImage

            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.width.equalTo(albumArtImageView.snp.height)
                $0.leading.equalTo(removeButton.snp.trailing).offset(40)
                $0.height.equalTo(60)
            }
        }

        with(productLabel) {
            $0.text = productName

            setUpLabelFormatting(for: $0)

            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(albumArtImageView.snp.trailing).offset(100)
                $0.width.equalToSuperview().multipliedBy(0.25)
            }

            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }

        with(priceLabel) {
            priceLabel.text = "$\(price).00"

            setUpLabelFormatting(for: $0)

            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(productLabel.snp.trailing).offset(CGFloat.standardiOSSpacing * 4)
                $0.width.equalToSuperview().multipliedBy(0.1)
            }

            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }

        with(quantityStepper) {
            $0.minimumValue = 1
            $0.stepValue = 1
            $0.value = Double(quantity)
            
            $0.addAction(for: .valueChanged) {
                self.didChangeStepperHandler()
                self.quantityLabel.text = "\(Int(self.quantityStepper.value))"
                self.totalLabel.text = "$\(Int(self.quantityStepper.value * 5)).00"
            }

            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(priceLabel.snp.trailing).offset(CGFloat.standardiOSSpacing * 2)
            }
        }

        with(quantityLabel) {
            setUpLabelFormatting(for: $0)

            $0.text = "\(Int(quantityStepper.value))"

            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(quantityStepper.snp.trailing).offset(CGFloat.standardiOSSpacing * 2)
            }

            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }

        with(totalLabel) {
            setUpLabelFormatting(for: $0)

            $0.text = "$\(total).00"

            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalToSuperview().offset(CGFloat.standardiOSSpacing)
                $0.leading.equalTo(quantityLabel.snp.trailing).offset(CGFloat.standardiOSSpacing * 2)
                $0.trailing.equalToSuperview().offset(-CGFloat.standardiOSSpacing)
            }

            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
    }

    private func setUpLabelFormatting(for label: UILabel) {
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
