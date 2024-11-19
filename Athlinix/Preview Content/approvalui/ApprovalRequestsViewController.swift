import UIKit

class ApprovalRequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ApprovalCellDelegate {

    @IBOutlet weak var tableView: UITableView!

    // Static data
    var data = [
        ["team": "BFI", "opponent": "LAKER", "date": "Nov 2023", "status": "Approve", "image": "team1"],
        ["team": "BFI", "opponent": "LAKER", "date": "Nov 2023", "status": "Approve", "image": "team2"],
        ["team": "BFI", "opponent": "LAKER", "date": "Nov 2023", "status": "Approve", "image": "team3"],
        ["team": "BFI", "opponent": "LAKER", "date": "Nov 2023", "status": "Approved", "image": "team4"],
        ["team": "BFI", "opponent": "LAKER", "date": "Nov 2023", "status": "Approved", "image": "team1"],
        ["team": "BFI", "opponent": "LAKER", "date": "Nov 2023", "status": "Approve", "image": "team3"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up table view
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApprovalCell", for: indexPath) as! ApprovalCell
        
        let item = data[indexPath.row]
        cell.logoImageView.image = UIImage(named: item["image"]!)
        cell.logoImageView.layer.cornerRadius = cell.logoImageView.frame.size.width / 2
        cell.matchLabel.text = "\(item["team"]!) VS \(item["opponent"]!)"
        cell.dateLabel.text = item["date"]
        cell.statusButton.setTitle(item["status"], for: .normal)
        
        // Configure button color based on status
        if item["status"] == "Approve" {
            cell.statusButton.setTitleColor(.systemOrange, for: .normal)
            cell.statusButton.isEnabled = true
        } else {
            cell.statusButton.setTitleColor(.systemGray, for: .normal)
            cell.statusButton.isEnabled = false
        }

        // Set delegate and index
        cell.delegate = self
        cell.index = indexPath.row

        return cell
    }

    // Delegate method for "Approve" button tap
    func didTapApproveButton(at index: Int) {
        // Ensure the index is valid
        guard index < data.count else {
            print("Error: Index out of range")
            return
        }
        
        // Update the status to "Approved"
        data[index]["status"] = "Approved"

        // Reload the specific row
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    // Enable swipe to delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // Handle the deletion of a row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the item from the data array
            data.remove(at: indexPath.row)
            
            // Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Reload the table to update indices
            tableView.reloadData()
        }
    }
}
