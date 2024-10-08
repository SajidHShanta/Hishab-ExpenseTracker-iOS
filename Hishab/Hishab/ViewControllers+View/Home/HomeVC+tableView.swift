//
//  HomeVC+tableView.swift
//  Hishab
//
//  Created by Sajid Shanta on 22/2/24.
//

import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DataService.shared.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        cell.selectionStyle = .none
        cell.populateData(transaction: DataService.shared.transactions[indexPath.row])
        return cell
    }
}
