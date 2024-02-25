//
//  HistoryVC+TableView.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import UIKit

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        cell.selectionStyle = .none
        cell.populateData(transaction: self.transactions[indexPath.row])
        return cell
    }
}
