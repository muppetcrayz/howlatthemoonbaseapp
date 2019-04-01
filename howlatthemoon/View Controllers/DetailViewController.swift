//
//  DetailViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 3/3/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import SwiftRichString

class DetailViewController: HowlAtTheMoonViewController {
    
    let yourPlaylistButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let checkoutButton = HowlAtTheMoonButton(text: "Your Playlist", size: 16)
    let searchButton = HowlAtTheMoonButton(text: "Search", size: 16)

    let collectionView: UICollectionView = {
        let alignedFlowLayout = UICollectionViewFlowLayout()
        alignedFlowLayout.scrollDirection = .horizontal
        let newCollectionView = UICollectionView(frame: .zero, collectionViewLayout: alignedFlowLayout)
        newCollectionView.usesAutoLayout = true
        newCollectionView.backgroundColor = .clear
        newCollectionView.isScrollEnabled = true
        return newCollectionView
    }()

    let image = UIImage(named: "exampleDetailImage")!

    let previousButton = UIButton(type: .custom)
    let nextButton = UIButton(type: .custom)
    
    let cellId = "ImageCell"
    
    let store = DataStore.sharedInstance
    
    let logoInvisibleButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.songs = []
        store.getSongs(url: API.Songs.songURL(category: detailCategory.id)) {
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet(integer: 0))
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
                $0.trailing.equalTo(-175)
                $0.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.2)
            }
        }

        with(yourPlaylistButton) {
            $0.text = "Your Playlist: " + playlist.count.description

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.trailing.equalTo(checkoutButton.snp.leading).offset(-50)
                $0.centerY.equalTo(checkoutButton)
            }
        }

        with(searchButton) {
            $0.text = "🔍"

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.addAction(for: .touchUpInside) {

            }

            $0.snp.makeConstraints {
                $0.trailing.equalTo(checkoutButton.snp.trailing).offset(140)
                $0.centerY.equalTo(checkoutButton)
            }
        }
        
        with(collectionView) {
            view.addSubview($0)
            $0.delegate = self
            $0.dataSource = self
            $0.register(ImageViewCell.self, forCellWithReuseIdentifier: cellId)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(225)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(155)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-145)
                $0.bottom.equalTo(view)
            }
        }

        with(previousButton) {
            $0.setImage(UIImage(named: "left"), for: .normal)
            $0.addAction(for: .touchUpInside) {
                self.collectionView.setContentOffset(CGPoint(x: self.collectionView.contentOffset.x - self.collectionView.bounds.width, y: self.collectionView.contentOffset.y), animated: true)
            }

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
                $0.centerY.equalTo(view.safeAreaLayoutGuide)
                $0.width.height.equalTo(100)
            }
        }

        with(nextButton) {
            $0.setImage(UIImage(named: "right"), for: .normal)
            $0.addAction(for: .touchUpInside) {
                self.collectionView.setContentOffset(CGPoint(x: self.collectionView.contentOffset.x + self.collectionView.bounds.width, y: self.collectionView.contentOffset.y), animated: true)
            }

            $0.usesAutoLayout = true
            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
                $0.centerY.equalTo(view.safeAreaLayoutGuide)
                $0.width.height.equalTo(100)
            }
        }
        
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
        // Do any additional setup after loading the view.
    }

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.songs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageViewCell
        
        cell.backgroundColor = .clear
        
        cell.title = store.songs[indexPath.row].name
        cell.image = store.songs[indexPath.row].getSongPicture()
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playlist.append((store.songs[indexPath.row], 1))
        with(yourPlaylistButton) {
            $0.text = "Your Playlist: " + playlist.count.description
            
            $0.usesAutoLayout = true
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.trailing.equalTo(checkoutButton.snp.leading).offset(-75)
                $0.centerY.equalTo(checkoutButton)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfItemsPerRow: CGFloat = 3.0
//
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//        let totalSpace = flowLayout.sectionInset.left
//            + flowLayout.sectionInset.right
//            + (flowLayout.minimumInteritemSpacing * numberOfItemsPerRow - 1)
//        let size = Int((collectionView.bounds.width - totalSpace) / numberOfItemsPerRow)
        return CGSize(width: (collectionView.bounds.width / 3) - 10, height: collectionView.bounds.height)
//        return CGSize(width: size, height: Int(collectionView.bounds.height))
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
//        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
//
//        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        let rightInset = leftInset
//
//        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//
//    }

}

class ImageViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleOverlay = UIView()
    let bottomOverlay = UIView()
    let label = UILabel()
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var title: String = "" {
        didSet {
            // Create your own styles
            
            let normal = Style {
                $0.font = SystemFonts.Helvetica.font(size: 24)
            }
            
            let italic = normal.byAdding {
                $0.traitVariants = .italic
                $0.font = SystemFonts.Helvetica.font(size: 16)
            }
            
            // Create a group which contains your style, each identified by a tag.
            let myGroup = StyleGroup(base: normal, ["i": italic])
            
            label.attributedText = title.set(style: myGroup)
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.usesAutoLayout = true
            titleOverlay.addSubview(label)
            
            label.snp.makeConstraints {
                $0.edges.equalTo(titleOverlay)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        with(imageView) {
            
            $0.contentMode = .scaleAspectFit

            $0.usesAutoLayout = true
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(self)
                $0.width.equalTo(self)
                $0.height.equalTo(imageView.snp.width).multipliedBy(1.46060606)
                $0.centerX.equalTo(self)
            }
        }
        
        with(titleOverlay) {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)

            $0.usesAutoLayout = true
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(self)
                $0.height.equalTo(75)
                $0.width.equalTo(self)
                $0.centerX.equalTo(self)
            }
        }
        
        with(bottomOverlay) {
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = UIColor.init(red: 0.294, green: 0.651, blue: 0.624, alpha: 0.6)

            $0.usesAutoLayout = true
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.bottom.equalTo(imageView)
                $0.height.equalTo(50)
                $0.width.equalTo(self)
                $0.centerX.equalTo(self)
            }
            
            let label = UILabel()
            label.text = "ADD TO PLAYLIST"
            label.font = Font.systemFont(ofSize: 24)
            label.textAlignment = .center
            label.textColor = UIColor.white
            label.usesAutoLayout = true
            bottomOverlay.addSubview(label)
            
            label.snp.makeConstraints {
                $0.edges.equalTo(bottomOverlay)
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        label.text = ""
    }

}
