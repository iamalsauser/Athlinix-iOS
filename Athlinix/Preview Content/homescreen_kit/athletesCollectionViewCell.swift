//
//  athletesCollectionViewCell.swift
//  Home
//
//  Created by admin65 on 18/11/24.
//

import UIKit

class athletesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var athleteProfileImageView: UIImageView!
    
    @IBOutlet weak var athleteNameLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        athleteProfileImageView.layer.cornerRadius = athleteProfileImageView.frame.width / 2
        athleteProfileImageView.clipsToBounds = true
        
        self.layer.cornerRadius = 8
                self.layer.masksToBounds = true
                
                // Optional: Add a shadow for visual effect (if needed)
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOpacity = 0.1
                self.layer.shadowOffset = CGSize(width: 0, height: 2)
                self.layer.shadowRadius = 4
        }
    
    func configure(with stats: AthleteMainStats) {
        athleteProfileImageView.image = UIImage(named: stats.profilePicture)
        athleteNameLabel.text = stats.username
        athleteNameLabel.text = stats.name
    }

}
