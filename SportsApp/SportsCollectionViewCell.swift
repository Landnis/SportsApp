//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by kwstas stergiannis on 26/8/23.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    var shouldCollapse = false

    @IBOutlet weak var extendedButton: UIButton! {
        didSet {
            extendedButton.tintColor = .lightGray
            extendedButton.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
            extendedButton.backgroundColor = .clear
            extendedButton.addTarget(self, action: #selector(extendedButtonPressed), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var sportsDetailsCollectionView: UICollectionView! {
        didSet {
            sportsDetailsCollectionView.isScrollEnabled = true
            sportsDetailsCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            let filterCollectionNib = UINib(nibName: "DetailsCollectionViewCell", bundle: .main)
            self.sportsDetailsCollectionView.register(filterCollectionNib, forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        }
    }
    @IBOutlet weak var sportsImage: UIImageView! {
        didSet {
            sportsImage.tintColor = .white
            sportsImage.image = UIImage(systemName: "soccerball")
        }
    }
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var sportsNameLabel: UILabel! {
        didSet {
            sportsNameLabel.font = sportsNameLabel.font.withSize(20)
            sportsNameLabel.textColor = .lightGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerForNotifications()
        sportsDetailsCollectionView.dataSource = self
        sportsDetailsCollectionView.delegate = self
    }
    
    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateSports), name: NSNotification.Name("UpdateSportsDescription"), object: nil)
    }
    
    @objc func updateSports() {
        sportsDetailsCollectionView.reloadData()
    }
    
    func convertTimestampToDate(timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:MM:SS"
        return dateFormatter.string(from: date)
    }
    
    @objc func extendedButtonPressed() {
       shouldCollapse = !shouldCollapse
       if shouldCollapse {
           sportsDetailsCollectionView.collectionViewLayout.collectionView?.alpha = 0.0
           extendedButton.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
       } else {
           sportsDetailsCollectionView.collectionViewLayout.collectionView?.alpha = 1.0
           extendedButton.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
       }
    }

}

extension SportsCollectionViewCell: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if sportsNameLabel.text == "SOCCER" {
            return ViewController.shared.footDescriptionArray.count
        } else if sportsNameLabel.text == "BASKETBALL" {
            return ViewController.shared.basketDescriptionArray.count
        } else if sportsNameLabel.text == "TENNIS" {
            return ViewController.shared.tennisDescriptionArray.count
        } else if sportsNameLabel.text == "TABLE TENNIS" {
            return ViewController.shared.tableTennisDescriptionArray.count
        } else if sportsNameLabel.text == "ESPORTS" {
            return ViewController.shared.esportsDescriptionArray.count
        } else if sportsNameLabel.text == "BASEBALL" {
            return ViewController.shared.baseballDescriptionArray.count
        } else if sportsNameLabel.text == "HANDBALL" {
            return ViewController.shared.handBallDescriptionArray.count
        } else if sportsNameLabel.text == "BEACH VOLLEYBALL" {
            return ViewController.shared.volleyDescriptionArray.count
        } else if sportsNameLabel.text == "DARTS" {
            return ViewController.shared.dartsDescriptionArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell ?? DetailsCollectionViewCell()
        
        if sportsNameLabel.text == "SOCCER" {
            cell.sportsDescriptionLabel.text = ViewController.shared.footDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.footTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        } else if sportsNameLabel.text == "BASKETBALL" {
            cell.sportsDescriptionLabel.text = ViewController.shared.basketDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.basketTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        } else if sportsNameLabel.text == "TENNIS" {
            cell.sportsDescriptionLabel.text = ViewController.shared.tennisDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.tennisTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        } else if sportsNameLabel.text == "TABLE TENNIS" {
            cell.sportsDescriptionLabel.text = ViewController.shared.tableTennisDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.tableTennisTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        } else if sportsNameLabel.text == "ESPORTS" {
            cell.sportsDescriptionLabel.text = ViewController.shared.esportsDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.esportsTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        } else if sportsNameLabel.text == "BASEBALL" {
            cell.sportsDescriptionLabel.text = ViewController.shared.baseballDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.baseballTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        } else if sportsNameLabel.text == "HANDBALL" {
            cell.sportsDescriptionLabel.text = ViewController.shared.handBallDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.handBallTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        } else if sportsNameLabel.text == "BEACH VOLLEYBALL" {
            cell.sportsDescriptionLabel.text = ViewController.shared.volleyDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.volleyTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        } else if  sportsNameLabel.text == "DARTS" {
            cell.sportsDescriptionLabel.text = ViewController.shared.dartsDescriptionArray[indexPath.row]
            let formattedDate = convertTimestampToDate(timestamp: ViewController.shared.dartsTimerArray[indexPath.row] ?? Int64())
            cell.dateButton.setTitle(formattedDate, for: .normal)
        }
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/4, height: shouldCollapse ? 0 : 128)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           // Define the content inset for the specified section
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }
    
}
