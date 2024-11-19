import UIKit

class TeamCollectionViewCell8: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    func configure(with team: Team8) {
            teamName.text = team.teamName
            teamImage.image = team.teamLogo
        }
}
