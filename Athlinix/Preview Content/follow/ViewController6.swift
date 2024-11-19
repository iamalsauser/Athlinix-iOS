//
//  ViewController.swift
//  profile
//
//  Created by admin65 on 17/11/24.
//

import UIKit

class ViewController6: UIViewController {

    @IBOutlet weak var backgroundPicture: UIImageView!
    
   
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var playerOrCoachLabel: UILabel!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var matches: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var ppg: UILabel!
    @IBOutlet weak var bpg: UILabel!
    @IBOutlet weak var ast: UILabel!
    
    @IBOutlet weak var teamCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var bestGameMyTeamLogo: UIImageView!
    @IBOutlet weak var bestGameMyTeamName: UILabel!
    @IBOutlet weak var bestGameOpponentTeamLogo: UIImageView!
    @IBOutlet weak var bestGameOpponentTeamName: UILabel!
    @IBOutlet weak var bestGameMyTeam2pters: UILabel!
    @IBOutlet weak var bestGameMyTeam3pters: UILabel!
    @IBOutlet weak var bestGameMyTeamFreeThrows: UILabel!
    @IBOutlet weak var bestGameOpponentTeam2pters: UILabel!
    @IBOutlet weak var bestGameOpponentTeam3pters: UILabel!
    @IBOutlet weak var bestGameOpponentFreeThrows: UILabel!
    
    
    // Outlets for Feeds Section
    //@IBOutlet weak var tableView: UITableView!

    // Dummy Data
    var user6: User6 = {
        // Dummy Teams
        let teams = [
            Team6(teamName: "Kings", teamLogo: UIImage(named: "team1") ?? UIImage()),
            Team6(teamName: "Raptors", teamLogo: UIImage(named: "team2") ?? UIImage()),
            Team6(teamName: "Warriors", teamLogo: UIImage(named: "team3") ?? UIImage())
        ]
        
        // Dummy Best Game
        let bestGame = BestGame(
            myTeamName: "LA Lakers",
            myTeamLogo: UIImage(named: "team4") ?? UIImage(),
            opponentTeamName: "BFI",
            opponentTeamLogo: UIImage(named: "team5") ?? UIImage(),
            myTeamFieldGoals: 47,
            myTeam3PFieldGoals: 10,
            myTeamFreeThrows: 6,
            opponentFieldGoals: 43,
            opponent3PFieldGoals: 7,
            opponentFreeThrows: 3
        )
        
        // Dummy Feed
        let feed = [
            Feed6(
                athleteName: "Akshay Sharma",
                athleteProfile: UIImage(named: "4") ?? UIImage(),
                teamName: "Phoenix Suns",
                teamLogo: UIImage(named: "team5") ?? UIImage(),
                location: "Los Angeles",
                likeCount: 3300,
                image1: UIImage(named: "Images18") ?? UIImage(),
                image2: UIImage(named: "Images19") ?? UIImage(),
                image3: UIImage(named: "Images17") ?? UIImage()
            ),
            Feed6(
                athleteName: "Akshay Sharma",
                athleteProfile: UIImage(named: "4") ?? UIImage(),
                teamName: "Los Angeles Lakers",
                teamLogo: UIImage(named: "team6") ?? UIImage(),
                location: "Los Angeles",
                likeCount: 2900,
                image1: UIImage(named: "Images4") ?? UIImage(),
                image2: UIImage(named: "Images5") ?? UIImage(),
                image3: UIImage(named: "Images6") ?? UIImage()
            ),
            Feed6(
                athleteName: "Akshay Sharma",
                athleteProfile: UIImage(named: "4") ?? UIImage(),
                teamName: "Golden State Warriors",
                teamLogo: UIImage(named: "team7") ?? UIImage(),
                location: "San Francisco",
                likeCount: 3800,
                image1: UIImage(named: "image7") ?? UIImage(),
                image2: UIImage(named: "Images8") ?? UIImage(),
                image3: UIImage(named: "Images10") ?? UIImage()
            ),
            Feed6(
                athleteName: "Akshay Sharma",
                athleteProfile: UIImage(named: "4") ?? UIImage(),
                teamName: "Miami Heat",
                teamLogo: UIImage(named: "team8") ?? UIImage(),
                location: "Miami",
                likeCount: 2700,
                image1: UIImage(named: "Images11") ?? UIImage(),
                image2: UIImage(named: "Images12") ?? UIImage(),
                image3: UIImage(named: "Images13") ?? UIImage()
            )
        ]

        
        // Return the User object
        return User6(
            userName: "Akshay Sharma",
            isVerified: true,
            playerOrCoach: "Player",
            experience: "11 yrs exp.",
            bio: "Basketball player passionate about the game.",
            profilePicture: UIImage(named: "4") ?? UIImage(),
            backgroundPicture: UIImage(named: "srmUni") ?? UIImage(),
            position: "PF",
            matches: 24,
            height: "6'11\"",
            weight: 265,
            ppg: 17.8,
            bpg: 3.4,
            ast: 9,
            teams: teams,
            bestGame: bestGame,
            feed: feed
        )
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfileScreen()
        setupCollectionView()
        setupTableView()
        
        followButton.backgroundColor = UIColor(hex: "#FD6430")
    }

    // Configure Profile Screen
    func configureProfileScreen() {
        userName.text = user6.userName
        playerOrCoachLabel.text = "\(user6.playerOrCoach) - \(user6.experience)"
        userBio.text = user6.bio
        profilePicture.image = user6.profilePicture
        backgroundPicture.image = user6.backgroundPicture
        position.text = user6.position
        matches.text = "\(user6.matches)"
        height.text = user6.height
        weight.text = "\(user6.weight) lbs"
        ppg.text = "\(user6.ppg)"
        bpg.text = "\(user6.bpg)"
        ast.text = "\(user6.ast)"
        bestGameMyTeamLogo.image = user6.bestGame.myTeamLogo
        bestGameMyTeamName.text = user6.bestGame.myTeamName
        bestGameOpponentTeamLogo.image = user6.bestGame.opponentTeamLogo
        bestGameOpponentTeamName.text = user6.bestGame.opponentTeamName
        bestGameMyTeam2pters.text = "\(user6.bestGame.myTeamFieldGoals)"
        bestGameMyTeam3pters.text = "\(user6.bestGame.myTeam3PFieldGoals)"
        bestGameMyTeamFreeThrows.text = "\(user6.bestGame.myTeamFreeThrows)"
        bestGameOpponentTeam2pters.text = "\(user6.bestGame.opponentFieldGoals)"
        bestGameOpponentTeam3pters.text = "\(user6.bestGame.opponent3PFieldGoals)"
        bestGameOpponentFreeThrows.text = "\(user6.bestGame.opponentFreeThrows)"
    }

    // Collection View Setup
    func setupCollectionView() {
        teamCollectionView.delegate = self
        teamCollectionView.dataSource = self
    }

    // Table View Setup
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    @IBAction func followButtonPressed(_ sender: Any) {
        followButton.setTitle("Following", for: .normal)
    
    }

    

    
}



// MARK: - Collection View DataSource & Delegate
extension ViewController6: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user6.teams.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCollectionViewCell
        let team = user6.teams[indexPath.row]
        cell.configure(with: team)
        return cell
    }
}

// MARK: - Table View DataSource & Delegate
extension ViewController6: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user6.feed.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let feed = user6.feed[indexPath.row]
        cell.configure(with: feed)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 351
    }
}

extension UIColor {
    convenience init(hex6: String) {
        var hexSanitized = hex6.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
