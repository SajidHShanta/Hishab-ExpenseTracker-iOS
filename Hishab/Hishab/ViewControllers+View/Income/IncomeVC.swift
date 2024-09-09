//
//  IncomeVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import UIKit

class IncomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var incoms: [Transaction] = DataService.shared.transactions.filter { transaction in
        if let category = DataService.shared.categories.filter({ $0.id == transaction.categoryID }).first {
            return category.type == .income
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
        title = "Income History"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
    }
}
