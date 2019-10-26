//
//  ShopViewController.swift
//  howlatthemoon
//
//  Created by Dan Turner on 3/3/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import PromiseKit

var detailCategory = SongCategory()

class ShopViewController: HowlAtTheMoonViewController, UITextFieldDelegate {

    let store = DataStore.sharedInstance
    
    let cellId = "cellId"

    let yourPlaylistButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let checkoutButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let newCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        newCollectionView.usesAutoLayout = true
        newCollectionView.backgroundColor = .clear
        newCollectionView.isScrollEnabled = true
        return newCollectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        store.categories = []
        store.getCategories(url: API.Categories.listURL) {
            DispatchQueue.main.async {
//                self.spinner.startAnimating()
                self.collectionView.reloadSections(IndexSet(integer: 0))
//                self.spinner.stopAnimating()
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
                $0.trailing.equalToSuperview().offset(-50)
                $0.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.2)
            }
        }

        with(yourPlaylistButton) {
            $0.text = "Your Playlist: " + playlist.count.description

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.trailing.equalTo(checkoutButton.snp.leading).offset(-25)
                $0.centerY.equalTo(checkoutButton)
            }
        }
        
        with(collectionView) {
            view.addSubview($0)
            $0.delegate = self
            $0.dataSource = self
            $0.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: cellId)

            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(225)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(150)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-150)
                $0.bottom.equalTo(view)
            }
        }
    }
}

extension ShopViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.categories.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShopCollectionViewCell

        cell.backgroundColor = .clear

        cell.text = store.categories[indexPath.row].name
        cell.image = store.categories[indexPath.row].getCategoryPicture()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 300, height: 433)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailCategory = store.categories[indexPath.row]
        let detailViewController = DetailViewController()
        
        fadeAwayAndDismiss()
            .done {
                backgroundViewController.present(detailViewController, animated: false)
        }
    }
}

class ShopCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let button = HowlAtTheMoonButton(weight: .regular)

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var text: String? {
        didSet {
            button.text = text ?? ""
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        with(imageView) {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.orange.cgColor

            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalTo(self)
                $0.height.equalTo(300)
            }
        }

        with(button) {
            $0.usesAutoLayout = true
            addSubview($0)

            $0.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(30)
                $0.centerX.equalTo(self)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
