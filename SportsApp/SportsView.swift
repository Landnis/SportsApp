//
//  SportsView.swift
//  SportsApp
//
//  Created by kwstas stergiannis on 26/8/23.
//

import UIKit

class SportsView: UIView {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var sportsCollectionView: UICollectionView! {
        didSet {
            sportsCollectionView.isScrollEnabled = true
            sportsCollectionView.layoutIfNeeded()
            sportsCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            let filterCollectionNib = UINib(nibName: "SportsCollectionViewCell", bundle: .main)
            self.sportsCollectionView.register(filterCollectionNib, forCellWithReuseIdentifier: "SportsCollectionViewCell")
        }
    }
    @IBOutlet weak var gearImage: UIImageView! {
        didSet {
            gearImage.tintColor = .white
        }
    }
    
    @IBOutlet weak var appNameLabel: UILabel! {
        didSet {
            appNameLabel.text = "Sports App"
            appNameLabel.font = appNameLabel.font.withSize(24)
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.tintColor = .white
        }
    }
    
}
