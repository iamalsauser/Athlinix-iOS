//
//  ViewController.swift
//  teamScreen
//
//  Created by admin65 on 15/11/24.
//

import UIKit

class team_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var hello: Teamui! = teamSampleData
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    
    @IBOutlet weak var coachCollectionView: UICollectionView!
    @IBOutlet weak var membersCollectionView: UICollectionView!
    
    
    // Sample data
      var coaches: [Coach] = []
      var members: [Athlete] = []
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Setting up delegates and data sources
          coachCollectionView.delegate = self
          coachCollectionView.dataSource = self
          
          membersCollectionView.delegate = self
          membersCollectionView.dataSource = self
          
          teamName.text = hello.teamName
          teamImageView.image = UIImage(named: "team1")
          // Initialize sample data

      }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if collectionView == coachCollectionView {
                return hello.coach.count
            } else {
                return hello.members.count
            }
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == coachCollectionView {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoachCell", for: indexPath) as! coachCollectionViewCell
                cell.configure(with: hello.coach[indexPath.item])
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCell", for: indexPath) as! membersCollectionViewCell
                cell.configure(with: hello.members[indexPath.item])
                return cell
            }
        }

//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 70, height: 90) // Adjust based on design needs
//        }
    }
