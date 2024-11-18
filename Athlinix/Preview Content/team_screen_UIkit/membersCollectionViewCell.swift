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
        membersProfile.image = UIImage(named: "profile")
        
        // Make image fully rounded
        membersProfile.layer.cornerRadius = membersProfile.frame.width / 2
        membersProfile.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Ensures the corner radius is set after layout adjustments
        membersProfile.layer.cornerRadius = membersProfile.frame.width / 2
    }
}
