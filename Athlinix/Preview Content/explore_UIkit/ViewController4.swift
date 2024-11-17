//
//  ViewController.swift
//  explore
//
//  Created by admin65 on 17/11/24.
//

import UIKit

class viewui: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let dummyFeed = [
        Feed(
            athleteName: "Parth Sinh",
            athleteProfile: UIImage(named: "profile")!,
            teamName: "Phoenix Suns",
            teamLogo: UIImage(named: "cavs")!,
            location: "Los Angeles",
            likeCount: 3300,
            image1: UIImage(named: "feed2")!, // Second's photo
            image2: UIImage(named: "feed3")!, // Second's photo
            image3: UIImage(named: "feed4")!  // Second's photo
        ),
        Feed(
            athleteName: "Alex",
            athleteProfile: UIImage(named: "profile5")!,
            teamName: "Lakers",
            teamLogo: UIImage(named: "bulls")!,
            location: "New York",
            likeCount: 2000,
            image1: UIImage(named: "feed6")!,
            image2: UIImage(named: "feed5")!,
            image3: UIImage(named: "feed7")!
        ),
        Feed(
            athleteName: "Sophia",
            athleteProfile: UIImage(named: "profile4")!,
            teamName: "Golden State Warriors",
            teamLogo: UIImage(named: "warriors")!,
            location: "San Francisco",
            likeCount: 4000,
            image1: UIImage(named: "feed7")!,
            image2: UIImage(named: "feed2")!,
            image3: UIImage(named: "feed4")!
        ),
        Feed(
            athleteName: "Michael",
            athleteProfile: UIImage(named: "profile2")!,
            teamName: "Chicago Bulls",
            teamLogo: UIImage(named: "cavs")!,
            location: "Chicago",
            likeCount: 2700,
            image1: UIImage(named: "feed3")!,
            image2: UIImage(named: "feed2")!,
            image3: UIImage(named: "feed1")!
        ),
        Feed(
            athleteName: "Emma",
            athleteProfile: UIImage(named: "profile5")!,
            teamName: "Miami Heat",
            teamLogo: UIImage(named: "nets")!,
            location: "Miami",
            likeCount: 3500,
            image1: UIImage(named: "feed2")!,
            image2: UIImage(named: "feed3")!,
            image3: UIImage(named: "feed4")!
        ),
        Feed(
            athleteName: "David",
            athleteProfile: UIImage(named: "profile1")!,
            teamName: "BFI",
            teamLogo: UIImage(named: "lakers")!,
            location: "Gurgaon",
            likeCount: 3100,
            image1: UIImage(named: "feed5")!, // First's photo
            image2: UIImage(named: "feed6")!, // First's photo
            image3: UIImage(named: "feed7")!  // First's photo
        ),
        Feed(
            athleteName: "Liam",
            athleteProfile: UIImage(named: "profile")!,
            teamName: "Brooklyn Nets",
            teamLogo: UIImage(named: "spurs1")!,
            location: "Brooklyn",
            likeCount: 2900,
            image1: UIImage(named: "feed1")!,
            image2: UIImage(named: "feed2")!,
            image3: UIImage(named: "feed3")!
        )
    ]

    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
       

            tableView.delegate = self
            tableView.dataSource = self
        }

        func numberOfSections(in tableView: UITableView) -> Int {
            return 2 // Trending and Feeds
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return 1 // Trending has 1 row
            } else {
                return dummyFeed.count // Number of feeds
            }
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 { // Trending section
                   let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingCell", for: indexPath) as! TrendingCell

                   // Configure the cell with dummy data
                   cell.leaderboardTitleLabel.text = "Global Team Leaderboard"
                   cell.team1LogoImageView.image = UIImage(named: "cavs")
                   cell.team2LogoImageView.image = UIImage(named: "lakers")
                   cell.team3LogoImageView.image = UIImage(named: "warriors")
                   

                   return cell
               } else {
                   let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
                   
                   
                   let feed = dummyFeed[indexPath.row]
                   // Configure FeedCell
                   cell.configure(with: feed)

                       return cell
               }
           }
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
                return 120 // Height for trending section
            } else {
                return 351 // Height for feed cells
            }
        }
    
