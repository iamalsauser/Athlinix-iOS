//
//  coachCollectionViewCell.swift
//  teamScreen
//
//  Created by admin65 on 15/11/24.
//

import UIKit

class coachCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var coachProfile: UIImageView!
    @IBOutlet weak var coachName: UILabel!
    
    func configure(with coach: Coach) {
        coachName.text = coach.name
           // usernameLabel.text = "@\(coach.username)"
        coachProfile.image = UIImage(named: "coach")
        
        coachProfile.layer.cornerRadius = coachProfile.frame.width / 2
        coachProfile.layer.masksToBounds = true
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Ensures the corner radius is set after layout adjustments
        coachProfile.layer.cornerRadius = coachProfile.frame.width / 2
    }

}
