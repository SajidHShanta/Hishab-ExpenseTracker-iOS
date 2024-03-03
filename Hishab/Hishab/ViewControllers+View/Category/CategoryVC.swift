//
//  CategoryVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 29/2/24.
//

import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCategoryBtn: UIButton!
    
    var categories: [Category] = DataService.shared.categories {
        didSet {
            DataService.shared.saveCategories(categories)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    fileprivate func setupViews() {
        title = "Category"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        
        addCategoryBtn.layer.cornerRadius = 10
    }
    
    func editCategory(at index: Int) {
        let alertController = UIAlertController(title: "Edit Category", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Category Name"
            textField.text = self.categories[index].name
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            if let textField = alertController.textFields?.first, let text = textField.text {
                print("Entered Category Name: \(text)")
                self.categories[index].name = text
            }
        }
        alertController.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
