//
//  TransactionTableViewCell.swift
//  Hishab
//
//  Created by Sajid Shanta on 22/2/24.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
