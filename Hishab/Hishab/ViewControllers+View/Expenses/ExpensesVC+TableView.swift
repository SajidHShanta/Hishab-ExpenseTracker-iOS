//
//  ExpensesVC+TableView.swift
//  Hishab
//
//  Created by Sajid Shanta on 25/2/24.
//

import UIKit

extension ExpensesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        cell.selectionStyle = .none
        cell.populateData(transaction: self.expenses[indexPath.row])
        return cell
    }
}
