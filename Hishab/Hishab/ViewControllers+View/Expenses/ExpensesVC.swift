//
//  ExpensesVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import UIKit

class ExpensesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!

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
