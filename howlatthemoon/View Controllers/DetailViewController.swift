//
//  DetailViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 3/3/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class DetailViewController: HowlAtTheMoonViewController {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let newCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        newCollectionView.usesAutoLayout = true
        newCollectionView.backgroundColor = .clear
        newCollectionView.isScrollEnabled = true
        return newCollectionView
    }()
//    let scrollView = UIScrollView(frame: .zero)

    let image = UIImage(named: "exampleDetailImage")!

    let previousButton = UIButton(type: .custom)
    let nextButton = UIButton(type: .custom)
    
    let cellId = "ImageCell"

    override func viewDidLoad() {
        super.viewDidLoad()

//        with(scrollView) {
//            $0.isPagingEnabled = true
//
//            (0...8).forEach { i in
//
//                let imageView = UIImageView(image: image)
//
//                scrollView.addSubview(imageView)
//
//                imageView.snp.makeConstraints {
//                    $0.width.equalTo(scrollView).multipliedBy(0.3)
//                    $0.height.equalTo(imageView.snp.width).multipliedBy(1.4606060606)
//                    $0.centerX.equalTo(scrollView).multipliedBy(0.3 + (CGFloat(i) * 0.75) + ((CGFloat(i) / 3) * -0.1))
//                    $0.top.equalTo(scrollView)
//                }
//            }
//
//            view.addSubview($0)
//            $0.snp.makeConstraints {
//                $0.top.equalTo(view.safeAreaLayoutGuide).offset(225)
//                $0.centerX.equalTo(view.safeAreaLayoutGuide)
//                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(150)
//                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-150)
//                $0.bottom.equalTo(view)
//            }
//        }
        
        with(collectionView) {
            view.addSubview($0)
            $0.delegate = self
            $0.dataSource = self
            $0.register(ImageViewCell.self, forCellWithReuseIdentifier: cellId)
            
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(225)
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(150)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-150)
                $0.bottom.equalTo(view)
            }
        }

        with(previousButton) {
            $0.setImage(UIImage(named: "left"), for: .normal)
            $0.addAction(for: .touchUpInside) {
                self.collectionView.setContentOffset(CGPoint(x: self.collectionView.contentOffset.x - self.collectionView.bounds.width, y: self.collectionView.contentOffset.y), animated: true)
            }

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

            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
                $0.centerY.equalTo(view.safeAreaLayoutGuide)
                $0.width.height.equalTo(100)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ImageViewCell
        
        cell.backgroundColor = .clear
        
        cell.image = UIImage(named: "exampleDetailImage")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 3.0
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * numberOfItemsPerRow - 1)
        let size = Int((collectionView.bounds.width - totalSpace) / numberOfItemsPerRow)
        return CGSize(width: size, height: Int(collectionView.bounds.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        
    }
}

class ImageViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        with(imageView) {
            $0.contentMode = .scaleAspectFit
            
            addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalTo(self)
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
