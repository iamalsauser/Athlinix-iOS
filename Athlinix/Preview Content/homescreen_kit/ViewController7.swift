//
//  ViewController.swift
//  Home
//
//  Created by admin65 on 18/11/24.
//

import UIKit
import SwiftUI
class ViewControllerhome: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
//    @objc func floatingButtonTapped() {
//            // Assuming you are using a SwiftUI ViewController as a container for SwiftUI content
//        if let contentView = UIHostingController(rootView: homescreenstoryboard()) as? homescreenstoryboard {
//                // Trigger the state change in ContentView to show the action sheet
//                contentView.showingActionSheet = true
//            }
//        }
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ppgLabel: UILabel!
    @IBOutlet weak var bpgLabel: UILabel!
    @IBOutlet weak var astLabel: UILabel!
    
    @IBOutlet weak var pointsScoredImageView: UIView!
    @IBOutlet weak var seeAnalyticsButton: UILabel!
    @IBOutlet weak var pointsScoredBarGraphView: UIView!
    
    @IBOutlet weak var pinnedMatchesView: UIView!
    @IBOutlet weak var pinnedMatchesCardView: UIView!
    @IBOutlet weak var team2ImageView: UIImageView!
    @IBOutlet weak var team2Name: UILabel!
    @IBOutlet weak var team1ImageView: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team12ptfgs: UILabel!
    @IBOutlet weak var team13ptfgs: UILabel!
    @IBOutlet weak var team1FreeThrows: UILabel!
    @IBOutlet weak var team22ptfgs: UILabel!
    @IBOutlet weak var team23ptfgs: UILabel!
    @IBOutlet weak var team2FreeThrows: UILabel!
    
    
    @IBOutlet weak var highlightCardView: UIView!
    @IBOutlet weak var highlightImageView: UIImageView!
    @IBOutlet weak var highlightGameName: UILabel!
    @IBOutlet weak var highlightDate: UILabel!
    
    
    @IBOutlet weak var athletesCollectionView: UICollectionView!
    
    @IBOutlet weak var matchesPlayedvsPointsScoredView: UIView!
    
    @IBOutlet weak var matchesPlayedvsPointsScoredBarGraphView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.layer.cornerRadius = 16
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showAllStatsView))
            seeAnalyticsButton.isUserInteractionEnabled = true
            seeAnalyticsButton.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        if let athlete = userStats.first {
               userNameLabel.text = athlete.name
               profileImageView.image = UIImage(named: athlete.profilePicture)
               ppgLabel.text = String(format: "%.1f PPG", athlete.ppg)
               bpgLabel.text = String(format: "%.1f BPG", athlete.bpg)
               astLabel.text = String(format: "%.1f AST", athlete.ast)
           }
           
           setupPointsScoredGraph()
           setupMatchesPlayedVsPointsScoredGraph()
        
        let viewsToStyle = [pointsScoredImageView, pinnedMatchesCardView, matchesPlayedvsPointsScoredView]
            
            for view in viewsToStyle {
                view?.layer.borderColor = UIColor.lightGray.cgColor
                view?.layer.borderWidth = 1.0 // Thickness of the border
                view?.layer.cornerRadius = 8 // Optional: Rounded corners
                view?.clipsToBounds = true
            }
        
        // Example Teams
        let team1 = TeamHome(name: "LA Lakers",
                                 image: UIImage(named: "lakers")!,
                                 twoPointFieldGoals: 47,
                                 threePointFieldGoals: 10,
                                 freeThrows: 6)
                
        let team2 = TeamHome(name: "BFI",
                                 image: UIImage(named: "cavs")!,
                                 twoPointFieldGoals: 47,
                                 threePointFieldGoals: 7,
                                 freeThrows: 3)
                
                // Configure UI
                configurePinnedMatch(team1: team1, team2: team2)
        
//        let floatingButton = UIButton(type: .system)
//                floatingButton.frame = CGRect(x: view.frame.width - 30 - 70, y: view.frame.height - 180 - 70, width: 70, height: 70)
//                floatingButton.layer.cornerRadius = 35 // Half of width/height to make it circular
//                floatingButton.backgroundColor = UIColor.systemOrange
//                floatingButton.setTitle("+", for: .normal)
//                floatingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
//                floatingButton.setTitleColor(.white, for: .normal)
//
//                // Add shadow for better visibility
//                floatingButton.layer.shadowColor = UIColor.black.cgColor
//                floatingButton.layer.shadowOpacity = 0.3
//                floatingButton.layer.shadowOffset = CGSize(width: 0, height: 2)
//                floatingButton.layer.shadowRadius = 4
//
//                // Add target action for the button
//                floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
//
//                // Add the button to the view
//                view.addSubview(floatingButton)
//        let hostingController = UIHostingController(rootView: homescreenstoryboard())
//                addChild(hostingController)
//                hostingController.view.frame = view.bounds
//                view.addSubview(hostingController.view)
//                hostingController.didMove(toParent: self)



        setupHeader()
        setupPointsScoredSection()
        setupPinnedMatches()
        setupHighlightSection()
        setupHighlightSection()
        setupAthletesCollectionView()
        setupMatchesPlayedvsPointsScoredSection()
    }
    
    func configurePinnedMatch(team1: TeamHome, team2: TeamHome) {
            // Set Team 1 details
            team1ImageView.image = team1.image
            team1Name.text = team1.name
            team12ptfgs.text = "\(team1.twoPointFieldGoals)"
            team13ptfgs.text = "\(team1.threePointFieldGoals)"
            team1FreeThrows.text = "\(team1.freeThrows)"
            
            // Set Team 2 details
            team2ImageView.image = team2.image
            team2Name.text = team2.name
            team22ptfgs.text = "\(team2.twoPointFieldGoals)"
            team23ptfgs.text = "\(team2.threePointFieldGoals)"
            team2FreeThrows.text = "\(team2.freeThrows)"
        }
    
    // MARK: - Setup Header
    private func setupHeader() {
        guard let athlete = userStats.first else {
            print("No user stats available.")
            return
        }

        // Configure the header view
        headerView.layer.cornerRadius = 24
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true

        // Set data dynamically from `userStats`
        userNameLabel.text = athlete.name
        ppgLabel.text = "\(athlete.ppg)"
        bpgLabel.text = "\(athlete.bpg)"
        astLabel.text = "\(athlete.ast)"

        // Set profile picture (ensure the image exists in your assets)
        if let profileImage = UIImage(named: athlete.profilePicture) {
            profileImageView.image = profileImage
        } else {
            profileImageView.image = UIImage(named: "placeholder") // Fallback image
        }
    }
        // MARK: - Points Scored Section
        private func setupPointsScoredSection() {
//            pointsScoredBarGraphView.backgroundColor = UIColor.orange.withAlphaComponent(0.2) // Placeholder bar graph
            pointsScoredBarGraphView.layer.cornerRadius = 8
        }
        
        // MARK: - Pinned Matches
        private func setupPinnedMatches() {
            pinnedMatchesCardView.layer.cornerRadius = 12
            pinnedMatchesCardView.layer.shadowColor = UIColor.black.cgColor
            pinnedMatchesCardView.layer.shadowOpacity = 0.1
            pinnedMatchesCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
            pinnedMatchesCardView.layer.shadowRadius = 8
        }
        
        // MARK: - Highlight Section
        private func setupHighlightSection() {
            highlightCardView.layer.cornerRadius = 24
            highlightCardView.layer.shadowColor = UIColor.black.cgColor
            highlightCardView.layer.shadowOpacity = 0.1
            highlightCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
            highlightCardView.layer.shadowRadius = 8
            highlightImageView.image = UIImage(named: "highlight") // Add a placeholder image
            highlightGameName.text = "LA vs Knicks"
            highlightDate.text = "Nov '24"
        }
        
        // MARK: - Athletes Collection View
        private func setupAthletesCollectionView() {
            athletesCollectionView.delegate = self
            athletesCollectionView.dataSource = self
        }
        
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return athleteStats.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AthletesCell", for: indexPath) as! athletesCollectionViewCell
        let athlete = athleteStats[indexPath.row]
        cell.configure(with: athlete)
        return cell
    }
    
    func setupPointsScoredGraph() {
        guard let athlete = userStats.first else { return }

        pointsScoredBarGraphView.clipsToBounds = true // Ensure content stays within the view
        let barWidth: CGFloat = 20
        let spacing: CGFloat = 10
        let graphHeight: CGFloat = pointsScoredBarGraphView.bounds.height - 20 // Leave padding for labels
        let maxPoints: CGFloat = 150 // Maximum points for scaling
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"] // Month names

        // Add Grid Lines
        let numberOfGridLines = 5
        for i in 0...numberOfGridLines {
            let yPosition = graphHeight - (graphHeight / CGFloat(numberOfGridLines) * CGFloat(i))
            
            let gridLine = UIView(frame: CGRect(x: 0, y: yPosition, width: pointsScoredBarGraphView.bounds.width, height: 1))
            gridLine.backgroundColor = .lightGray.withAlphaComponent(0.3)
            pointsScoredBarGraphView.addSubview(gridLine)
            
            // Add Labels for Grid Values
            let valueLabel = UILabel(frame: CGRect(x: 0, y: yPosition - 8, width: 30, height: 15))
            valueLabel.text = "\(Int(maxPoints / CGFloat(numberOfGridLines) * CGFloat(i)))"
            valueLabel.font = UIFont.systemFont(ofSize: 10)
            valueLabel.textAlignment = .right
            valueLabel.textColor = .gray
            pointsScoredBarGraphView.addSubview(valueLabel)
        }

        // Add Bars and Month Labels
        let graphWidth = pointsScoredBarGraphView.bounds.width
        let totalSpacing = CGFloat(athlete.pointsScoredMonthly.count - 1) * spacing
        let totalBarWidth = CGFloat(athlete.pointsScoredMonthly.count) * barWidth
        let totalWidth = totalSpacing + totalBarWidth
        let xOffset = (graphWidth - totalWidth) / 2 // Center the graph horizontally
        
        for (index, points) in athlete.pointsScoredMonthly.enumerated() {
            let barHeight = graphHeight * CGFloat(points) / maxPoints
            let barX = xOffset + CGFloat(index) * (barWidth + spacing)
            
            // Create Bar
            let barView = UIView(frame: CGRect(x: barX, y: graphHeight - barHeight, width: barWidth, height: barHeight))
            barView.backgroundColor = .systemOrange
            barView.layer.cornerRadius = 4
            pointsScoredBarGraphView.addSubview(barView)
            
            // Add Month Label
            if index < months.count {
                let monthLabel = UILabel(frame: CGRect(x: barX - 5, y: graphHeight + 5, width: barWidth + 10, height: 15))
                monthLabel.text = months[index]
                monthLabel.font = UIFont.systemFont(ofSize: 10)
                monthLabel.textAlignment = .center
                monthLabel.textColor = .gray
                pointsScoredBarGraphView.addSubview(monthLabel)
            }
        }
    }
    func setupMatchesPlayedVsPointsScoredGraph() {
        guard let athlete = userStats.first else { return }

        matchesPlayedvsPointsScoredBarGraphView.clipsToBounds = true // Ensure content stays within the view
        let groupSpacing: CGFloat = 40
        let barWidth: CGFloat = 30
        let barSpacing: CGFloat = 10
        let graphHeight: CGFloat = matchesPlayedvsPointsScoredBarGraphView.bounds.height - 20 // Padding for labels
        let maxPoints: CGFloat = 500 // Maximum points for scaling
        let graphWidth = matchesPlayedvsPointsScoredBarGraphView.bounds.width

        // Data for matches vs points scored
        let matchesData = [athlete.tournamentsPlayed, athlete.standAloneMatchesPlayed]
        let pointsData = [athlete.totalTournamentPoints, athlete.totalStandAlonePoints]
        let groupLabels = ["Tournaments", "Stand-Alone"]

        // Calculate starting x offset for centering
        let totalGroupWidth = CGFloat(groupLabels.count) * (2 * barWidth + barSpacing + groupSpacing) - groupSpacing
        let xOffset = (graphWidth - totalGroupWidth) / 2

        // Add Grid Lines
        let numberOfGridLines = 5
        for i in 0...numberOfGridLines {
            let yPosition = graphHeight - (graphHeight / CGFloat(numberOfGridLines) * CGFloat(i))
            
            let gridLine = UIView(frame: CGRect(x: 0, y: yPosition, width: matchesPlayedvsPointsScoredBarGraphView.bounds.width, height: 1))
            gridLine.backgroundColor = .lightGray.withAlphaComponent(0.3)
            matchesPlayedvsPointsScoredBarGraphView.addSubview(gridLine)
            
            // Add Labels for Grid Values
            let valueLabel = UILabel(frame: CGRect(x: 0, y: yPosition - 8, width: 30, height: 15))
            valueLabel.text = "\(Int(maxPoints / CGFloat(numberOfGridLines) * CGFloat(i)))"
            valueLabel.font = UIFont.systemFont(ofSize: 10)
            valueLabel.textAlignment = .right
            valueLabel.textColor = .gray
            matchesPlayedvsPointsScoredBarGraphView.addSubview(valueLabel)
        }

        // Add Bars
        for (groupIndex, label) in groupLabels.enumerated() {
            let groupStartX = xOffset + CGFloat(groupIndex) * (2 * barWidth + barSpacing + groupSpacing)
            
            // Matches Bar
            let matchesHeight = graphHeight * CGFloat(matchesData[groupIndex]) / maxPoints
            let matchesBarX = groupStartX
            let matchesBarView = UIView(frame: CGRect(x: matchesBarX, y: graphHeight - matchesHeight, width: barWidth, height: matchesHeight))
            matchesBarView.backgroundColor = .systemBlue
            matchesBarView.layer.cornerRadius = 4
            matchesPlayedvsPointsScoredBarGraphView.addSubview(matchesBarView)
            
            // Points Bar
            let pointsHeight = graphHeight * CGFloat(pointsData[groupIndex]) / maxPoints
            let pointsBarX = groupStartX + barWidth + barSpacing
            let pointsBarView = UIView(frame: CGRect(x: pointsBarX, y: graphHeight - pointsHeight, width: barWidth, height: pointsHeight))
            pointsBarView.backgroundColor = .systemOrange
            pointsBarView.layer.cornerRadius = 4
            matchesPlayedvsPointsScoredBarGraphView.addSubview(pointsBarView)
            
            // Add Group Label
            let groupLabel = UILabel(frame: CGRect(x: groupStartX, y: graphHeight + 5, width: 2 * barWidth + barSpacing, height: 20))
            groupLabel.text = label
            groupLabel.font = UIFont.systemFont(ofSize: 12)
            groupLabel.textAlignment = .center
            groupLabel.textColor = .gray
            matchesPlayedvsPointsScoredBarGraphView.addSubview(groupLabel)
        }
    }
    @objc func showAllStatsView() {
        let allStatsView = /*AllStatsViewstat()*/analysisuikit() // Assuming this is a SwiftUI View
        let hostingController = UIHostingController(rootView: allStatsView)
        hostingController.modalPresentationStyle = .pageSheet
        present(hostingController, animated: true, completion: nil)
    }
//    @objc func floatingButtonTapped() {
//        print("Floating button tapped!")
//    }

    
    private func setupMatchesPlayedvsPointsScoredSection() {
           //matchesPlayedvsPointsScoredBarGraphView.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.2)
        
        // Placeholder bar graph
          // matchesPlayedvsPointsScoredBarGraphView.layer.cornerRadius = 8
       }
}

