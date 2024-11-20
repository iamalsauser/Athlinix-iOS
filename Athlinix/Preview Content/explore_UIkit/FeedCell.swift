//
//  FeedCell.swift
//  explore
//
//  Created by admin65 on 17/11/24.
//

import UIKit

class FeedCell: UITableViewCell {
    // Outlets for the UI elements
    @IBOutlet weak var athleteNameLabel: UILabel!      // Displays the athlete's name
    @IBOutlet weak var profileImageView: UIImageView!  // Displays the athlete's profile picture
    @IBOutlet weak var teamNameLabel: UILabel!         // Displays the team name
    @IBOutlet weak var teamLogoImageView: UIImageView! // Displays the team logo
    @IBOutlet weak var locationLabel: UILabel!         // Displays the location
    @IBOutlet weak var likeCountLabel: UILabel!        // Displays the like count
    @IBOutlet weak var imageView1: UIImageView!        // First feed image
    @IBOutlet weak var imageView2: UIImageView!        // Second feed image
    @IBOutlet weak var imageView3: UIImageView!        // Third feed image
    @IBOutlet weak var likeButton: UIButton!
    
    // Configure method to set up the cell's content
    private var isLiked: Bool = false
    
    func configure(with feed: Feed) {
        athleteNameLabel.text = feed.athleteName
        profileImageView.image = feed.athleteProfile
        teamNameLabel.text = feed.teamName
        teamLogoImageView.image = feed.teamLogo
        locationLabel.text = feed.location
//        likeCountLabel.text = "\(feed.likeCount) likes"
        imageView1.image = feed.image1
        imageView2.image = feed.image2
        imageView3.image = feed.image3
//        updateLikeButtonAppearance()
        
        // Apply rounded corners
        makeImagesRounded()
    }
    
    private func makeImagesRounded() {
        // Round profile image and team logo
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.masksToBounds = true
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.width / 2
        teamLogoImageView.layer.masksToBounds = true
        
        // Round the feed images
        imageView1.layer.cornerRadius = 8 // Adjust radius as needed
        imageView1.layer.masksToBounds = true
        
        imageView2.layer.cornerRadius = 8 // Adjust radius as needed
        imageView2.layer.masksToBounds = true
        
        imageView3.layer.cornerRadius = 8 // Adjust radius as needed
        imageView3.layer.masksToBounds = true
    }
    
//    @IBAction func likeButtonTapped(_ sender: UIButton) {
//        isLiked.toggle() // Toggle the liked state
//        updateLikeButtonAppearance() // Update the button's appearance
//    }

    // Method to update the button's appearance
//    private func updateLikeButtonAppearance() {
//        if isLiked {
//            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) // Filled heart icon
//        } else {
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal) // Outline heart icon
//        }
//    }
}
