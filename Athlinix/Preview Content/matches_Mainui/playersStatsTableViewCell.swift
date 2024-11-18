//
//  playersStatsTableViewCell.swift
//  MATCHES
//
//  Created by admin65 on 16/11/24.
//

import UIKit

class playersStatsTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
        @IBOutlet weak var playerNameLabel: UILabel!
        @IBOutlet weak var reboundsLabel: UILabel!
        @IBOutlet weak var assistsLabel: UILabel!
        @IBOutlet weak var foulsLabel: UILabel!
        @IBOutlet weak var pointsLabel: UILabel!
    
    
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var scoreCategory: UILabel!
    
    
    // MARK: - Reset Cell State
        func resetCell() {
            playerNameLabel.text = nil
            reboundsLabel.text = nil
            assistsLabel.text = nil
            foulsLabel.text = nil
            pointsLabel.text = nil
            team1Score.text = nil
            team2Score.text = nil
            scoreCategory.text = nil
            setPlayerView(hidden: false)
          setCategoryView(hidden: false)
        }
        
        // MARK: - Cell Configuration
        func configure(with player: PlayerStats5) {
            playerNameLabel.text = player.playerName
            reboundsLabel.text = "\(player.rebounds)"
            assistsLabel.text = "\(player.assists)"
            foulsLabel.text = "\(player.fouls)"
            pointsLabel.text = "\(player.points)"
        }
        
        func configureCategoryCell(with category: String, team1Value: Int, team2Value: Int) {
            scoreCategory.text = category
            team1Score.text = "\(team1Value)"
            team2Score.text = "\(team2Value)"
        }
        
        // MARK: - Show/Hide Methods
        func setCategoryView(hidden: Bool) {
            team1Score.isHidden = hidden
            team2Score.isHidden = hidden
            scoreCategory.isHidden = hidden
        }
        
        func setPlayerView(hidden: Bool) {
            playerNameLabel.isHidden = hidden
            reboundsLabel.isHidden = hidden
            assistsLabel.isHidden = hidden
            foulsLabel.isHidden = hidden
            pointsLabel.isHidden = hidden
        }
    
   }


