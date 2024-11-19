//
//  ApprovalCell.swift
//  RequestPage
//
//  Created by Vivek Jaglan on 11/18/24.
//

import UIKit
protocol ApprovalCellDelegate: AnyObject {
    func didTapApproveButton(at index: Int)
}

class ApprovalCell: UITableViewCell {

    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var statusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    weak var delegate: ApprovalCellDelegate?
        var index: Int?

        @IBAction func statusButtonTapped(_ sender: UIButton) {
            if let index = index {
                delegate?.didTapApproveButton(at: index)
            }
        }

}
