//
//  CartViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 3/5/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import SwiftRichString
import SquareInAppPaymentsSDK
import SwiftyJSON

var total = 0.0

class CartViewController: HowlAtTheMoonViewController, SQIPCardEntryViewControllerDelegate {
    let cellId = "cellId"

    let logoInvisibleButton = UIButton(type: .custom)
    let yourPlaylistButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let checkoutButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let tableView = UITableView()
    let totalView = UIView()
    let proceedToCheckoutButton = HowlAtTheMoonButton(text: "Proceed to Checkout →", size: 16)
    let backButton = HowlAtTheMoonButton(text: "Continue Browsing", size: 16)
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in playlist {
            let x = removeDuplicates()
            if (x != -1) {
                playlist.remove(at: x)
            }
        }
        
        calculateTotal()

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
            $0.dataSource = self
            $0.delegate = self
            $0.register(CartItemTableViewCell.self, forCellReuseIdentifier: cellId)

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
                self.showCardEntryForm()
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
    
    func cardEntryViewController(_ cardEntryViewController: SQIPCardEntryViewController, didObtain cardDetails: SQIPCardDetails, completionHandler: @escaping (Error?) -> Void) {
        
        let headers = [
            "Authorization": "Bearer EAAAEPh1McFlzNZR3m7Ev7SW36wElAiQEJSM63GGpw2peMK0Q2lwe2JygFGSVfHU",
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
        let parameters = [
            "idempotency_key": UUID().uuidString,
            "amount_money": [
                "amount": total,
                "currency": "USD"
            ],
            "card_nonce": cardDetails.nonce,
            "delay_capture": false
            ] as [String : Any]
        
            do {
                let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                let request = NSMutableURLRequest(url: NSURL(string: API.Transactions.baseURL)! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                request.httpBody = postData as Data
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    guard let unwrappedData = data else { print("Error unwrapping data"); return }
                    
                    do {
                        let json = try JSON(data: unwrappedData)
                        print(json)
                        if (json["transaction"] != .none) {
                            self.sendToWooCommerce()
                            playlist = []
                            completionHandler(nil)
                        }
                    } catch {
                        
                    }
                })
                
                dataTask.resume()
            } catch {
                
            }
        
    }
    
    func cardEntryViewController(_ cardEntryViewController: SQIPCardEntryViewController, didCompleteWith status: SQIPCardEntryCompletionStatus) {
        dismiss(animated: true) {
            let shopViewcontroller = ShopViewController()
            
            
                self.fadeAwayAndDismiss()
                    .done {
                        backgroundViewController.present(shopViewcontroller, animated: false)
                }
        }
    }
    
    func showCardEntryForm() {
        let theme = SQIPTheme()
        
        // Customize the card payment form
        theme.tintColor = .green
        theme.saveButtonTitle = "Submit"
        
        let cardEntryForm = SQIPCardEntryViewController(theme: theme)
        cardEntryForm.delegate = self
        
        // The card entry form should always be displayed in a UINavigationController.
        // The card entry form can also be pushed onto an existing navigation controller.
        let navigationController = UINavigationController(rootViewController: cardEntryForm)
        present(navigationController, animated: true, completion: nil)
    }
    
    func removeDuplicates() -> Int {
        for i in (0..<playlist.count) {
            for x in (i+1..<playlist.count) {
                if playlist[i].0.id == playlist[x].0.id {
                    playlist[i].1 += playlist[x].1
                    return x
                }
            }
        }
        return -1
    }
    
    func calculateTotal() -> Void {
        total = 0.0
        for song in playlist {
            total += Double(song.1 * 5)
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
            line_item = ["product_id": item.0.id, "quantity": item.1]
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
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CartItemTableViewCell

        let song = playlist[indexPath.row].0
        cell.albumArtImage = song.getSongPicture()
        cell.productName = song.name
        cell.price = 5
        cell.quantity = playlist[indexPath.row].1
        cell.total = playlist[indexPath.row].1 * 5
        cell.deleteTapHandler = {
            playlist.remove(at: indexPath.row)
            tableView.reloadData()
            self.calculateTotal()
        }
        cell.didChangeStepperHandler = {
            playlist[indexPath.row].1 = Int(cell.quantityStepper.value)
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
