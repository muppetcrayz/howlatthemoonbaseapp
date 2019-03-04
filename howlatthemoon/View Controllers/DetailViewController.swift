//
//  DetailViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 3/3/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class DetailViewController: HowlAtTheMoonViewController {
    let scrollView = UIScrollView(frame: .zero)

    let image = UIImage(named: "exampleDetailImage")!

    let previousButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        with(scrollView) {
            $0.isPagingEnabled = true

            (0...8).forEach { i in

                let imageView = UIImageView(image: image)
                
                scrollView.addSubview(imageView)

                imageView.snp.makeConstraints {
                    $0.leading.equalTo(scrollView).offset(CGFloat(i) * (image.size.width + 25))
                    $0.top.equalTo(scrollView)
                }
            }

            view.addSubview($0)
            $0.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(225)
                $0.centerX.equalTo(view.safeAreaLayoutGuide)
                $0.width.equalTo(3 * (image.size.width + 25))
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(150)
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-150)
                $0.bottom.equalTo(view)
            }
        }

        with(previousButton) {
            $0.setTitle("Previous", for: .normal)
            $0.addAction(for: .touchUpInside) {
                self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x - (3 * (self.image.size.width + 25)), y: self.scrollView.contentOffset.y), animated: true)
            }

            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
                $0.centerY.equalTo(view.safeAreaLayoutGuide)
            }
        }

        with(nextButton) {
            $0.setTitle("Next", for: .normal)
            $0.addAction(for: .touchUpInside) {
                self.scrollView.setContentOffset(CGPoint(x: self.scrollView.contentOffset.x + (3 * (self.image.size.width + 25)), y: self.scrollView.contentOffset.y), animated: true)
            }

            view.addSubview($0)

            $0.snp.makeConstraints {
                $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
                $0.centerY.equalTo(view.safeAreaLayoutGuide)
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
