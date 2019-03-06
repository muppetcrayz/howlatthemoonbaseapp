//
//  CartViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 3/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import SwiftRichString

class CartViewController: HowlAtTheMoonViewController {
    
    let logoInvisibleButton = UIButton(type: .custom)
    let yourPlaylistButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let checkoutButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let tableView = UITableView()
    let totalView = UIView()
    let proceedToCheckoutButton = HowlAtTheMoonButton(text: "Proceed to Checkout →", size: 16)
    let backButton = HowlAtTheMoonButton(text: "Continue Browsing", size: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        with(logoInvisibleButton) {
            $0.addAction(for: .touchUpInside) {
                let shopViewcontroller = ShopViewController()
                
                self.fadeAwayAndDismiss()
                .done {
                    backgroundViewController.present(shopViewcontroller, animated: false)
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
        
        with(checkoutButton) {
            $0.text = "Checkout & Complete Playlist"
            
            $0.usesAutoLayout = true
            view.addSubview($0)
            
            $0.addAction(for: .touchUpInside) {
                let cartViewController = CartViewController()
                
                self.fadeAwayAndDismiss()
                    .done {
                        backgroundViewController.present(cartViewController, animated: false)
                }
            }
            
            $0.snp.makeConstraints {
                $0.trailing.equalTo(-50)
                $0.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.2)
            }
        }
        
        with(yourPlaylistButton) {
            $0.text = "Your Playlist: " + playlist.count.description
            
            $0.usesAutoLayout = true
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.trailing.equalTo(checkoutButton.snp.leading).offset(-75)
                $0.centerY.equalTo(checkoutButton)
            }
        }
        
        with(tableView) {
            
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(175)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-175)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-200)
            }
        }
        
        with (totalView) {
            
            $0.backgroundColor = UIColor.white
            
            view.addSubview($0)
            
            let label = UILabel()
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            // Create your own styles
            
            let normal = Style {
                $0.font = SystemFonts.Helvetica_Bold.font(size: 20)
            }
            
            // Create a group which contains your style, each identified by a tag.
            let myGroup = Style(style: normal)
            
            let total = playlist.count * 5
            let text = "Total:\t\t\t" + formatter.string(from: total as NSNumber)!
            label.attributedText = text.set(style: myGroup)
            label.textAlignment = .center
            totalView.addSubview(label)
            
            label.snp.makeConstraints {
                $0.edges.equalTo(totalView)
            }
            
            $0.snp.makeConstraints {
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-175)
                $0.bottom.equalTo(tableView).offset(100)
                $0.width.equalTo(300)
                $0.height.equalTo(50)
            }
            
        }
        
        with(proceedToCheckoutButton) {
            
            $0.usesAutoLayout = true
            view.addSubview($0)
            
            $0.addAction(for: .touchUpInside) {
                let checkoutViewController = CheckOutViewController()
                
                self.fadeAwayAndDismiss()
                    .done {
                        backgroundViewController.present(checkoutViewController, animated: false)
                }
            }
            
            $0.snp.makeConstraints {
                $0.bottom.equalTo(totalView).offset(75)
                $0.width.equalTo(300)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-175)
            }
        }
        
        with(backButton) {
            $0.usesAutoLayout = true
            view.addSubview($0)
            
            $0.addAction(for: .touchUpInside) {
                let shopViewcontroller = ShopViewController()
                
                self.fadeAwayAndDismiss()
                    .done {
                        backgroundViewController.present(shopViewcontroller, animated: false)
                }
            }
            
            $0.snp.makeConstraints {
                $0.bottom.equalTo(totalView).offset(75)
                $0.width.equalTo(300)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(175)
            }
        }
    }
}
