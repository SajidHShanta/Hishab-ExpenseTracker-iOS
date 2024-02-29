//
//  CategoryTableViewCell.swift
//  Hishab
//
//  Created by Sajid Shanta on 29/2/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var editBtn: UIImageView!
    @IBOutlet weak var deleteBtn: UIImageView!
    
    var editClosure: (() -> Void)?
    var deleteClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        editBtn.isUserInteractionEnabled = true
        let editTap = UITapGestureRecognizer(target: self, action: #selector(editCategory))
        editBtn.addGestureRecognizer(editTap)
        
        deleteBtn.isUserInteractionEnabled = true
        let deleteTap = UITapGestureRecognizer(target: self, action: #selector(deleteCategory))
        deleteBtn.addGestureRecognizer(deleteTap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(category: Category) {
        self.categoryNameLabel.text = category.name
        self.typeLabel.text = category.type.name
    }
    
    @objc func editCategory() {
        editClosure?()
    }
    
    @objc func deleteCategory() {
        deleteClosure?()
    }
}
