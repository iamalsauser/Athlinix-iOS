//
//  ViewController.swift
//  MATCHES
//
//  Created by admin65 on 15/11/24.
//

import UIKit

class UIkit: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var team1Logo: UIImageView!
    @IBOutlet weak var team2Logo: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    @IBOutlet weak var labelStackView: UIStackView!
    @IBOutlet weak var playerStackView: UITableView!
    
    @IBOutlet weak var playerLabel: UILabel!
    
    var selectedTeam: Team5!
    var stats: [(category: String, team1Value: Int, team2Value: Int)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerStackView.dataSource = self
        playerStackView.delegate = self
        
        // Calculate team scores
        let team1ScoreValue = (team1.gameStats.fieldGoals * 2) +
                              (team1.gameStats.threePointFieldGoals * 3) +
                              team1.gameStats.freeThrows
        let team2ScoreValue = (team2.gameStats.fieldGoals * 2) +
                              (team2.gameStats.threePointFieldGoals * 3) +
                              team2.gameStats.freeThrows
        
        // Set logos, names, and scores
        team1Logo.image = team1.teamLogo
        team2Logo.image = team2.teamLogo
        team1Name.text = team1.name
        team2Name.text = team2.name
        team1Score.text = "\(team1ScoreValue)"
        team2Score.text = "\(team2ScoreValue)"
        
        // Update segment control titles
        segmentedController.setTitle(team1.name, forSegmentAt: 0)
        segmentedController.setTitle(team2.name, forSegmentAt: 1)
        segmentedController.setTitle("Game Stats", forSegmentAt: 2)
        
        // Populate stats
        stats = [
            ("Field Goals", team1.gameStats.fieldGoals, team2.gameStats.fieldGoals),
            ("Free Throws", team1.gameStats.freeThrows, team2.gameStats.freeThrows),
            ("3P Field Goals", team1.gameStats.threePointFieldGoals, team2.gameStats.threePointFieldGoals),
            ("Total Rebounds", team1.gameStats.totalRebounds, team2.gameStats.totalRebounds),
            ("Assists", team1.gameStats.assists, team2.gameStats.assists),
            ("Fouls", team1.gameStats.fouls, team2.gameStats.fouls),
            ("Steals", team1.gameStats.steals, team2.gameStats.steals)
        ]
        
        // Set default team
        selectedTeam = team1
    }

        @IBAction func switchTableViewAction(_ sender: UISegmentedControl) {
            switch sender.selectedSegmentIndex {
                case 0, 1: // Team 1 or Team 2
                    labelStackView.isHidden = false
                    playerLabel.isHidden = false
                    playerStackView.isHidden = false
                    
                    // Update selectedTeam based on the selected segment
                    selectedTeam = sender.selectedSegmentIndex == 0 ? team1 : team2

                case 2: // Game Stats
                    labelStackView.isHidden = true
                    playerLabel.isHidden = true
                    playerStackView.isHidden = false

                default:
                    break
                }
            
                playerStackView.reloadData()
        }
        
        // UITableViewDataSource Methods
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch segmentedController.selectedSegmentIndex {
            case 0, 1:
                return selectedTeam.players.count
            case 2:
                return stats.count
            default:
                return 0
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = playerStackView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! playersStatsTableViewCell
            
            if segmentedController.selectedSegmentIndex == 2 {
                print("Stats count: \(stats.count)")
                for stat in stats {
                    print("Category: \(stat.category), Team1: \(stat.team1Value), Team2: \(stat.team2Value)")
                }
            }

            
            switch segmentedController.selectedSegmentIndex {
            case 0, 1: // Player stats
                let player = selectedTeam.players[indexPath.row]
                cell.resetCell() // Reset cell state
                cell.configure(with: player)
                cell.setCategoryView(hidden: true) // Hide category-related labels
            case 2: // Game stats
                let stat = stats[indexPath.row]
                cell.resetCell() // Reset cell state
                cell.configureCategoryCell(with: stat.category, team1Value: stat.team1Value, team2Value: stat.team2Value)
                cell.setPlayerView(hidden: true)
                // Hide player-related labels
                cell.setCategoryView(hidden: false)
            default:
                fatalError("Unhandled segment index")
            }
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
            return 45 
        }
    }
  
    //    }
    //
    //        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //            switch segmentedController.selectedSegmentIndex{
    //                case 0:
    //                    let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! playersStatsTableViewCell
    //                    cell.configure(with: selectedTeam.players[indexPath.row])
    //                cell.team1Score.isHidden = true
    //                cell.team2Score.isHidden = true
    //                cell.scoreCategory.isHidden = true
    //                       return cell
    //                case 1:
    //                    let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! playersStatsTableViewCell
    //
    //                    cell.configure(with: selectedTeam.players[indexPath.row])
    //                cell.team1Score.isHidden = true
    //                cell.team2Score.isHidden = true
    //                cell.scoreCategory.isHidden = true
    //                    return cell
    //
    //                case 2:
    //                    let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! playersStatsTableViewCell
    //
    //                    let stats1 = team1.gameStats // Team 1 stats
    //                    let stats2 = team2.gameStats   // Team 2 stats
    //
    //                        switch indexPath.row {
    //                            case 0:
    //                                cell.playerNameLabel.isHidden = true
    //                                cell.reboundsLabel.isHidden = true
    //                                cell.assistsLabel.isHidden = true
    //                                cell.foulsLabel.isHidden = true
    //                                cell.pointsLabel.isHidden = true
    //                                cell.configureCategoryCell(with: "Field Goals", team1Value: stats1.fieldGoals, team2Value: stats2.fieldGoals)
    //                            case 1:
    //                            cell.playerNameLabel.isHidden = true
    //                            cell.reboundsLabel.isHidden = true
    //                            cell.assistsLabel.isHidden = true
    //                            cell.foulsLabel.isHidden = true
    //                            cell.pointsLabel.isHidden = true
    //                                cell.configureCategoryCell(with: "Free Throws", team1Value: stats1.freeThrows, team2Value: stats2.freeThrows)
    //                            case 2:
    //                            cell.playerNameLabel.isHidden = true
    //                            cell.reboundsLabel.isHidden = true
    //                            cell.assistsLabel.isHidden = true
    //                            cell.foulsLabel.isHidden = true
    //                            cell.pointsLabel.isHidden = true
    //                                cell.configureCategoryCell(with: "3P Field Goals", team1Value: stats1.threePointFieldGoals, team2Value: stats2.threePointFieldGoals)
    //                            case 3:
    //                            cell.playerNameLabel.isHidden = true
    //                            cell.reboundsLabel.isHidden = true
    //                            cell.assistsLabel.isHidden = true
    //                            cell.foulsLabel.isHidden = true
    //                            cell.pointsLabel.isHidden = true
    //                                cell.configureCategoryCell(with: "Total Rebounds", team1Value: stats1.totalRebounds, team2Value: stats2.totalRebounds)
    //                            case 4:
    //                            cell.playerNameLabel.isHidden = true
    //                            cell.reboundsLabel.isHidden = true
    //                            cell.assistsLabel.isHidden = true
    //                            cell.foulsLabel.isHidden = true
    //                            cell.pointsLabel.isHidden = true
    //                                cell.configureCategoryCell(with: "Assists", team1Value: stats1.assists, team2Value: stats2.assists)
    //                            case 5:
    //                            cell.playerNameLabel.isHidden = true
    //                            cell.reboundsLabel.isHidden = true
    //                            cell.assistsLabel.isHidden = true
    //                            cell.foulsLabel.isHidden = true
    //                            cell.pointsLabel.isHidden = true
    //                                cell.configureCategoryCell(with: "Fouls", team1Value: stats1.fouls, team2Value: stats2.fouls)
    //                            case 6:
    //                            cell.playerNameLabel.isHidden = true
    //                            cell.reboundsLabel.isHidden = true
    //                            cell.assistsLabel.isHidden = true
    //                            cell.foulsLabel.isHidden = true
    //                            cell.pointsLabel.isHidden = true
    //                                cell.configureCategoryCell(with: "Steals", team1Value: stats1.steals, team2Value: stats2.steals)
    //                        default:
    //                                return cell
    //                                }
    //                                return cell
    //
    //                            default:
    //                                // Fallback case for Player-wise stats
    //                                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! playersStatsTableViewCell
    //                                let player = selectedTeam.players[indexPath.row]
    //                                cell.team1Score.isHidden = true
    //                                cell.team2Score.isHidden = true
    //                                cell.scoreCategory.isHidden = true
    //                                cell.configure(with: player)
    //                                return cell
    //                            }
    //
    //                        }
    //
    //    }
    //

