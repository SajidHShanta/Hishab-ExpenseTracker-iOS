//
//  CategoryVC+TableView.swift
//  Hishab
//
//  Created by Sajid Shanta on 29/2/24.
//

import UIKit

extension CategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.selectionStyle = .none
        cell.populateData(category: self.categories[indexPath.row])
        cell.editClosure = { [weak self] in
            guard let self = self else { return }
            print(categories[indexPath.row])
            self.editCategory(at: indexPath.row)
        }
        cell.deleteClosure = { [weak self] in
            guard let self = self else { return }
            print(categories[indexPath.row])
            self.deleteCategory(at: indexPath.row)
        }
        return cell
    }
}
