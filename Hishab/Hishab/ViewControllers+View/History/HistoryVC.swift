//
//  HistoryVC.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var transactions = DataService.shared.transactions {
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
        title = "Transaction History"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
    }
}
