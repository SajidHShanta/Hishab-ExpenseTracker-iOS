//
//  TransactionTableViewCell.swift
//  Hishab
//
//  Created by Sajid Shanta on 22/2/24.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(transaction: Transaction) {
        if let category = DataService.shared.categories.filter({ $0.id == transaction.categoryID}).first {
            categoryName.text = category.name
            
            noteLabel.text = transaction.note
            amountLabel.text = "\(transaction.amount)"
            dateLabel.text = DateFormatter.localizedString(from: transaction.date, dateStyle: .medium, timeStyle: .none)
            
            switch category.type {
            case .income:
                containerView.backgroundColor = UIColor(named: "Green Light")
                amountLabel.text = "+ \(transaction.amount)"
                amountLabel.textColor = UIColor(named: "Green Dark")
                imgView.image = UIImage(named: "up")
            case .expense:
                containerView.backgroundColor = UIColor(named: "Red Light")
                amountLabel.text = "- \(transaction.amount)"
                amountLabel.textColor = UIColor(named: "Red Dark")
                imgView.image = UIImage(named: "down")
            }
            
        } else {
            self.isHidden = true
            //TODO: Show Eror
            print("No category found for transaction id: \(transaction.id)")
        }
    }
}
