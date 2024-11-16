//
//  MatchTableViewCell.swift
//  MatchHistory
//
//  Created by admin65 on 14/11/24.
//

import UIKit

class MatchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var homeFieldGoalsLabel: UILabel!
    @IBOutlet weak var homeThreePointersLabel: UILabel!
    @IBOutlet weak var homeFreeThrowsLabel: UILabel!
    @IBOutlet weak var awayFieldGoalsLabel: UILabel!
    @IBOutlet weak var awayThreePointersLabel: UILabel!
    @IBOutlet weak var awayFreeThrowsLabel: UILabel!
    
    
    
    func configure(with match: Matchkit) {
        homeTeamLogo.image = match.homeTeamLogo
        awayTeamLogo.image = match.awayTeamLogo
        
        homeTeamNameLabel.text = match.homeTeamName
        awayTeamNameLabel.text = match.awayTeamName
        
        homeFieldGoalsLabel.text = "\(match.fieldGoals.home)"
        homeThreePointersLabel.text = "\(match.threePointers.home)"
        homeFreeThrowsLabel.text = "\(match.freeThrows.home)"
        
        awayFieldGoalsLabel.text = "\(match.fieldGoals.away)"
        awayThreePointersLabel.text = "\(match.threePointers.away)"
        awayFreeThrowsLabel.text = "\(match.freeThrows.away)"
    }
}
