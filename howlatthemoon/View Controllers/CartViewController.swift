//
//  CartViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 3/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import SwiftRichString
import SquareReaderSDK
import SwiftyJSON
import AVFoundation
import CoreLocation

var total = 0.0

class CartViewController: HowlAtTheMoonViewController, SQRDCheckoutControllerDelegate {
    let cellId = "cellId"

    let logoInvisibleButton = UIButton(type: .custom)
    let yourPlaylistButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let checkoutButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let tableView = UITableView()
    let totalView = UIView()
    let proceedToCheckoutButton = HowlAtTheMoonButton(text: "Proceed to Checkout →", size: 16)
    let backButton = HowlAtTheMoonButton(text: "Continue Browsing", size: 16)
    let label = UILabel()
    let settingsButton = HowlAtTheMoonButton(text: "Reader Settings", size: 16)
    private lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestLocationPermission()
        requestMicrophonePermission()
        
        calculateTotal()

        with(logoInvisibleButton) {
            $0.addAction(for: .touchUpInside) {
                let shopViewcontroller = ShopViewController()
                
                self.fadeAwayAndDismiss()
                .done {
                    backgroundViewController.present(shopViewcontroller, animated: false)
                }
            }

            $0.usesAutoLayout = true
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
            $0.dataSource = self
            $0.delegate = self
            $0.register(CartItemTableViewCell.self, forCellReuseIdentifier: cellId)

            $0.usesAutoLayout = true
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(200)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-200)
            }
        }
        
        with (totalView) {
            
            $0.backgroundColor = UIColor.white

            $0.usesAutoLayout = true
            view.addSubview($0)
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            
            // Create your own styles
            
            let normal = Style {
                $0.font = SystemFonts.Helvetica_Bold.font(size: 20)
            }
            
            // Create a group which contains your style, each identified by a tag.
            let myGroup = Style(style: normal)
        
            let text = "Total:\t\t\t" + formatter.string(from: total as NSNumber)!
            label.attributedText = text.set(style: myGroup)
            label.textAlignment = .center
            label.usesAutoLayout = true
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
                self.startCheckout()
            }
            
            $0.snp.makeConstraints {
                $0.bottom.equalTo(totalView).offset(75)
                $0.width.equalTo(300)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-175)
            }
        }
        
        with(settingsButton) {
            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.addAction(for: .touchUpInside) {
                let readerSettingsController = SQRDReaderSettingsController(delegate: self)
                readerSettingsController.present(from: self)
            }

            $0.snp.makeConstraints {
                $0.bottom.equalTo(totalView).offset(75)
                $0.width.equalTo(150)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(100)
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
                $0.width.equalTo(200)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(375)
            }
        }
    }
    
    func calculateTotal() -> Void {
        total = 0.0
        for song in playlist {
            total += 5
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        // Create your own styles
        
        let normal = Style {
            $0.font = SystemFonts.Helvetica_Bold.font(size: 20)
        }
        
        // Create a group which contains your style, each identified by a tag.
        let myGroup = Style(style: normal)
        
        let text = "Total:\t\t\t" + formatter.string(from: total as NSNumber)!
        label.attributedText = text.set(style: myGroup)
    }
    
    func sendToWooCommerce() {
        
        var lineitems: [JSON] = []
        
        for item in playlist {
            var line_item: JSON = []
            line_item = ["product_id": item.id, "quantity": 1]
            lineitems.append(line_item)
        }
        
        let order: JSON = [
            "payment_method": "credit_card",
            "payment_method_title": "Credit Card",
            "set_paid": true,
            "line_items": lineitems
        ]
        
        let authenticateString = API.Orders.loadURL
        
        print(authenticateString)
        
        var request = URLRequest(url: URL(string: authenticateString)!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? order.rawData()
        
        // Create and run a URLSession data task with our JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            
        }
        task.resume()
    }
    
    func requestLocationPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Show UI directing the user to the iOS Settings app")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location services have already been authorized.")
        }
    }
    
    func requestMicrophonePermission() {
        // Note: The microphone permission prompt will not be displayed
        // when running on the simulator
        AVAudioSession.sharedInstance().requestRecordPermission { authorized in
            if !authorized {
                print("Show UI directing the user to the iOS Settings app")
            }
        }
    }
    
    func startCheckout() {
        // Create an amount of money in the currency of the authorized Square account
        let amountMoney = SQRDMoney(amount: Int(total * 100))
        
        // Create parameters to customize the behavior of the checkout flow.
        let params = SQRDCheckoutParameters(amountMoney: amountMoney)
        
        // Create a checkout controller and call present to start checkout flow.
        let checkoutController = SQRDCheckoutController(
            parameters: params,
            delegate: self)
        checkoutController.present(from: self)
    }
    
    func checkoutController(
        _ checkoutController: SQRDCheckoutController,
        didFinishCheckoutWith result: SQRDCheckoutResult) {
        // result contains details about the completed checkout
        if (result.transactionID != nil) {
            sendToWooCommerce()
            playlist.removeAll()
            let welcomeViewController = WelcomeViewController()
            
            self.fadeAwayAndDismiss()
                .done {
                    backgroundViewController.present(welcomeViewController, animated: false)
            }
        }
    }
    
    func checkoutControllerDidCancel(
        _ checkoutController: SQRDCheckoutController) {
        print("Checkout cancelled.")
    }
    
    func checkoutController(
        _ checkoutController: SQRDCheckoutController, didFailWith error: Error) {
        // Checkout controller errors are always of type SQRDCheckoutControllerError
        let checkoutControllerError = error as! SQRDCheckoutControllerError
        
        switch checkoutControllerError.code {
        case .sdkNotAuthorized:
            // Checkout failed because the SDK is not authorized
            // with a Square merchant account.
            print("Reader SDK is not authorized.")
        case .usageError:
            // Checkout failed due to a usage error. Inspect the userInfo
            // dictionary for additional information.
            if let debugMessage = checkoutControllerError.userInfo[SQRDErrorDebugMessageKey],
                let debugCode = checkoutControllerError.userInfo[SQRDErrorDebugCodeKey] {
                print(debugCode, debugMessage)
            }
        }
    }
    
    // MARK: - SQRDReaderSettingsControllerDelegate
    
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CartItemTableViewCell

        let song = playlist[indexPath.row]
        cell.albumArtImage = song.getSongPicture()
        cell.productName = song.name
        cell.total = 5
        cell.deleteTapHandler = {
            playlist.remove(at: indexPath.row)
            tableView.reloadData()
            self.calculateTotal()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CartHeaderView(reuseIdentifier: "")
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}

extension CartViewController: SQRDReaderSettingsControllerDelegate {
    func readerSettingsControllerDidPresent(_ readerSettingsController: SQRDReaderSettingsController) {
        print("The Reader Settings controller did present.")
    }
    
    func readerSettingsController(_ readerSettingsController: SQRDReaderSettingsController, didFailToPresentWith error: Error) {
        /**************************************************************************************************
         * The Reader Settings controller failed due to an error.
         *
         * Errors from Square Reader SDK always have a `localizedDescription` that is appropriate for displaying to users.
         * Use the values of `userInfo[SQRDErrorDebugCodeKey]` and `userInfo[SQRDErrorDebugMessageKey]` (which are always
         * set for Reader SDK errors) for more information about the underlying issue and how to recover from it in your app.
         **************************************************************************************************/
        
        guard let readerSettingsError = error as? SQRDReaderSettingsControllerError,
            let debugCode = readerSettingsError.userInfo[SQRDErrorDebugCodeKey] as? String,
            let debugMessage = readerSettingsError.userInfo[SQRDErrorDebugMessageKey] as? String else {
                return
        }
        
        print(debugCode)
        print(debugMessage)
        fatalError(error.localizedDescription)
    }
}
