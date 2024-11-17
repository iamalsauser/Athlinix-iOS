//
//  membersCollectionViewCell.swift
//  teamScreen
//
//  Created by admin65 on 15/11/24.
//

import UIKit

class membersCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var membersProfile: UIImageView!
    @IBOutlet weak var memberLabel: UILabel!
    
    func configure(with athlete: Athlete) {
        memberLabel.text = athlete.name
       // memberLabel.text = "@\(athlete.username)"
        membersProfile.image = UIImage(named: athlete.profileImage)
      }
    
}
