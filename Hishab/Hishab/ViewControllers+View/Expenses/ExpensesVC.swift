//
//  ExpensesVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import UIKit

class ExpensesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var expenses: [Transaction] = DataService.shared.transactions.filter { transaction in
        if let category = DataService.shared.categories.filter({ $0.id == transaction.categoryID }).first {
            return category.type == .expense
        } else {
            return false
        }
    } {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    fileprivate func setupViews() {
        title = "Expense History"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
    }
}
