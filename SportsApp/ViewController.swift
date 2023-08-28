//
//  ViewController.swift
//  SportsApp
//
//  Created by kwstas stergiannis on 26/8/23.
//

import UIKit
import SwiftyJSON
import Alamofire

private enum SportsDescription {
    
    case footBall
    case basketball
    case tennis
    case tableTennis
    case esports
    case handBall
    case baseBall
    case beachVolley
    case darts
}

struct Event {
    let id: String
    let sportId: String
    let sportName: String
    let matchName: String
    let description: String
    let timestamp: Int64

    init(json: JSON) {
        id = json["i"].stringValue
        sportId = json["si"].stringValue
        sportName = json["sh"].stringValue
        matchName = json["d"].stringValue
        description = json["d"].stringValue
        timestamp = json["tt"].int64Value
    }
}

struct SportsCategory {
    let category: String?
    let categoryID: String?
    let events: [Event]

    init(json: JSON) {
        category = json["d"].stringValue
        categoryID = json["i"].stringValue
        events = json["e"].arrayValue.map { Event(json: $0) }
    }
}

class ViewController: UIViewController {
    
    static let shared = ViewController()

    @IBOutlet var sportsView: SportsView!
    var categoriesArray: [String?] = []
    var collapse = false
    
    fileprivate var sportsDescription: [SportsDescription] = []
    
    // Sports descrription Arrays.
    var footDescriptionArray: [String?] = []
    var basketDescriptionArray: [String?] = []
    var esportsDescriptionArray: [String?] = []
    var tennisDescriptionArray: [String?] = []
    var volleyDescriptionArray: [String?] = []
    var baseballDescriptionArray: [String?] = []
    var tableTennisDescriptionArray: [String?] = []
    var dartsDescriptionArray: [String?] = []
    var handBallDescriptionArray: [String?] = []
    
    // Matches timer arrays.
    var footTimerArray:[Int64?] = []
    var basketTimerArray: [Int64?] = []
    var esportsTimerArray:[Int64?] = []
    var tennisTimerArray: [Int64?] = []
    var volleyTimerArray: [Int64?] = []
    var baseballTimerArray: [Int64?] = []
    var tableTennisTimerArray:[Int64?] = []
    var dartsTimerArray: [Int64?] = []
    var handBallTimerArray: [Int64?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSportsDesc()
        configureFetch()
    }

    
    func configureFetch() {
        fetchSports { result in
            switch result {
            case .success(let sportsCategories):
                for category in sportsCategories {
                    self.categoriesArray.append(category.category)
                    
                    ViewController.shared.categoriesArray.append(category.category)
                    
                    for event in category.events {
                        
                        if category.category == "SOCCER" {
                            ViewController.shared.footDescriptionArray.append(event.description)
                            ViewController.shared.categoriesArray.append(category.category)
                            ViewController.shared.footTimerArray.append(event.timestamp)
                        } else if category.category == "BASKETBALL" {
                            ViewController.shared.basketDescriptionArray.append(event.description)
                            ViewController.shared.basketTimerArray.append(event.timestamp)
                            ViewController.shared.categoriesArray.append(category.category)
                        } else if category.category == "TENNIS" {
                            ViewController.shared.tennisDescriptionArray.append(event.description)
                            ViewController.shared.tennisTimerArray.append(event.timestamp)
                            ViewController.shared.categoriesArray.append(category.category)
                        } else if category.category == "TABLE TENNIS" {
                            ViewController.shared.tableTennisDescriptionArray.append(event.description)
                            ViewController.shared.tableTennisTimerArray.append(event.timestamp)
                            ViewController.shared.categoriesArray.append(category.category)
                        } else if category.category == "ESPORTS" {
                            ViewController.shared.esportsDescriptionArray.append(event.description)
                            ViewController.shared.esportsTimerArray.append(event.timestamp)
                            ViewController.shared.categoriesArray.append(category.category)
                        } else if category.category == "BASEBALL" {
                            ViewController.shared.baseballDescriptionArray.append(event.description)
                            ViewController.shared.baseballTimerArray.append(event.timestamp)
                            ViewController.shared.categoriesArray.append(category.category)
                        } else if category.category == "HANDBALL" {
                            ViewController.shared.handBallDescriptionArray.append(event.description)
                            ViewController.shared.handBallTimerArray.append(event.timestamp)
                            ViewController.shared.categoriesArray.append(category.category)
                        } else if category.category == "BEACH VOLLEYBALL" {
                            ViewController.shared.volleyDescriptionArray.append(event.description)
                            ViewController.shared.volleyTimerArray.append(event.timestamp)
                            ViewController.shared.categoriesArray.append(category.category)
                        } else {
                            ViewController.shared.dartsDescriptionArray.append(event.description)
                            ViewController.shared.dartsTimerArray.append(event.timestamp)
                            ViewController.shared.categoriesArray.append(category.category)
                        }
                    }
                }
                self.sportsView.sportsCollectionView.delegate = self
                self.sportsView.sportsCollectionView.dataSource = self
                self.sportsView.sportsCollectionView.reloadData()
            case .failure(let error):
                print("Error fetching sports: \(error)")
            }
        }
    }
    
    func configureSportsDesc() {
        sportsDescription.removeAll()
        
        sportsDescription.append(.footBall)
        sportsDescription.append(.basketball)
        sportsDescription.append(.tennis)
        sportsDescription.append(.tableTennis)
        sportsDescription.append(.esports)
        sportsDescription.append(.baseBall)
        sportsDescription.append(.handBall)
        sportsDescription.append(.beachVolley)
        sportsDescription.append(.darts)
    }

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoriesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sportsView.sportsCollectionView.dequeueReusableCell(withReuseIdentifier: "SportsCollectionViewCell", for: indexPath) as? SportsCollectionViewCell ?? SportsCollectionViewCell()
        
        switch sportsDescription[indexPath.row] {
        case .footBall:
            cell.sportsImage.image = UIImage(systemName: "soccerball")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        case .basketball:
            cell.sportsImage.image = UIImage(systemName: "basketball.fill")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        case .tennis:
            cell.sportsImage.image = UIImage(systemName: "tennisball.fill")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        case .tableTennis:
            cell.sportsImage.image = UIImage(systemName: "tennis.racket")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        case .esports:
            cell.sportsImage.image = UIImage(systemName: "gamecontroller.fill")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        case .baseBall:
            cell.sportsImage.image = UIImage(systemName: "baseball.fill")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        case .handBall:
            cell.sportsImage.image = UIImage(systemName: "figure.handball")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        case .beachVolley:
            cell.sportsImage.image = UIImage(systemName: "volleyball.fill")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        case .darts:
            cell.sportsImage.image = UIImage(systemName: "target")
            cell.sportsNameLabel.text = categoriesArray[indexPath.row]
        }
        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        NotificationCenter.default.post(name: NSNotification.Name("UpdateSportsDescription"), object: nil)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 180)
    }
   

}

extension ViewController {
    
    func fetchSports(completion: @escaping (Result<[SportsCategory], Error>) -> Void) {
        let apiUrl = "https://618d3aa7fe09aa001744060a.mockapi.io/api/sports"
        
        AF.request(apiUrl).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var sportsCategories: [SportsCategory] = []
                if json.type == .array {
                    for (_, subJson) in json {
                        let sportsCategory = SportsCategory(json: subJson)
                        sportsCategories.append(sportsCategory)
                    }
                }
                
                completion(.success(sportsCategories))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
