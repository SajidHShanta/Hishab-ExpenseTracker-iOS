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
        noteLabel.text = transaction.note
        amountLabel.text = "\(transaction.amount)"
        
        let dateString = transaction.date
     
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        // Attempt to convert the date string to a Date object
        if let date = dateFormatter.date(from: dateString) {
//            print(date)
            let formattedDateString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
//            print(formattedDateString)
            dateLabel.text = formattedDateString
        } else {
            print("Failed to convert date string.")
            dateLabel.text = ""
        }
        

        
        if let category = DataService.shared.categories.filter({ $0.id == transaction.categoryID}).first {
            categoryName.text = category.name
            
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
            //TODO: Show Eror
            print("No category found for transaction id: \(transaction.id)")
            
            categoryName.text = "Other"
        }
    }
}
