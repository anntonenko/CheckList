//
//  DropDownCell.swift
//  CheckList
//
//  Created by getTrickS2 on 3/23/18.
//  Copyright © 2018 getTrickS2. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {
    // MARK: - Variables ===========================
    let iconCellID = "iconCell"
    let icons = [
        "No Icon",
        "Appointments",
        "Birthdays",
        "Chores",
        "Drinks",
        "Folder",
        "Groceries",
        "Inbox",
        "Photos",
        "Trips"]
    
    var heightCollectionView: NSLayoutConstraint!
    var isTaped = false
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Icon"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let iconIV = UIImageView()
        iconIV.contentMode = .scaleAspectFill
        iconIV.translatesAutoresizingMaskIntoConstraints = false
        return iconIV
    }()
    
    let cellView: UIView = {
        let contView = UIView()
        contView.translatesAutoresizingMaskIntoConstraints = false
        return contView
    }()
    
    let dropDownCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let dropDownC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dropDownC.backgroundColor = .clear
        dropDownC.translatesAutoresizingMaskIntoConstraints = false
        return dropDownC
    }()
    // ===================================================
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Functions ================================
    func configure(imageName: String) {
        iconImageView.image = UIImage(named: imageName)
    }
    
    private func setupConstraints() {
        // 1. cellView
        cellView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cellView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        // 2. dropDownCollection
        dropDownCollection.topAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        dropDownCollection.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dropDownCollection.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        heightCollectionView = dropDownCollection.heightAnchor.constraint(equalToConstant: 64)
        heightCollectionView.isActive = true
    }
    
    private func configureCellView() {
        // 1. Add Subview
        cellView.addSubview(iconLabel)
        cellView.addSubview(iconImageView)
        // 2. Add Constraints
        // 2.1 iconLabel
        iconLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        iconLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20).isActive = true
        // 2.2 iconImageView
        iconImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
    }
    
    // ==================================================
    
    
    // MARK: - Override functions =======================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 1. Set delegates
        dropDownCollection.register(IconCell.self, forCellWithReuseIdentifier: iconCellID)
        dropDownCollection.delegate = self
        dropDownCollection.dataSource = self
        // 2. Add subviews
        self.addSubview(cellView)
        self.addSubview(dropDownCollection)
        // 3. Another setup
        configureCellView()
        setupConstraints()
    }
    
    public func startAnimation() {
        // Configure the view for the selected state
        
        if isTaped {
            NSLayoutConstraint.deactivate([heightCollectionView])
            heightCollectionView.constant = 0
            NSLayoutConstraint.activate([heightCollectionView])
            // Animation
            //UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            //   self.dropDownCollection.layoutIfNeeded()
            //}, completion: nil)
        } else {
            NSLayoutConstraint.deactivate([heightCollectionView])
            heightCollectionView.constant = 64
            NSLayoutConstraint.activate([heightCollectionView])
            // Animation
            //UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            //  self.dropDownCollection.layoutIfNeeded()
            //}, completion: nil)
        }
        
        isTaped = !isTaped
    }
 
    // ==================================================

}


extension DropDownCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dropDownCollection.dequeueReusableCell(withReuseIdentifier: iconCellID, for: indexPath) as! IconCell
        cell.configure(iconName: icons[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
}





