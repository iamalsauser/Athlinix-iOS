//
//  TeamCollectionViewCell.swift
//  profile
//
//  Created by admin65 on 18/11/24.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    func configure(with team: Team6) {
            teamName.text = team.teamName
            teamImage.image = team.teamLogo
        }
}
