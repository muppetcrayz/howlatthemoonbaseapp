//
//  BackgroundViewController.swift
//  howlatthemoon
//
//  Created by Sage Conger on 2/25/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(named: "partypic2"))
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let image2 = UIImageView(image: UIImage(named: "logo"))
        
        image2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(image2)
        
        NSLayoutConstraint.activate([
            image2.heightAnchor.constraint(equalToConstant: 130),
            image2.widthAnchor.constraint(equalToConstant: 264),
            image2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
            ])
        
    }

}
