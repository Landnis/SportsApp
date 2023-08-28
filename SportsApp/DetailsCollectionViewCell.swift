//
//  DetailsCollectionViewCell.swift
//  SportsApp
//
//  Created by kwstas stergiannis on 27/8/23.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    var isFavourite = false

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var dateButton: UIButton! {
        didSet {
            dateButton.layer.cornerRadius = 5.0
            dateButton.layer.borderWidth = 1.0
            dateButton.titleLabel?.font = dateButton.titleLabel?.font.withSize(18)
            dateButton.titleLabel?.textColor = .lightGray
            dateButton.layer.borderColor = UIColor.lightGray.cgColor
            dateButton.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var starButton: UIButton! {
        didSet {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            starButton.tintColor = .lightText
            starButton.backgroundColor = .clear
            starButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var sportsDescriptionLabel: UILabel! {
        didSet {
            sportsDescriptionLabel.textAlignment = .left
            sportsDescriptionLabel.textColor = .lightGray
            sportsDescriptionLabel.numberOfLines = 2
            sportsDescriptionLabel.font = sportsDescriptionLabel.font.withSize(12)
        }
    }
    
    @objc func favouriteButtonPressed() {
        isFavourite = !isFavourite
        if isFavourite {
            starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            starButton.tintColor = .yellow
            starButton.layer.borderColor = UIColor.lightGray.cgColor
            
        } else {
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            starButton.tintColor = .lightText
            starButton.layer.borderColor = UIColor.lightText.cgColor
        }

    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
