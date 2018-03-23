//
//  IconCell.swift
//  CheckList
//
//  Created by getTrickS2 on 3/23/18.
//  Copyright © 2018 getTrickS2. All rights reserved.
//

import UIKit

class IconCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let iconIV = UIImageView()
        iconIV.contentMode = .scaleAspectFill
        iconIV.translatesAutoresizingMaskIntoConstraints = false
        return iconIV
    }()
    
    func configure(iconName: String) {
        // 1. Set subviews
        self.addSubview(imageView)
        // 2. Set constraints
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // 3. Set image
        imageView.image = UIImage(named: iconName)
        
    }

}
