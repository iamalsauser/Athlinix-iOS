import UIKit

class ViewControllerprofile: UIViewController  {

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
    var user: User8 = {
        // Dummy Teams
        let teams = [
            Team8(teamName: "Kings", teamLogo: UIImage(named: "team1") ?? UIImage()),
            Team8(teamName: "Raptors", teamLogo: UIImage(named: "team2") ?? UIImage()),
            Team8(teamName: "Warriors", teamLogo: UIImage(named: "team3") ?? UIImage())
        ]
        
        // Dummy Best Game
        let bestGame = BestGame8(
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
            Feed8(
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
            Feed8(
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
            Feed8(
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
            Feed8(
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
        return User8(
            userName: "Akshay Sharma",
            isVerified: true,
            playerOrCoach: "Player",
            experience: "11 yrs exp.",
            bio: "Basketball player passionate about the game.",
            profilePicture: UIImage(named: "4") ?? UIImage(),
            backgroundPicture: UIImage(named: "Images8") ?? UIImage(),
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
        
        addBlurEffectToBackground()
    }
    
    func addBlurEffectToBackground() {
        let blurEffect = UIBlurEffect(style: .extraLight)  // You can change the style if needed
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Set the blurEffectView's frame to match the backgroundPicture's frame
        blurEffectView.frame = backgroundPicture.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Set the alpha to 70% to achieve the desired blur intensity
        blurEffectView.alpha = 0.7
        
        // Add the blur effect view on top of the background picture
        backgroundPicture.addSubview(blurEffectView)
    }

    // Configure Profile Screen
    func configureProfileScreen() {
        // Set the bio text
        userBio.text = user.bio
        
        // Add a bottom border to the bio label
        addBottomBorderToBio()
        
        // Other configurations...
        userName.text = user.userName
        playerOrCoachLabel.text = "\(user.playerOrCoach) - \(user.experience)"
        profilePicture.image = user.profilePicture
        backgroundPicture.image = user.backgroundPicture
        position.text = user.position
        matches.text = "\(user.matches)"
        height.text = user.height
        weight.text = "\(user.weight) lbs"
        ppg.text = "\(user.ppg)"
        bpg.text = "\(user.bpg)"
        ast.text = "\(user.ast)"
        bestGameMyTeamLogo.image = user.bestGame.myTeamLogo
        bestGameMyTeamName.text = user.bestGame.myTeamName
        bestGameOpponentTeamLogo.image = user.bestGame.opponentTeamLogo
        bestGameOpponentTeamName.text = user.bestGame.opponentTeamName
        bestGameMyTeam2pters.text = "\(user.bestGame.myTeamFieldGoals)"
        bestGameMyTeam3pters.text = "\(user.bestGame.myTeam3PFieldGoals)"
        bestGameMyTeamFreeThrows.text = "\(user.bestGame.myTeamFreeThrows)"
        bestGameOpponentTeam2pters.text = "\(user.bestGame.opponentFieldGoals)"
        bestGameOpponentTeam3pters.text = "\(user.bestGame.opponent3PFieldGoals)"
        bestGameOpponentFreeThrows.text = "\(user.bestGame.opponentFreeThrows)"
    }
    
    func addBottomBorderToBio() {
        // Create a UIView to act as the bottom border
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = UIColor.lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the border view to the main view
        view.addSubview(bottomBorder)
        
        // Set the constraints to position the border right below the bio label
        NSLayoutConstraint.activate([
            bottomBorder.topAnchor.constraint(equalTo: userBio.bottomAnchor, constant: 8),
            bottomBorder.leadingAnchor.constraint(equalTo: userBio.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: userBio.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 0.2) // Set the height of the border
        ])
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
extension ViewControllerprofile: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.teams.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCell", for: indexPath) as! TeamCollectionViewCell8
        let team = user.teams[indexPath.row]
        cell.configure(with: team)
        return cell
    }
}

// MARK: - Table View DataSource & Delegate
extension ViewControllerprofile: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.feed.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCellvivek
        let feed = user.feed[indexPath.row]
        cell.configure(with: feed)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 351
    }
}

extension UIColor {
    convenience init(hex8: String) {
        var hexSanitized = hex8.trimmingCharacters(in: .whitespacesAndNewlines)
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
